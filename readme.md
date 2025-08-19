# bm\_bus — Bambu-Bus Sniffer & Parser (A-/X-/P-series, AMS/AMS-Lite)

Reverse-engineering notes, working capture/parsing tools, and a practical field guide for decoding the Bambu-Bus used between the printer controller(s) and peripherals (toolhead, AMS/AMS-Lite). This repo focuses on **read-only sniffing** and **offline analysis**.

> **Disclaimer**
> This is an unofficial, community-driven effort. Details can be incomplete or wrong; always validate on your own hardware. Do not transmit on the bus; log *only*.

---

## What’s new (Aug 2025)

* **A-series toolhead variant recognized**: recurring on-wire signature `0x61 0x9D`, with payload **byte-stuffing** and CRC-16/CCITT validating with **init `0xFFFF`** after de-stuffing.
* **Dual CRC-16 inits to try** when validating frames: standard `0x913D` (most long/short header traffic) and `0xFFFF` (A-series/stuffed variant).
* **Tooling**:

  * `bm_capture.py` — lossless raw logger (raw `.bin` + timestamped hex `.log`).
  * `bm_capture_clean.py` — raw logger that filters out `0x00` silence to keep files small.
  * `bm_logger_full.py` — live capture **plus** best-effort BM frame extraction to `.bm.jsonl`.
  * `bm_parse.py` — offline parser (header scan + CRC-anchored search) → unified `.bm.jsonl` + summary.
  * `bm_parse_map.py` — scaffolding to map **G-code → bus packets**.

---

## Quick start

**Deep dive:** See **[Detailed Analysis & Findings → `findings/DETAILED_ANALYSIS.md`](findings/DETAILED_ANALYSIS.md)** for the full hypotheses, methods, experiments, and results.

### 1) Hardware (sniff only!)

* **Bus**: RS-485 (half-duplex), UART **1,228,800 bps**, **8E1**. Keep the adapter **RX-only**.

### 2) Capture (lossless)

```bash
# Windows
python bm_capture.py --port COM5

# Linux
python bm_capture.py --port /dev/ttyUSB0

# macOS
python bm_capture.py --port /dev/tty.usbserial-XXXXX
```

Outputs:

* `bm_session_YYYYMMDD_HHMMSS.raw.bin` — ground-truth bytes
* `bm_session_YYYYMMDD_HHMMSS.hex.log` — timestamped hex lines

**Tip:** Use `bm_capture_clean.py` if you want to drop inter-packet `0x00` silence for smaller files.

### 3) (Optional) Live best-effort frame log

```bash
python bm_logger_full.py --port COM5 --bm-enable
# writes raw.bin + hex.log + bm.jsonl (parsed frames)
```

### 4) Offline parse (recommended)

```bash
python bm_parse.py --infile bm_session_YYYYMMDD_HHMMSS.raw.bin
# -> bm_session_YYYYMMDD_HHMMSS.bm.jsonl (+ console summary)
```

---

## Protocol primer

### Physical / link

* **Medium**: RS-485 (half-duplex), **1,228,800 bps / 8E1**.

### Headers (SOF `0x3D`)

* **Long header**: addressed frames with CRC-8 header + CRC-16 frame.
* **Short header**: compact master↔slave with type byte.
* **CRCs**: `CRC8` poly `0x39`, init `0x66`; `CRC16/CCITT` poly `0x1021`, init **`0x913D`** typical, or **`0xFFFF`** for A-series variant after de-stuff.

### A-series variant (`0x61 0x9D` + stuffing)

De-stuff rule (empirical): in the payload region, if a byte is `0x61` or `0x9D` and the next byte is `0x00`, drop the `0x00`; then CRC-16 with init `0xFFFF`.

### Device addressing (LE)

`0x03 MC`, `0x06 AP`, `0x09 AP2`, `0x07 AMS`, `0x12 AMS-Lite`, `0x08 TH`, `0x0E AHB`, `0x0F EXT`, `0x13 CTC`, `0x01 SYS`, `0x02 UI/LCD`.

### Short-type values (AMS-Lite examples)

`0x03` filament movement, `0x04` motion state, `0x05` liveness, `0x06` unknown, `0x07` NFC, `0x20` heartbeat.

---

## Tools in this repo

* **`bm_capture.py`** — lossless raw logger (raw `.bin` + hex).
* **`bm_capture_clean.py`** — same but filters idle `0x00` to shrink files.
* **`bm_logger_full.py`** — capture + header-aware extraction into `.bm.jsonl`.
* **`bm_parse.py`** — offline parser: header scan + CRC-anchored search; merges results.
* **`bm_parse_map.py`** — G-code ↔ packet mapping scaffold.

---

## Analysis workflow

1. **Capture** while running a known job (see `plate_1.gcode`).
2. **Parse** the raw `.bin` with `bm_parse.py` → `.bm.jsonl`.
3. **Correlate** with host actions; use **`M73` layer markers** as anchors; look for repeating templates near each marker.
4. **Iterate**: fill `bm_parse_map.py` with confirmed opcodes/fields.

---

## Contributing

Please add confirmed **address/type maps** and **payload layouts** (with model/firmware), short labeled captures, and matching G-code.

---

## Legal

Reverse-engineering for interoperability may be allowed; avoid transmitting on-bus and never use vendor secrets.
