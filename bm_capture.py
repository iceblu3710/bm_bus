#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
bm_capture.py — RS‑485 Bambu‑Bus Data Capture Tool

This script captures all data from a Bambu-Bus via an RS-485 serial adapter
and saves it to raw binary and human-readable hex log files.

What it does:
1.  **Raw Capture:** Opens a serial port and saves all incoming bytes to a
    `.raw.bin` file. This serves as the ground truth for any offline analysis.
2.  **Hex Log:** Creates a human-readable, timestamped hex dump in a `.hex.log`
    file for easy inspection of the data stream.

This script does NOT parse the Bambu-Bus protocol. Use the accompanying
`bm_parse.py` script to process the generated `.raw.bin` file.

Usage:
    # Windows
    python bm_capture.py --port COM5

    # Linux
    python bm_capture.py --port /dev/ttyUSB0

    # macOS
    python bm_capture.py --port /dev/tty.usbserial-XXXXX

Safety:
-   The script opens the serial port in read-only mode and never transmits data.
-   Ensure you are using a proper RS-485 receiver and have a common ground.
    Do NOT short any power lines on the bus.
"""

from __future__ import annotations
import argparse
import sys
import signal
import time
from datetime import datetime
from typing import IO, Optional

try:
    import serial
    from serial.serialutil import SerialException
except ImportError:
    print("ERROR: pyserial is required. Install with: pip install pyserial", file=sys.stderr)
    sys.exit(1)

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

# --- Main Application ---

def parse_args() -> argparse.Namespace:
    """Parses command-line arguments."""
    p = argparse.ArgumentParser(
        description="Bambu-Bus RS-485 data capture tool (read-only)",
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

    stop_flag = {"stop": False}
    def _handle_shutdown(signum, frame):
        print("\n[bm_capture] Shutdown signal received. Closing files...")
        stop_flag["stop"] = True
    signal.signal(signal.SIGINT, _handle_shutdown)
    if hasattr(signal, "SIGTERM"):
        signal.signal(signal.SIGTERM, _handle_shutdown)

    try:
        ser = open_serial_port(args)
    except SerialException as e:
        print(f"ERROR: Could not open serial port '{args.port}': {e}", file=sys.stderr)
        return 1

    if not args.quiet:
        print(f"[bm_capture] Python: {sys.version.split()[0]}")
        print(f"[bm_capture] Listening on {args.port} @ {args.baud} {args.bytesize}{args.parity}{args.stopbits}")
        print(f"[bm_capture] Writing raw data to: {base_filename}.raw.bin")
        print(f"[bm_capture] Writing hex log to:  {base_filename}.hex.log")
        print("[bm_capture] Press Ctrl+C to stop.")

    start_time = time.time()
    last_flush_time = start_time
    
    try:
        while not stop_flag["stop"]:
            if args.max_runtime > 0 and (time.time() - start_time) >= args.max_runtime:
                print("[bm_capture] Maximum runtime reached.")
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

            if time.time() - last_flush_time > 2.0:
                raw_writer.flush()
                hex_writer.flush()
                last_flush_time = time.time()

    finally:
        print("[bm_capture] Cleaning up...")
        if 'ser' in locals() and ser.is_open:
            ser.close()
        raw_writer.close()
        hex_writer.close()

    if not args.quiet:
        print("[bm_capture] Done.")
    return 0

if __name__ == "__main__":
    sys.exit(main())
