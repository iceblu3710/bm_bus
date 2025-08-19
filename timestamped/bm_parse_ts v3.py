#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
bm_parse_ts.py — Comprehensive Offline Bambu‑Bus Frame Parser (Updated)

This script combines a standard header-based parser with an advanced, parallelized
CRC-anchored search to provide a complete analysis of large .raw.bin files.

This updated version includes refined logic to specifically detect and parse
standard (0x3D) and stuffed (0x619D) packet headers, which are used for
G-code commands like temperature setting, in addition to the raw motor commands.

What it does:
1.  **Phase 1 (Header Scan):** Quickly finds all well-formed frames with known
    start-of-frame markers (0x3D and 0x619D).
2.  **Phase 2 (CRC-Anchored Scan):** Uses multiple CPU cores to rapidly search
    the remaining data for frames missed due to corrupted or unknown headers.
3.  **Output:** Generates a single .bm.jsonl file with all found frames.
4.  **Summary Report:** Prints a detailed breakdown of the capture file.

Usage:
    python bm_parse_ts.py --infile bm_session_YYYYMMDD_HHMMSS.raw.bin
"""

from __future__ import annotations
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
    0x0D: "AMS_HUB", 0x0E: "AMS_RFID", 0x0F: "AMS_MOTOR"
}

PTYPE_NAMES = {
    0x01: "ACK", 0x02: "NAK", 0x03: "VERSION", 0x04: "RESET", 0x05: "STATUS",
    0x06: "CONFIG", 0x07: "CONTROL", 0x08: "MOTOR", 0x09: "SENSOR",
    0x0A: "FILE_XFER", 0x0B: "LOG", 0x0C: "DEBUG", 0x0D: "GCODE"
}

# --- CRC Calculation ---

CRC16_XMODEM_TABLE = [
    0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
    0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
    0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
    0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
    0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485,
    0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
    0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4,
    0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
    0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
    0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
    0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12,
    0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
    0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
    0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
    0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
    0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
    0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f,
    0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
    0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e,
    0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
    0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
    0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
    0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c,
    0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
    0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab,
    0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
    0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
    0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
    0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9,
    0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
    0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
    0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
]

def crc16_xmodem(data: bytes) -> int:
    crc = 0
    for byte in data:
        crc = (crc << 8) ^ CRC16_XMODEM_TABLE[((crc >> 8) ^ byte) & 0xFF]
    return crc & 0xFFFF

# --- Frame Parsing Logic ---

def parse_frame(frame_content: bytes, offset: int, scan_method: str) -> Optional[Dict[str, Any]]:
    """
    Validates, de-stuffs, and parses the content of a potential bus frame.
    Assumes frame_content is the raw data *excluding* SOF and length bytes,
    but *including* the 2-byte CRC at the end.
    """
    if len(frame_content) < 2:
        return None

    # Checksum validation
    expected_crc = int.from_bytes(frame_content[-2:], 'little')
    data_to_check = frame_content[:-2]
    calculated_crc = crc16_xmodem(data_to_check)
    
    if calculated_crc != expected_crc:
        return None

    # De-stuffing (0x7D is the escape character)
    payload = bytearray()
    i = 0
    while i < len(data_to_check):
        if data_to_check[i] == 0x7D:
            if i + 1 < len(data_to_check):
                payload.append(data_to_check[i+1] ^ 0x20)
                i += 2
            else: # Malformed escape
                return None 
        else:
            payload.append(data_to_check[i])
            i += 1
    
    # Header parsing
    header_layout = "Unknown"
    dest, src, seq, ptype, cmd = None, None, None, None, None
    payload_data = payload

    if len(payload) >= 5 and payload[0] in ADDRESS_NAMES: # Long Header
        header_layout = "Long"
        dest, src, ptype, seq, cmd = payload[0], payload[1], payload[2], payload[3], payload[4]
        payload_data = payload[5:]
    elif len(payload) >= 3 and payload[0] in ADDRESS_NAMES: # Short Header
        header_layout = "Short"
        dest, src, ptype, seq = payload[0], payload[1], payload[2] & 0x0F, (payload[2] & 0xF0) >> 4
        payload_data = payload[3:]
    else:
        header_layout = "unknown (CRC-anchored)"

    return {
        "offset": offset,
        "frame_hex": frame_content.hex(),
        "len": len(frame_content),
        "parser": scan_method,
        "header_layout": header_layout,
        "crc16_ok": True,
        "source_addr": f"0x{src:02x}" if src is not None else "Unknown",
        "source_name": ADDRESS_NAMES.get(src, "Unknown"),
        "dest_addr": f"0x{dest:02x}" if dest is not None else "Unknown",
        "dest_name": ADDRESS_NAMES.get(dest, "Unknown"),
        "sequence": seq,
        "ptype": ptype,
        "payload_hex": payload_data.hex()
    }

def find_frames_header_based(data: bytes) -> Tuple[List[Dict], List[Tuple[int, int]]]:
    """Phase 1: Finds frames using known header patterns (0x3D, 0x619D)."""
    frames = []
    accounted_for = []
    i = 0
    while i < len(data):
        frame = None
        
        # Standard Frame: Starts with 0x3D, followed by 1-byte length.
        # This format is common for general G-code commands like temperature setting.
        if data[i] == 0x3D:
            # Check if there's at least a length byte and a 2-byte CRC
            if i + 1 + 2 < len(data):
                # The length byte specifies the size of the following data (payload + 2-byte CRC)
                frame_len = data[i+1]
                # Ensure the full frame fits within the data buffer
                if i + 2 + frame_len <= len(data):
                    frame_start_idx = i + 2
                    frame_end_idx = frame_start_idx + frame_len
                    frame_data = data[frame_start_idx:frame_end_idx]
                    
                    parsed = parse_frame(frame_data, i, "standard_3d")
                    if parsed:
                        frame = parsed
                        accounted_for.append((i, frame_end_idx))
                        i = frame_end_idx -1 # Will be incremented to frame_end_idx at loop end
        
        # Stuffed Frame: Starts with 0x619D, followed by 2-byte little-endian length.
        # This format is often used for larger data transfers.
        elif data[i:i+2] == b'\x61\x9d':
            # Check if there's at least length bytes and a 2-byte CRC
            if i + 2 + 2 < len(data):
                # The length bytes specify the size of the following data (payload + 2-byte CRC)
                frame_len = int.from_bytes(data[i+2:i+4], 'little')
                # Ensure the full frame fits within the data buffer
                if i + 4 + frame_len <= len(data):
                    frame_start_idx = i + 4
                    frame_end_idx = frame_start_idx + frame_len
                    frame_data = data[frame_start_idx:frame_end_idx]

                    parsed = parse_frame(frame_data, i, "variant_619d")
                    if parsed:
                        frame = parsed
                        accounted_for.append((i, frame_end_idx))
                        i = frame_end_idx - 1 # Will be incremented to frame_end_idx at loop end

        if frame:
            frames.append(frame)
        
        i += 1

    # Determine unaccounted-for segments for Phase 2
    unaccounted_segments = []
    last_end = 0
    accounted_for.sort(key=lambda x: x[0])
    for start, end in accounted_for:
        if start > last_end:
            unaccounted_segments.append((last_end, start))
        last_end = max(last_end, end)
    if last_end < len(data):
        unaccounted_segments.append((last_end, len(data)))
        
    return frames, unaccounted_segments

def search_segment_for_crc(args_tuple: Tuple[bytes, int, int, int]) -> List[Dict]:
    """Worker function for CRC-anchored search in a data segment."""
    segment, segment_offset, min_len, max_len = args_tuple
    found_frames = []
    
    # This is a simplified search that looks for valid CRCs.
    # A more advanced version could also look for patterns inside the payload.
    for length in range(max_len, min_len - 1, -1):
        for i in range(len(segment) - length + 1):
            window = segment[i : i + length]
            if len(window) < 3: continue

            if crc16_xmodem(window[:-2]) == int.from_bytes(window[-2:], 'little'):
                # Attempt to parse to get more details
                frame_details = parse_frame(window, segment_offset + i, "crc_anchored_var")
                if frame_details:
                    found_frames.append(frame_details)

    return found_frames

# --- Main Execution ---

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Bambu-Bus Raw Capture Parser")
    parser.add_argument("--infile", required=True, help="Input .raw.bin file")
    args = parser.parse_args()

    if not os.path.exists(args.infile):
        print(f"ERROR: Input file not found: {args.infile}", file=sys.stderr)
        sys.exit(1)

    with open(args.infile, "rb") as f:
        raw_data = f.read()

    # --- Phase 1: Header-Based Scan ---
    print("--- Phase 1: Running Header-Based Scan ---")
    all_frames, unaccounted_segments = find_frames_header_based(raw_data)
    
    # --- Phase 2: CRC-Anchored Scan on remaining data ---
    print(f"--- Phase 2: Found {len(all_frames)} frames, starting CRC-Anchored Scan on remaining data ---")
    unaccounted_size = sum(end - start for start, end in unaccounted_segments)
    print(f"Analyzing {unaccounted_size:,} unaccounted-for bytes across {len(unaccounted_segments)} segments...")

    tasks = [(raw_data[start:end], start, 3, 2048) for start, end in unaccounted_segments]
    
    try:
        num_cores = multiprocessing.cpu_count()
    except NotImplementedError:
        num_cores = 4 # Default for safety

    with multiprocessing.Pool(processes=num_cores) as pool:
        results = pool.map(search_segment_for_crc, tasks)

    crc_frames = [frame for sublist in results for frame in sublist]
    all_frames.extend(crc_frames)
    print("Phase 2 scan complete.")

    # Sort all frames by offset
    all_frames.sort(key=lambda x: x['offset'])

    # Write output to JSONL
    outfile_path = os.path.splitext(args.infile)[0] + ".bm.jsonl"
    with open(outfile_path, "w") as out_f:
        for frame in all_frames:
            out_f.write(json.dumps(frame) + "\n")

    total_raw_size = len(raw_data)
    silence_size = raw_data.count(0)
    bm_size = sum(f['len'] for f in all_frames)
    std_frame_count = sum(1 for f in all_frames if f['parser'] == 'standard_3d')
    stuffed_frame_count = sum(1 for f in all_frames if f['parser'] == 'variant_619d')
    crc_frame_count = sum(1 for f in all_frames if f['parser'].startswith('crc_anchored'))
    non_silent_bytes = total_raw_size - silence_size
    unaccounted_bytes = non_silent_bytes - bm_size

    print("\n" + "="*50)
    print("--- Bambu-Bus Raw Capture Analysis Report ---")
    print(f"File: {os.path.basename(args.infile)}")
    print("="*50)
    print(f"Total Raw Size:      {total_raw_size:,} bytes")
    print(f"Inter-Packet Silence: {silence_size:,} bytes ({silence_size/total_raw_size:.1%})")
    print(f"Total BM Frame Bytes: {bm_size:,} bytes")
    print(f"Unaccounted Bytes:    {unaccounted_bytes:,} bytes (Non-silent data not in a valid frame)")
    print("-"*50)
    print("Frame Counts:")
    print(f"  - Standard Frames (0x3D):     {std_frame_count}")
    print(f"  - Stuffed Frames (0x619D):    {stuffed_frame_count}")
    print(f"  - CRC-Anchored Frames:        {crc_frame_count}")
    print(f"  - TOTAL VALID FRAMES:         {len(all_frames)}")
    print("="*50)
    print(f"Output written to: {outfile_path}")

