#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
bm_3pass_parser.py - High-Performance 3-Pass Bambu-Bus Log Parser

This script combines multiple parsing techniques into a highly efficient,
three-pass system to provide a comprehensive and fast analysis of .raw.bin
capture files.

Pass 1: Noise Filter
  - The raw binary data is read and all inter-packet silence (0x00 bytes)
    is stripped out, significantly reducing the amount of data to be processed.

Pass 2: High-Speed State Machine Scan
  - A fast, single-pass state machine (simulating microcontroller logic)
    scans the cleaned data for all well-formed Standard (0x3D) and
    Stuffed (0x619D) packets. These packets are decoded and their locations
    are recorded.

Pass 3: Parallelized CRC-Anchored Search
  - Only the data segments that were not identified as valid packets in Pass 2
    (the "leftovers") are passed to a multi-core, CRC-anchored search.
    This forensic step recovers any packets with corrupted or unknown headers.

This hybrid approach provides the speed of a state machine for the bulk of
the data and the thoroughness of a forensic CRC search for the difficult parts.

Usage:
    python bm_3pass_parser.py --infile your_capture_file.raw.bin
"""

import argparse
import json
import sys
import os
import multiprocessing
from typing import Dict, Any, Optional, List, Tuple

# --- Constants & Mappings ---
ADDRESS_NAMES = {
    0x01: "SYS", 0x02: "UI", 0x03: "MC", 0x06: "AP", 0x07: "AMS",
    0x08: "TH", 0x09: "EXT", 0x0A: "NFC", 0x0B: "CAM", 0x0C: "WIFI",
    0x0D: "AMS_HUB", 0x0E: "AMS_RFID", 0x0F: "AMS_MOTOR",
    0x10: "CUSTOM_DEVICE" 
}

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

# --- Universal Packet Parser ---
def parse_frame(frame_content: bytes, offset: int, scan_method: str) -> Optional[Dict[str, Any]]:
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
    payload_data = payload[3:]

    return {
        "offset": offset, "len": len(frame_content), "parser": scan_method,
        "source_name": ADDRESS_NAMES.get(src, "Unknown"),
        "dest_name": ADDRESS_NAMES.get(dest, "Unknown"),
        "ptype_name": PTYPE_NAMES.get(ptype, "Unknown"),
        "sequence": seq, "payload_hex": payload_data.hex()
    }

# --- Pass 2: State Machine ---
def find_frames_state_machine(data: bytes) -> Tuple[List[Dict], List[Tuple[int, int]]]:
    frames = []
    accounted_for = []
    i = 0
    state = 0 # 0: WAIT_SOF, 1: WAIT_LEN_STUFFED
    
    while i < len(data):
        if state == 0:
            if data[i] == 0x3D:
                if i + 1 < len(data):
                    frame_len = data[i+1]
                    if i + 2 + frame_len <= len(data):
                        parsed = parse_frame(data[i+2 : i+2+frame_len], i, "state_machine_3d")
                        if parsed:
                            frames.append(parsed)
                            accounted_for.append((i, i + 2 + frame_len))
                        i += 1 + frame_len
                    else: i += 1
                else: break
            elif data[i] == 0x61:
                state = 1
                i += 1
            else:
                i += 1
        elif state == 1:
            if data[i] == 0x9D:
                if i + 2 < len(data):
                    frame_len = int.from_bytes(data[i+1:i+3], 'little')
                    if i + 3 + frame_len <= len(data):
                        parsed = parse_frame(data[i+3 : i+3+frame_len], i-1, "state_machine_619d")
                        if parsed:
                            frames.append(parsed)
                            accounted_for.append((i-1, i + 3 + frame_len))
                        i += 2 + frame_len
                    else: i += 1
                else: break
            state = 0
            i += 1
            
    return frames, accounted_for

# --- Pass 3: CRC Search ---
def search_segment_for_crc(args_tuple: Tuple[bytes, int, int, int]) -> List[Dict]:
    segment, segment_offset, min_len, max_len = args_tuple
    found_frames = []
    for length in range(max_len, min_len - 1, -1):
        for i in range(len(segment) - length + 1):
            window = segment[i : i + length]
            if len(window) < 3: continue
            if crc16_xmodem(window[:-2]) == int.from_bytes(window[-2:], 'little'):
                frame_details = parse_frame(window, segment_offset + i, "crc_anchored")
                if frame_details:
                    found_frames.append(frame_details)
    return found_frames

# --- Main Execution ---
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Bambu-Bus 3-Pass Raw Capture Parser")
    parser.add_argument("--infile", required=True, help="Input .raw.bin file")
    args = parser.parse_args()

    if not os.path.exists(args.infile):
        print(f"ERROR: Input file not found: {args.infile}", file=sys.stderr)
        sys.exit(1)

    with open(args.infile, "rb") as f:
        raw_data = f.read()

    # --- Pass 1: Filter out 0x00 bytes ---
    print("--- Pass 1: Filtering noise ---")
    clean_data = bytes(b for b in raw_data if b != 0)
    print(f"Removed {len(raw_data) - len(clean_data):,} zero bytes.")

    # --- Pass 2: State Machine Scan ---
    print("--- Pass 2: Running High-Speed State Machine Scan ---")
    state_machine_frames, accounted_segments = find_frames_state_machine(clean_data)
    print(f"Found {len(state_machine_frames)} well-formed packets.")

    # --- Determine unaccounted-for segments for Pass 3 ---
    unaccounted_segments = []
    last_end = 0
    accounted_segments.sort(key=lambda x: x[0])
    for start, end in accounted_segments:
        if start > last_end:
            unaccounted_segments.append((last_end, start))
        last_end = max(last_end, end)
    if last_end < len(clean_data):
        unaccounted_segments.append((last_end, len(clean_data)))
        
    # --- Pass 3: CRC-Anchored Scan on leftovers ---
    print(f"--- Pass 3: Starting CRC-Anchored Scan on remaining data ---")
    unaccounted_size = sum(end - start for start, end in unaccounted_segments)
    print(f"Analyzing {unaccounted_size:,} unaccounted-for bytes across {len(unaccounted_segments)} segments...")

    tasks = [(clean_data[start:end], start, 3, 2048) for start, end in unaccounted_segments]
    
    try: num_cores = multiprocessing.cpu_count()
    except NotImplementedError: num_cores = 4

    with multiprocessing.Pool(processes=num_cores) as pool:
        results = pool.map(search_segment_for_crc, tasks)

    crc_frames = [frame for sublist in results for frame in sublist]
    print(f"Found {len(crc_frames)} additional packets with CRC search.")

    # --- Finalize and Report ---
    all_frames = state_machine_frames + crc_frames
    all_frames.sort(key=lambda x: x['offset'])

    outfile_path = os.path.splitext(args.infile)[0] + ".3pass.jsonl"
    with open(outfile_path, "w") as out_f:
        for frame in all_frames:
            out_f.write(json.dumps(frame) + "\n")

    print("\n" + "="*50)
    print("--- 3-Pass Analysis Report ---")
    print(f"File: {os.path.basename(args.infile)}")
    print("="*50)
    print(f"Total Raw Size:          {len(raw_data):,} bytes")
    print(f"Non-Zero Data Size:      {len(clean_data):,} bytes")
    print("-"*50)
    print("Frame Counts:")
    print(f"  - State Machine Pass:    {len(state_machine_frames)}")
    print(f"  - CRC Search Pass:       {len(crc_frames)}")
    print(f"  - TOTAL VALID FRAMES:    {len(all_frames)}")
    print("="*50)
    print(f"Output written to: {outfile_path}")
