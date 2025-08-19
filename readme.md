# bm_bus — Bambu-Bus Sniffer & Parser (A-/X-/P-series, AMS/AMS-Lite)

Reverse-engineering notes, working capture/parsing tools, and a practical field guide for decoding the Bambu-Bus used between the printer controller(s) and peripherals (toolhead, AMS/AMS-Lite). This repo focuses on **read-only sniffing** and **offline analysis**.

> **Disclaimer**  
> This is an unofficial, community-driven effort. Details can be incomplete or wrong; always validate on your own hardware. Do not transmit on the bus; log *only*.

---

## What’s new (Aug 2025)

- **A-series toolhead variant recognized**: recurring on-wire signature `0x61 0x9D`, with payload **byte-stuffing** (see below) and CRC-16/CCITT validating with **init `0xFFFF`** after de-stuffing.  
- **Dual CRC-16 inits to try** when validating frames: standard `0x913D` (most long/short header traffic) and `0xFFFF` (A-series/stuffed variant).
- **End-to-end tooling**:
  - `bm_capture.py` — lossless raw logger (raw `.bin` + timestamped hex `.log`).
  - `bm_capture_clean.py` — raw logger that filters out `0x00` silence to keep files small.
  - `bm_logger_full.py` — live capture **plus** best-effort BM frame extraction to `.bm.jsonl`.
  - `bm_parse.py` — offline, **two-phase** parser (header scan + CRC-anchored search) for big captures; outputs a unified `.bm.jsonl` and a summary report.
  - `bm_parse_map.py` — scaffolding to map **G-code → bus packets** (e.g., `M73`, `G0/G1`, heaters).

---

## Quick start

### 1) Hardware (sniff only!)
- **Bus**: RS-485 (half-duplex), UART **1228800 bps**, **8E1**.
- **Tap points**  
  - **X/P series**: spare Bambu-Bus/AMS port (4-pin/6-pin cable).  
  - **A1/A1 mini toolhead**: USB-C **harness is not USB signaling**; break out to the RS-485 pair (A/B) and a common GND. Do **not** attach to a PC’s USB port.
- **Adapter**: Isolated USB⇄RS-485 recommended. **Receive-only**; never drive RE/DE.

### 2) Capture (lossless)
```bash
# Windows
python bm_capture.py --port COM5

# Linux
python bm_capture.py --port /dev/ttyUSB0

# macOS
python bm_capture.py --port /dev/tty.usbserial-XXXXX
