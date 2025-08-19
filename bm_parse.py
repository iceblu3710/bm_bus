#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
bm_parse_final.py — Comprehensive Offline Bambu‑Bus Frame Parser (Optimized)

This script combines a standard header-based parser with an advanced, parallelized
CRC-anchored search to provide a complete analysis of large .raw.bin files.

What it does:
1.  **Phase 1 (Header Scan):** Quickly finds all well-formed frames.
2.  **Phase 2 (CRC-Anchored Scan):** Uses multiple CPU cores to rapidly search
    the remaining data for frames missed due to corrupted headers.
3.  **Output:** Generates a single .bm.jsonl file with all found frames.
4.  **Summary Report:** Prints a detailed breakdown of the capture file.

Usage:
    python bm_parse_final.py --infile bm_session_YYYYMMDD_HHMMSS.raw.bin
"""

from __future__ import annotations
import argparse
import json
import sys
import os
import multiprocessing
from typing import Dict, Any, Optional, List, Tuple, Generator

# --- Constants ---

ADDRESS_NAMES = {
    0x01: "SYS", 0x02: "UI", 0x03: "MC", 0x06: "AP", 0x07: "AMS",
    0x08: "TH", 0x09: "AP2", 0x0E: "AHB", 0x0F: "EXT", 0x12: "AMS_LITE", 0x13: "CTC",
}

# --- CRC & Payload Helper Functions ---

def crc8(data: bytes) -> int:
    crc, poly = 0x66, 0x39
    for byte in data:
        crc ^= byte
        for _ in range(8):
            crc = (crc << 1) ^ poly if crc & 0x80 else crc << 1
    return crc & 0xFF

def crc16_ccitt(data: bytes, init: int) -> int:
    crc, poly = init, 0x1021
    for byte in data:
        crc ^= (byte << 8)
        for _ in range(8):
            crc = (crc << 1) ^ poly if crc & 0x8000 else crc << 1
    return crc & 0xFFFF

def destuff_payload(payload: bytes) -> bytes:
    out = bytearray()
    i = 0
    while i < len(payload):
        b = payload[i]
        out.append(b)
        if b in (0x61, 0x9D) and i + 1 < len(payload) and payload[i+1] == 0x00:
            i += 1
        i += 1
    return bytes(out)

# --- Core Scanners ---

def header_based_scan(raw_data: bytes, bm_max: int) -> List[Dict]:
    found_frames = []
    buf = bytearray(raw_data)
    offset = 0
    while len(buf) > 2:
        try_3d = buf.find(0x3D)
        try_619d = buf.find(b'\x61\x9D')
        if try_3d == -1 and try_619d == -1: break
        start_idx = min(d for d in [try_3d, try_619d] if d != -1)
        if start_idx > 0:
            offset += start_idx
            del buf[:start_idx]
        frame_offset = offset
        frame_info = None
        if buf.startswith(b'\x3D'):
            frame_info = parse_standard_frame(buf, frame_offset, bm_max)
        elif buf.startswith(b'\x61\x9D'):
            frame_info = parse_variant_frame(buf, frame_offset, bm_max)
        if frame_info:
            found_frames.append(frame_info)
            frame_len = len(frame_info["frame"])
            offset += frame_len
            del buf[:frame_len]
        else:
            offset += 1
            del buf[0]
    return found_frames

def parse_standard_frame(buf, offset, bm_max):
    if len(buf) < 4: return None
    flag = buf[1]
    is_long = flag < 0x80
    header_len = 7 if is_long else 4
    if len(buf) < header_len: return None
    header = buf[:header_len]
    if crc8(header[:-1]) != header[-1]: return None
    packet_len = int.from_bytes(header[4:6], 'little') if is_long else header[2]
    min_len = 13 if is_long else 7
    if not (min_len <= packet_len <= bm_max and len(buf) >= packet_len): return None
    return {"type": "standard_3d", "frame": bytes(buf[:packet_len]), "offset": offset}

def parse_variant_frame(buf, offset, bm_max):
    if len(buf) < 4: return None
    packet_len = int.from_bytes(buf[2:4], 'little')
    if not (8 <= packet_len <= bm_max and len(buf) >= packet_len): return None
    return {"type": "variant_619d", "frame": bytes(buf[:packet_len]), "offset": offset}

def crc_anchored_search_worker(args_tuple: Tuple[bytes, int]) -> List[Dict]:
    """Worker function for parallel CRC search."""
    segment, segment_offset = args_tuple
    if len(set(segment)) <= 1: return []
    found_frames = []
    seg_len = len(segment)
    for end in range(seg_len, 10, -1):
        crc_from_frame = int.from_bytes(segment[end-2:end], 'little')
        for length in range(10, min(end, 512)):
            start = end - length
            payload_wo_crc = segment[start:end-2]
            if crc16_ccitt(payload_wo_crc, init=0x913D) == crc_from_frame:
                found_frames.append({"type": "crc_anchored_std", "frame": segment[start:end], "offset": segment_offset + start})
            destuffed = destuff_payload(payload_wo_crc)
            if crc16_ccitt(destuffed, init=0xFFFF) == crc_from_frame:
                 found_frames.append({"type": "crc_anchored_var", "frame": segment[start:end], "offset": segment_offset + start})
    return found_frames

# --- Analysis & Reporting ---

def analyze_frame(frame_info: Dict[str, Any]) -> Dict[str, Any]:
    frame, frame_type, offset = frame_info["frame"], frame_info["type"], frame_info["offset"]
    analysis = {"len": len(frame), "hex": frame.hex(), "parser": frame_type, "offset": offset}
    payload_wo_crc = frame[:-2]
    crc_from_frame = int.from_bytes(frame[-2:], 'little')
    if frame_type == 'standard_3d':
        analysis["crc16_ok"] = crc16_ccitt(payload_wo_crc, init=0x913D) == crc_from_frame
        flag = frame[1]
        analysis["header_layout"] = "long" if flag < 0x80 else "short"
    elif frame_type == 'variant_619d':
        destuffed = destuff_payload(payload_wo_crc)
        analysis["crc16_ok"] = crc16_ccitt(destuffed, init=0xFFFF) == crc_from_frame
        analysis["header_layout"] = "variant_619d"
    elif frame_type.startswith('crc_anchored'):
        analysis["crc16_ok"] = True
        analysis["header_layout"] = "unknown (CRC-anchored)"
    return analysis

def get_unaccounted_segments(raw_len: int, frames: List[Dict]) -> Generator[Tuple[int, int], None, None]:
    frames.sort(key=lambda f: f['offset'])
    last_end_offset = 0
    for frame in frames:
        start, end = last_end_offset, frame['offset']
        if start < end: yield (start, end)
        last_end_offset = frame['offset'] + frame['len']
    if last_end_offset < raw_len:
        yield (last_end_offset, raw_len)

def main() -> int:
    parser = argparse.ArgumentParser(description="Comprehensive Bambu-Bus frame parser.", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--infile", required=True, help="Input .raw.bin file to parse.")
    parser.add_argument("--bm-max", type=int, default=4096, help="Maximum plausible frame length.")
    args = parser.parse_args()

    try:
        with open(args.infile, "rb") as f: raw_data = f.read()
    except FileNotFoundError:
        print(f"ERROR: Input file not found: {args.infile}", file=sys.stderr); return 1
    
    print("--- Phase 1: Running Header-Based Scan ---")
    header_frames_info = header_based_scan(raw_data, args.bm_max)
    all_frames = [analyze_frame(f) for f in header_frames_info if analyze_frame(f).get("crc16_ok")]

    print(f"--- Phase 2: Found {len(all_frames)} frames, starting CRC-Anchored Scan on remaining data ---")
    unaccounted_segments = list(get_unaccounted_segments(len(raw_data), all_frames))
    
    missed_frames_info = []
    if unaccounted_segments:
        total_unaccounted = sum(end - start for start, end in unaccounted_segments)
        print(f"Analyzing {total_unaccounted:,} unaccounted-for bytes across {len(unaccounted_segments)} segments...")
        
        # Create a pool of worker processes
        with multiprocessing.Pool() as pool:
            # Create a list of tasks for the workers
            tasks = [(raw_data[start:end], start) for start, end in unaccounted_segments]
            
            # Use imap_unordered for progress reporting
            results = pool.imap_unordered(crc_anchored_search_worker, tasks)
            
            completed_tasks = 0
            for result in results:
                missed_frames_info.extend(result)
                completed_tasks += 1
                progress = (completed_tasks / len(tasks)) * 100
                print(f"    -> Progress: {progress:.1f}% complete ({completed_tasks}/{len(tasks)} segments analyzed)", end='\r')
        print("\nPhase 2 scan complete.")

    all_frames.extend([analyze_frame(f) for f in missed_frames_info])
    all_frames.sort(key=lambda x: x['offset'])

    outfile_path = args.infile.rsplit('.', 1)[0] + ".bm.jsonl"
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

    return 0

if __name__ == "__main__":
    sys.exit(main())
