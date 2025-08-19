#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
bambu_bus_simulator_statemachine.py - Bambu-Bus Simulator & Monitor (v5 - State Machine)

This script acts as both a monitor for all bus traffic and a simulator for a
custom device at address 0x10. This version uses a fast and efficient state
machine for packet parsing, just like a real microcontroller would, making it
robust for live data streams.

What it does:
1.  **Monitors:** Decodes and prints ALL standard packets sent between
    any devices on the bus using a high-speed state machine.
2.  **Simulates:** When it detects a G-code command sent specifically to
    address 0x10 (via M971), it pauses and waits for user input.
3.  **Handshakes:** When the user presses Enter, it sends the "Resume"
    packet (impersonating the AP board) back to the Main Controller (MC)
    to continue the G-code script.
4.  **Diagnostics:** Includes a heartbeat to confirm the script is running.

Prerequisites:
- Python 3
- pyserial library (`pip install pyserial`)
- An RS-485 to USB adapter connected to the Bambu-Bus.

Usage:
    python bambu_bus_simulator_statemachine.py --port YOUR_SERIAL_PORT
"""

import argparse
import sys
import time
import struct
from typing import Optional, Dict, Any

try:
    import serial
    from serial.serialutil import SerialException
except ImportError:
    print("ERROR: pyserial is required. Please install it with: pip install pyserial", file=sys.stderr)
    sys.exit(1)

# --- Constants & Mappings ---
ADDRESS_NAMES = {
    0x01: "SYS", 0x02: "UI", 0x03: "MC", 0x06: "AP", 0x07: "AMS",
    0x08: "TH", 0x09: "EXT", 0x0A: "NFC", 0x0B: "CAM", 0x0C: "WIFI",
    0x0D: "AMS_HUB", 0x0E: "AMS_RFID", 0x0F: "AMS_MOTOR",
    0x10: "OUR_DEVICE_ADDRESS" # Our simulated device address
}

OUR_DEVICE_ADDRESS = 0x10;

PTYPE_NAMES = {
    0x01: "ACK", 0x02: "NAK", 0x03: "VERSION", 0x04: "RESET", 0x05: "STATUS",
    0x06: "CONFIG", 0x07: "CONTROL", 0x08: "MOTOR", 0x09: "SENSOR",
    0x0A: "FILE_XFER", 0x0B: "LOG", 0x0C: "DEBUG", 0x0D: "GCODE"
}

# --- CRC Calculation ---
CRC16_XMODEM_TABLE = [
    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7, 0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
    0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6, 0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
    0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485, 0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
    0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4, 0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
    0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823, 0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
    0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12, 0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
    0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41, 0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
    0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70, 0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
    0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f, 0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
    0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e, 0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
    0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d, 0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
    0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c, 0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
    0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab, 0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
    0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a, 0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
    0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9, 0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
    0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8, 0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
]

def crc16_xmodem(data: bytes) -> int:
    crc = 0
    for byte in data:
        crc = (crc << 8) ^ CRC16_XMODEM_TABLE[((crc >> 8) ^ byte) & 0xFF]
    return crc & 0xFFFF

# --- Packet Building and Parsing ---

def build_standard_packet(dest: int, src: int, ptype: int, seq: int, payload: bytes) -> bytes:
    """Constructs a complete, sendable standard (0x3D) packet."""
    header = struct.pack('<BBB', dest, src, (seq << 4) | ptype)
    data_to_crc = header + payload
    crc = crc16_xmodem(data_to_crc)
    crc_bytes = struct.pack('<H', crc)
    frame_content = data_to_crc + crc_bytes
    
    stuffed_content = bytearray()
    for byte in frame_content:
        if byte == 0x7D or byte == 0x3D:
            stuffed_content.append(0x7D)
            stuffed_content.append(byte ^ 0x20)
        else:
            stuffed_content.append(byte)
            
    sof = b'\x3d'
    length = struct.pack('<B', len(stuffed_content))
    return sof + length + stuffed_content

def parse_frame_content(frame_content: bytes) -> Optional[Dict[str, Any]]:
    """Validates, de-stuffs, and parses the inner content of a bus frame."""
    if len(frame_content) < 2: return None
    expected_crc = int.from_bytes(frame_content[-2:], 'little')
    data_to_check = frame_content[:-2]
    if crc16_xmodem(data_to_check) != expected_crc: return None

    payload = bytearray()
    i = 0
    while i < len(data_to_check):
        if data_to_check[i] == 0x7D:
            if i + 1 < len(data_to_check):
                payload.append(data_to_check[i+1] ^ 0x20)
                i += 2
            else: return None 
        else:
            payload.append(data_to_check[i])
            i += 1
    
    if len(payload) < 3: return None
    dest, src, ptype, seq = payload[0], payload[1], payload[2] & 0x0F, (payload[2] & 0xF0) >> 4
    data_payload = payload[3:]

    return {"dest": dest, "src": src, "ptype": ptype, "seq": seq, "payload": data_payload}

def find_and_decode_packet(buffer: bytearray) -> Optional[Dict[str, Any]]:
    """
    Finds and decodes the first valid packet in the buffer. Consumes data
    from the buffer as it scans.
    """
    while len(buffer) > 0:
        # Find the first start of frame marker
        try:
            sof_idx = buffer.find(b'\x3d')
        except ValueError:
            sof_idx = -1

        if sof_idx == -1: # No SOF found in the buffer
            buffer.clear() # Discard all current data
            return None

        # Discard any garbage data before the SOF
        if sof_idx > 0:
            del buffer[:sof_idx]

        # Check if we have enough data for a header (SOF + 1-byte length)
        if len(buffer) < 2:
            return None # Incomplete header, wait for more data

        frame_len = buffer[1]
        
        # Check if the complete frame is in the buffer
        if len(buffer) < 2 + frame_len:
            return None # Incomplete frame, wait for more data

        # A full potential frame is in the buffer, extract and try to parse
        frame_content = buffer[2 : 2 + frame_len]
        packet = parse_frame_content(frame_content)
        
        # Always consume the bytes for this frame from the buffer
        del buffer[:2 + frame_len]

        if packet:
            return packet # Success, return the parsed packet
        else:
            # It was a false positive or corrupted frame. Loop again to find the next SOF.
            continue
    
    return None

# --- Main Simulator Logic ---

def main():
    parser = argparse.ArgumentParser(description="Bambu-Bus Device Simulator & Monitor (State Machine Version)")
    parser.add_argument("--port", required=True, help="Serial port for the RS-485 adapter (e.g., COM5 or /dev/ttyUSB0)")
    parser.add_argument("--baud", type=int, default=1228800, help="Baud rate")
    args = parser.parse_args()

    try:
        ser = serial.Serial(args.port, args.baud, parity=serial.PARITY_EVEN, timeout=0.05)
        print(f"Successfully opened serial port {args.port}")
    except SerialException as e:
        print(f"ERROR: Could not open serial port '{args.port}': {e}", file=sys.stderr)
        sys.exit(1)

    print("Simulator started. Listening for all packets...")
    print("Will pause and wait for [Enter] upon receiving a G-code command for address 0x10.")
    print("Press Ctrl+C to exit.")

    read_buffer = bytearray()
    sequence_number = 0
    last_print_time = time.time()
    
    try:
        while True:
            try:
                # Initialize chunk to None at the start of each loop iteration
                chunk = None
                
                # Read all available bytes to minimize blocking
                bytes_to_read = ser.in_waiting
                if bytes_to_read > 0:
                    chunk = ser.read(bytes_to_read)
                    read_buffer.extend(chunk)
                else:
                    # Small sleep when idle to prevent high CPU usage
                    time.sleep(0.001)

                # --- Process all complete packets in the buffer ---
                while True:
                    packet = find_and_decode_packet(read_buffer)
                    if packet:
                        # A valid packet was found and parsed
                        source_name = ADDRESS_NAMES.get(packet['src'], f"0x{packet['src']:02x}")
                        dest_name = ADDRESS_NAMES.get(packet['dest'], f"0x{packet['dest']:02x}")
                        ptype_name = PTYPE_NAMES.get(packet['ptype'], f"Unknown (0x{packet['ptype']:02x})")
                        payload_str = packet['payload'].hex()
                        if packet['ptype'] == 13: # GCODE
                            payload_str = packet['payload'].decode('ascii', errors='ignore').strip()
                        
                        print(f"BUS: [{source_name} -> {dest_name}] PTYPE: {ptype_name}, SEQ: {packet['seq']}, PAYLOAD: '{payload_str}'")

                        # Check if it's our specific command to act on
                        if packet["dest"] == 0x10 and packet.get("ptype") == 13:
                            print("\n----------------------------------------")
                            print(f"ACTION REQUIRED: Command for our device (0x10) received.")
                            print("----------------------------------------")
                            
                            input("Press [Enter] to send RESUME packet back to the MC...")

                            resume_packet = build_standard_packet(dest=0x03, src=0x06, ptype=0x07, seq=sequence_number, payload=b'\x05')
                            sequence_number = (sequence_number + 1) % 16
                            ser.write(resume_packet)
                            print(f"SENT: Resume packet to MC. Hex: {resume_packet.hex()}")
                            print("\nListening for next command...")
                    else:
                        # No more complete packets in the buffer right now
                        break
                
                # Heartbeat
                if not chunk:
                    if time.time() - last_print_time > 2.0:
                        print(f"...")
                        last_print_time = time.time()

            except SerialException as e:
                print(f"\nERROR: Serial communication failed: {e}", file=sys.stderr)
                break
    except KeyboardInterrupt:
        print("\nExiting simulator.")
    finally:
        if ser.is_open:
            ser.close()
            print("Serial port closed.")

if __name__ == "__main__":
    main()
