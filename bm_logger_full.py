#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
bm_logger.py — RS‑485 Bambu‑Bus Sniffer & BM-Frame Logger

This script captures data from a Bambu-Bus via an RS-485 serial adapter.

What it does:
1.  **Raw Capture:** Opens a serial port and saves all incoming bytes to a
    `.raw.bin` file. This is the ground truth for all analysis.
2.  **Hex Log:** Creates a human-readable, timestamped hex dump in a `.hex.log`
    file for easy inspection.
3.  **Frame Extraction:** Performs a best-effort extraction of "BM" protocol
    frames, saving them to a `.bm.jsonl` file. This process is heuristic and
    designed to be resilient to protocol variations.

Frame Extraction Logic (Updated based on community documentation):
-   Syncs on the `0x3D` start byte.
-   Validates packet headers using a CRC8 checksum.
-   Parses long and short header formats to determine packet length.
-   Validates the full packet using a CRC16 checksum.

NOTE: The Bambu-Bus protocol is not officially documented and may change. This
parser prioritizes capturing all data and avoiding crashes. The raw `.bin` file
is the most reliable output.

Usage:
    # Windows
    python bm_logger.py --port COM5 --bm-enable

    # Linux
    python bm_logger.py --port /dev/ttyUSB0 --bm-enable

    # macOS
    python bm_logger.py --port /dev/tty.usbserial-XXXXX --bm-enable

Safety:
-   The script opens the serial port in read-only mode and never transmits data.
-   Ensure you are using a proper RS-485 receiver and have a common ground.
    Do NOT short any power lines on the bus.
"""

from __future__ import annotations
import argparse
import binascii
import json
import os
import signal
import sys
import time
from datetime import datetime
from typing import IO, Dict, Any, Optional, Tuple

try:
    import serial
    from serial.serialutil import SerialException
except ImportError:
    print("ERROR: pyserial is required. Install with: pip install pyserial", file=sys.stderr)
    sys.exit(1)

# --- Constants ---

# Known device addresses from community reverse-engineering efforts.
ADDRESS_NAMES = {
    0x03: "MC",
    0x06: "AP",
    0x07: "AMS",
    0x08: "TH",
    0x09: "AP2",
    0x0E: "AHB",
    0x0F: "EXT",
    0x12: "AMS_LITE",
    0x13: "CTC",
}

# --- CRC & Payload Helper Functions ---

def crc8(data: bytes) -> int:
    """
    Calculates CRC8 with poly=0x39, init=0x66.
    Used for validating Bambu-Bus packet headers.
    """
    crc = 0x66
    poly = 0x39
    for byte in data:
        crc ^= byte
        for _ in range(8):
            if crc & 0x80:
                crc = (crc << 1) ^ poly
            else:
                crc <<= 1
    return crc & 0xFF

def crc16_ccitt_913d(data: bytes) -> int:
    """Calculates CRC-16-CCITT with poly=0x1021 and a custom initial value of 0x913D."""
    crc = 0x913D
    poly = 0x1021
    for byte in data:
        crc ^= (byte << 8)
        for _ in range(8):
            if crc & 0x8000:
                crc = (crc << 1) ^ poly
            else:
                crc <<= 1
    return crc & 0xFFFF

# --- Core Classes ---

class RotatingWriter:
    """
    A file writer that rotates to a new file after a certain size limit is reached.
    """
    def __init__(self, basepath: str, suffix: str, rotate_bytes: int, mode: str = "wb"):
        self.basepath = basepath
        self.suffix = suffix
        self.rotate_bytes = rotate_bytes
        self.mode = mode
        self.idx = 0
        self.current_bytes = 0
        self.fh: Optional[IO] = None
        self._open_new()

    def _get_filepath(self) -> str:
        """Constructs the filename based on the current rotation index."""
        if self.rotate_bytes > 0 and self.idx > 0:
            return f"{self.basepath}.{self.idx}{self.suffix}"
        return f"{self.basepath}{self.suffix}"

    def _open_new(self):
        """Closes the current file and opens a new one."""
        if self.fh:
            self.fh.close()
        path = self._get_filepath()
        self.fh = open(path, self.mode)
        self.current_bytes = 0

    def write(self, data: bytes | str):
        """Writes data to the file, rotating if necessary."""
        if self.fh is None:
            raise IOError("Writer is closed.")
        
        encoded_data = data.encode("utf-8", "replace") if isinstance(data, str) and "b" in self.mode else data

        n = len(encoded_data)
        if self.rotate_bytes > 0 and (self.current_bytes + n) > self.rotate_bytes:
            self.idx += 1
            self._open_new()
        
        self.fh.write(encoded_data)
        self.current_bytes += n

    def flush(self):
        """Flushes the file's buffer."""
        if self.fh:
            self.fh.flush()

    def close(self):
        """Closes the file writer."""
        if self.fh:
            self.fh.close()
            self.fh = None

class BMScanner:
    """
    Scans a byte stream for Bambu-Bus frames based on documented protocol format.
    It syncs on a start byte, validates the header CRC8, reads the specified
    length, and returns the full frame for CRC16 validation.
    """
    def __init__(self, start_byte: int = 0x3D, bm_max: int = 4096):
        self.buf = bytearray()
        self.start_byte = start_byte
        self.bm_max = bm_max

    def feed(self, data: bytes):
        """Adds new data to the internal buffer."""
        self.buf.extend(data)

    def next_frame(self) -> Optional[bytes]:
        """
        Extracts the next valid BM frame from the buffer.
        Returns the frame as bytes, or None if no complete frame is found.
        """
        while True:
            start_idx = self.buf.find(self.start_byte)
            if start_idx == -1:
                return None

            # Discard any data before the start byte
            if start_idx > 0:
                del self.buf[:start_idx]

            # Determine header type and length
            if len(self.buf) < 4:  # Minimum possible header size (short)
                return None

            flag = self.buf[1]
            is_long_header = flag < 0x80
            
            if is_long_header:
                header_len = 7
                if len(self.buf) < header_len: return None
                header = self.buf[:header_len]
                header_for_crc = header[:-1]
                crc_from_header = header[-1]
                packet_len = int.from_bytes(header[4:6], 'little')
            else: # Short header
                header_len = 4
                if len(self.buf) < header_len: return None
                header = self.buf[:header_len]
                header_for_crc = header[:-1]
                crc_from_header = header[-1]
                packet_len = header[2]

            # Validate header CRC8
            if crc8(header_for_crc) != crc_from_header:
                # CRC failed, discard the start byte and try again
                del self.buf[0]
                continue

            # Check if we have the full packet
            if len(self.buf) < packet_len:
                # Not enough data yet, wait for more
                return None
            
            # We have a full frame
            frame = bytes(self.buf[:packet_len])
            del self.buf[:packet_len]

            # Final sanity check on length
            if len(frame) > self.bm_max:
                continue # Unlikely length, probably a parse error.

            return frame

# --- Frame Analysis ---

def get_address_name(addr: int) -> str:
    """Returns a human-readable name for a given device address."""
    return ADDRESS_NAMES.get(addr, f"0x{addr:02X}")

def analyze_frame(frame: bytes) -> Dict[str, Any]:
    """
    Performs a full analysis of a captured frame, including CRC checks and
    header parsing based on the determined format.
    """
    payload_wo_crc16 = frame[:-2]
    crc16_from_frame = int.from_bytes(frame[-2:], "little")
    crc16_calculated = crc16_ccitt_913d(payload_wo_crc16)
    crc16_ok = crc16_calculated == crc16_from_frame

    flag = frame[1]
    is_long_header = flag < 0x80
    
    info = {
        "len": len(frame),
        "hex": frame.hex(),
        "crc16_frame": crc16_from_frame,
        "crc16_calc": crc16_calculated,
        "crc16_ok": crc16_ok,
    }

    if is_long_header:
        info.update({
            "header_layout": "long",
            "seq": int.from_bytes(frame[2:4], 'little'),
            "src_id": int.from_bytes(frame[9:11], 'little'),
            "dst_id": int.from_bytes(frame[7:9], 'little'),
            "payload_hex": frame[11:-2].hex(),
        })
    else: # Short header
        info.update({
            "header_layout": "short",
            "seq": flag,
            "ptype": frame[4],
            "src_id": None, # Not present in short header
            "dst_id": None, # Not present in short header
            "payload_hex": frame[5:-2].hex(),
        })

    if info.get("src_id") is not None:
        info["src_name"] = get_address_name(info["src_id"])
    if info.get("dst_id") is not None:
        info["dst_name"] = get_address_name(info["dst_id"])

    return info

# --- Main Application ---

def parse_args() -> argparse.Namespace:
    """Parses command-line arguments."""
    p = argparse.ArgumentParser(
        description="Bambu-Bus RS-485 sniffer & BM frame logger (read-only)",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )
    p.add_argument("--port", required=True, help="Serial port for your RS-485 adapter (e.g., COM5 or /dev/ttyUSB0)")
    p.add_argument("--baud", type=int, default=1228800, help="Baud rate")
    p.add_argument("--parity", choices=["N", "E", "O"], default="E", help="Parity (N=None, E=Even, O=Odd)")
    p.add_argument("--stopbits", type=float, choices=[1, 1.5, 2], default=1, help="Stop bits")
    p.add_argument("--bytesize", type=int, choices=[7, 8], default=8, help="Data bits")
    p.add_argument("--timeout", type=float, default=0.05, help="Serial read timeout in seconds")
    p.add_argument("--outfile", default="bm_session", help="Output file prefix")
    p.add_argument("--hex-chunk", type=int, default=64, help="Bytes per line in the hex log")
    p.add_argument("--rotate-bytes", type=int, default=100 * 1024 * 1024, help="Rotate log files at this size (in bytes). 0 to disable.")
    p.add_argument("--max-runtime", type=int, default=0, help="Stop after N seconds. 0 to run until Ctrl+C.")
    p.add_argument("--bm-max", type=int, default=4096, help="Maximum plausible BM frame length")
    p.add_argument("--bm-enable", action="store_true", help="Enable best-effort BM frame extraction to .bm.jsonl")
    p.add_argument("--quiet", action="store_true", help="Suppress non-essential console output")
    return p.parse_args()

def open_serial_port(args: argparse.Namespace) -> serial.Serial:
    """Opens the serial port with platform-specific options."""
    parity_map = {"N": serial.PARITY_NONE, "E": serial.PARITY_EVEN, "O": serial.PARITY_ODD}
    
    kwargs = {
        "port": args.port,
        "baudrate": args.baud,
        "bytesize": args.bytesize,
        "parity": parity_map[args.parity],
        "stopbits": args.stopbits,
        "timeout": args.timeout,
    }
    
    if sys.platform.startswith("win"):
        try:
            return serial.Serial(**kwargs, exclusive=True)
        except TypeError:
            return serial.Serial(**kwargs)
    
    return serial.Serial(**kwargs)

def main() -> int:
    """Main application entry point."""
    args = parse_args()

    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    base_filename = f"{args.outfile}_{ts}"
    raw_writer = RotatingWriter(base_filename, ".raw.bin", args.rotate_bytes, mode="wb")
    hex_writer = RotatingWriter(base_filename, ".hex.log", args.rotate_bytes, mode="w")
    bm_writer = RotatingWriter(base_filename, ".bm.jsonl", args.rotate_bytes, mode="w") if args.bm_enable else None

    stop_flag = {"stop": False}
    def _handle_shutdown(signum, frame):
        print("\n[bm_logger] Shutdown signal received. Closing files...")
        stop_flag["stop"] = True
    signal.signal(signal.SIGINT, _handle_shutdown)
    if hasattr(signal, "SIGTERM"):
        signal.signal(signal.SIGTERM, _handle_shutdown)

    scanner = BMScanner(bm_max=args.bm_max)

    try:
        ser = open_serial_port(args)
    except SerialException as e:
        print(f"ERROR: Could not open serial port '{args.port}': {e}", file=sys.stderr)
        return 1

    if not args.quiet:
        print(f"[bm_logger] Python: {sys.version.split()[0]}")
        print(f"[bm_logger] Listening on {args.port} @ {args.baud} {args.bytesize}{args.parity}{args.stopbits}")
        print(f"[bm_logger] Writing raw data to: {base_filename}.raw.bin")
        print(f"[bm_logger] Writing hex log to:  {base_filename}.hex.log")
        if bm_writer:
            print(f"[bm_logger] Writing frames to:   {base_filename}.bm.jsonl")
        else:
            print("[bm_logger] Frame extraction disabled. Use --bm-enable to generate .bm.jsonl file.")
        print("[bm_logger] Press Ctrl+C to stop.")

    start_time = time.time()
    last_flush_time = start_time
    
    try:
        while not stop_flag["stop"]:
            if args.max_runtime > 0 and (time.time() - start_time) >= args.max_runtime:
                print("[bm_logger] Maximum runtime reached.")
                break

            try:
                chunk = ser.read(4096)
            except SerialException as e:
                print(f"\nERROR: Serial read failed: {e}", file=sys.stderr)
                break

            if chunk:
                now = time.time()
                raw_writer.write(chunk)
                for i in range(0, len(chunk), args.hex_chunk):
                    segment = chunk[i:i + args.hex_chunk]
                    hex_writer.write(f"{now:.6f} {segment.hex()}\n")

                if bm_writer:
                    scanner.feed(chunk)
                    while True:
                        frame = scanner.next_frame()
                        if frame is None:
                            break
                        
                        analysis = analyze_frame(frame)
                        record = {"ts": now, **analysis}
                        bm_writer.write(json.dumps(record) + "\n")

            if time.time() - last_flush_time > 2.0:
                raw_writer.flush()
                hex_writer.flush()
                if bm_writer: bm_writer.flush()
                last_flush_time = time.time()

    finally:
        print("[bm_logger] Cleaning up...")
        if 'ser' in locals() and ser.is_open:
            ser.close()
        raw_writer.close()
        hex_writer.close()
        if bm_writer:
            bm_writer.close()

    if not args.quiet:
        print("[bm_logger] Done.")
    return 0

if __name__ == "__main__":
    sys.exit(main())
