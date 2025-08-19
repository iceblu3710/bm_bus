# Detailed Analysis & Findings

*Version: 2025-08-19*

This document expands the packet-format explanation for **standard**, **stuffed (A-series variant)**, and **high‑speed streaming** traffic, and lays out practical approaches for **payload interpretation** and **G‑code correlation/extraction**. Statements are grouped as **Confirmed**, **Strong Evidence**, or **Hypothesis** where applicable.

---

## Table of Contents

1. Frame Families (Overview)
2. Standard Packets (Long/Short Headers)
3. Stuffed Packets (A‑series Toolhead Variant)
4. High‑Speed Streaming Packets (Motion Bursts)
5. Payload Structure & Field Patterns
6. G‑code Correlation & Extraction Method
7. Parsers: Robust Framing & Validation
8. Test Plans & Next Steps
9. Reference Schemas & Pseudocode

---

## 1) Frame Families (Overview)

**Bus:** RS‑485 (half‑duplex), UART 1,228,800 bps, 8E1. All families share a trailing **CRC‑16/CCITT** over the frame (sans CRC bytes). The **SOF** byte `0x3D` is common to standard frames; the A‑series stuffed variant uses an additional on‑wire signature (see §3).

* **Family A — Standard (Long/Short headers):**

  * **Long**: addressed, fixed header with CRC‑8 on the header, CRC‑16 on the full frame.
  * **Short**: compact, fixed channel/type, also uses CRC‑8 header + CRC‑16 frame.
* **Family B — Stuffed (A‑series Toolhead):**

  * Uses **byte‑stuffing** inside payload; validates with **CRC‑16 init = 0xFFFF** *after* de‑stuffing.
* **Family C — High‑Speed Streaming (HSS):**

  * Characterized by **rapid sequences** of similarly sized frames (often same type), carrying **dense motion/telemetry samples**; designed to amortize overhead during fast toolpath segments. (Format details below include hypotheses with tests.)

---

## 2) Standard Packets (Long/Short Headers)

### 2.1 Long Header (Confirmed)

```
Byte  Off  Size  Name                  Notes
----  ---  ----  --------------------  ---------------------------------------
0     +0   1     SOF                   0x3D
1     +1   1     FLAG                  <0x80 → Long header
2     +2   2LE   SEQ                   Monotonic per link (wraps)
4     +4   2LE   LEN                   Total frame bytes, incl CRC16
6     +6   1     CRC8_HDR              Over bytes [0..5], poly 0x39, init 0x66
7     +7   2LE   DST                   Device address (little‑endian)
9     +9   2LE   SRC                   Device address (little‑endian)
11    +11  ...   PAYLOAD               LEN dictates size (LEN−(header+CRC))
LEN-2 +?   2LE   CRC16_CCITT           Poly 0x1021, init 0x913D (see §3/§4)
```

### 2.2 Short Header (Confirmed)

```
Byte  Off  Size  Name                  Notes
----  ---  ----  --------------------  ---------------------------------------
0     +0   1     SOF                   0x3D
1     +1   1     FLAG_SEQ              ≥0x80 → Short hdr; upper bit(s) act as flag, low bits often carry seq nibble/counter
2     +2   1     LEN                    Total incl CRC16 (1‑byte length)
3     +3   1     CRC8_HDR               Over bytes [0..2]
4     +4   1     TYPE                   Channel op/type (e.g., AMS‑Lite class)
5     +5  ...    PAYLOAD
LEN-2 +?   2LE   CRC16_CCITT
```

**Notes:**

* In Short headers the sequence information may be packed with `FLAG_SEQ` (lower bits) or appear in the payload prologue depending on device/firmware. Treat as device‑specific until confirmed on a given link.

---

## 3) Stuffed Packets (A‑series Toolhead Variant)

### 3.1 On‑wire Signature (Strong Evidence)

* Bursts begin with recognizable bytes **`0x61 0x9D`** near the start of the frame, preceding or within the payload region.

### 3.2 Payload Byte‑Stuffing (Strong Evidence)

* **Rule (empirical):** within the **payload** (not header/trailer), if a byte equals `0x61` *or* `0x9D` and the **next byte is `0x00`**, drop the `0x00` before CRC validation.
* Rationale: avoids accidental in‑band control/preamble collisions on a fast, noise‑sensitive link to the toolhead.

### 3.3 CRC Behavior (Confirmed on captured data)

* **Header:** process as for Standard (CRC‑8 on header fields if present).
* **Frame CRC‑16:** compute **after de‑stuffing**, with **init = `0xFFFF`**; store/retrieve in **little‑endian** at the trailer.

### 3.4 Parser Order of Operations (Confirmed)

1. Detect SOF/variant signature.
2. Parse header, validate `CRC8_HDR` if present.
3. Extract raw payload; **de‑stuff** using the rule above.
4. Compute `CRC16_CCITT` over (header + de‑stuffed payload); compare with trailer.
5. If validation fails, retry with `init = 0x913D` (defensive); if still failing, mark as unknown variant.

---

## 4) High‑Speed Streaming Packets (Motion Bursts)

> **Goal:** isolate packets that carry *densely packed motion/telemetry samples* during fast contouring, where per‑move command overhead would be prohibitive.

### 4.1 Phenomenology (Strong Evidence)

* During rapid `G0/G1` sweeps, captures show **runs of frames** with:

  * **Stable TYPE** (Short‑family links) or stable **opcode** (Long‑family),
  * **Uniform lengths** (e.g., repeated 32/48/64‑byte payloads),
  * **Monotonic sequence** and **tight inter‑frame timing**.

### 4.2 Candidate Formats (Hypotheses with Tests)

We model HSS payloads as **base‑timestamped blocks** followed by **delta‑encoded samples**. Two packing styles commonly fit observed redundancies:

**A) Fixed‑width delta tuples**

```
struct HSS_Payload_A {
  u16 base_tick;        // sample clock, tick units TBD
  u8  sample_count;     // N samples encoded below
  u8  flags;            // bitfield: axes present, extruder on, etc.
  repeat N times {
    s16 dx, s16 dy, s16 dz, s16 de; // two's complement deltas
  }
}
```

**B) Nibble/byte‑packed deltas (space‑optimized)**

```
struct HSS_Payload_B {
  u16 base_tick;
  u8  sample_count;
  u8  layout_code;      // selects packing scheme (e.g., 12‑bit deltas)
  bytes packed_deltas;  // decoded via layout_code LUT
}
```

**Detection Heuristics:**

* **Energy test:** run a fast “delta variance” check; motion bursts show balanced ± deltas, low entropy per axis compared to random noise.
* **Axis toggles:** flipping only one axis in a test print should primarily flip a single lane in the tuple.
* **Length‑vs‑count:** for fixed N, payload length should scale linearly.

**Validation Experiment:** execute designed motion micro‑sequences (e.g., `1×+`, `1×−`, `3×+`, `3×−` on X/Y/Z/E) and verify that tuple lanes toggle accordingly (§8).

---

## 5) Payload Structure & Field Patterns

> **Approach:** characterize fields by **stability across layers**, **sensitivity to controlled stimuli**, and **units**.

### 5.1 Common Field Archetypes (Strong Evidence)

* **Status bitfields** (1–2 bytes): heaters/fans/door/limit switches, error flags.
* **Telemetry scalars** (LE16/LE32): temperatures (×10 or ×100), RPM, voltages (mV), current (mA).
* **Motion counters**: step counts, microstep accumulators, planner indices.
* **Seq/ack**: sliding window counters, retry hints.

### 5.2 Layout Discovery Playbook

1. **Freeze & Flip**: hold all but one actuator constant; flip the target (e.g., fan from 0→50→100%). Track which fields move linearly with the knob.
2. **Slope & Offset**: fit `y = a·x + b` to candidate fields vs. a ground‑truth probe (host temp reading, tachometer). Infer units and scale.
3. **Mask Sweep**: for a byte that toggles “in place,” enumerate bit masks (1<\<n) vs. binary stimuli (endstop press, heater enable, light toggle).

### 5.3 Example Payload Templates (Illustrative)

**Toolhead telemetry (Long)**

```
[00:01] u16 seq
[02:03] u16 len
[04]    u8  hdr_crc
[05:06] u16 dst (TH)
[07:08] u16 src (MC)
[09]    u8  ptype = 0x2A  // "TH status" (example label)
[0A:0B] s16 nozzle_temp_x10
[0C:0D] s16 bed_temp_x10   // may be relayed
[0E]    u8  fan_pwm
[0F]    u8  status_bits    // bit0:heater_on, bit1:fan_on, ...
...
[--]    u16 crc16
```

**AMS‑Lite short (TYPE=0x20 Heartbeat)**

```
[04] u8  type = 0x20
[05] u8  hb_counter
[06] u8  status
[07] u8  temp_x1
[08] u8  reserved
...
```

> The exact byte meanings vary by firmware; treat the templates as anchors for field‑hunting rather than fixed specs.

---

## 6) G‑code Correlation & Extraction Method

**Objective:** produce a per‑layer/per‑segment map from **G‑code intents** (e.g., `M104`, `M109`, `G0/G1`, `M106`, `M73`) to **bus packets**, then generate **per‑layer summaries** and **op‑to‑packet** indexes.

### 6.1 Anchors (Confirmed/Useful)

* **`M73` layer markers**: highly repeatable bus activity clusters near these markers make them reliable time anchors for layer boundaries.
* **Temperature/fan ops**: `M104/M109` (nozzle), `M140/M190` (bed), `M106/M107` (fan) create distinct AMS/TH traffic bursts.

### 6.2 Timeline Alignment (Procedure)

1. **Build a host timeline** from the G‑code file: (time, op, args). If printer host time is unavailable, assign **logical time** by cumulative print kinematics.
2. **Build a bus timeline** from `.bm.jsonl`: (t\_rx, header, src/dst, type, len, hash(payload)).
3. **Cross‑correlate** around `M73` anchors: locate recurring packet templates within ±Δt windows of each `M73`.
4. **Associate ops**: for each op in the G‑code, tag the nearest consistent packet family spike (e.g., fan command ↔ packet with PWM field change).

### 6.3 Per‑Layer Summaries

* **Motion**: estimate total XY length, E extrusion (via HSS tuples or step counters).
* **Thermals**: average nozzle/bed temps, time‑to‑target, overshoot.
* **Fans**: PWM plateaus per layer.

### 6.4 Practical Extraction (Examples)

**A) Extract likely fan changes**

```bash
jq 'select(.type=="short" and .fields.type=="0x20") | {t:.t, p:.payload_hex}' bm_session.bm.jsonl \
 | grep -Ei "(0x(M106|M107)|pwm)"  # heuristic or post‑join with gcode timeline
```

**B) Per‑layer aggregation skeleton (Python)**

```python
from collections import defaultdict
layers = defaultdict(lambda: {"len_xy":0.0, "extrude":0.0, "fan":[], "temp":[]})
# iterate bm.jsonl + mapped anchors; accumulate per layer
```

---

## 7) Parsers: Robust Framing & Validation

**Two‑phase strategy (implemented in this repo):**

* **Phase A — Header Scan:**

  * Sync to SOF (0x3D), parse header by family (Long/Short), check `CRC8_HDR`, read `LEN`, verify `CRC16` with primary init (`0x913D`).

* **Phase B — CRC‑Anchored Search:**

  * Sweep the stream for valid CRC16 tails; propose frame bounds backward; retry with alternate init (`0xFFFF`) and, where signature suggests, **de‑stuff**. This recovers frames in noisy sections and **captures stuffed variants** that a strict header parser might skip.

* **Variant hints:**

  * **Stuffed**: signature bytes `0x61 0x9D` near the payload start; many payload bytes paired with `0x00` sentinels.
  * **HSS**: repeated lengths/types at sub‑millisecond spacing; delta‑like payload changes.

---

## 8) Test Plans & Next Steps

1. **Motion Isolation Suite:** micro‑sequences per axis (`1×+`, `1×−`, `3×+`, `3×−`, E on/off). Confirm HSS lane mapping and sign conventions.
2. **Thermal Ramps:** step nozzle/bed targets; fit slope/unit of candidate telemetry fields.
3. **Fan Plateaus:** 0%→30%→60%→100% step test; map PWM byte and confirm AMS/TH pathways.
4. **Stuffing Edge Cases:** craft data with frequent `0x3D`, `0x61`, `0x9D` to probe stuffing boundary conditions.
5. **Autodetect Init/Variant:** add a fast heuristic to choose CRC init + (de)stuff path based on success rates within a sliding window.

---

## 9) Reference Schemas & Pseudocode

### 9.1 Minimal JSONL Schema (used by tools)

```json
{
  "t": 12345.678,            // rx timestamp (s)
  "offset": 987654,          // byte offset in raw
  "family": "long|short|stuffed|hss",
  "len": 64,
  "seq": 512,
  "src": "0x09", "dst": "0x08",
  "type": "0x20",           // when applicable
  "crc8_ok": true,
  "crc16_ok": true,
  "payload_hex": "...",     // post de‑stuff when variant
  "notes": "optional"
}
```

### 9.2 CRCs

```python
def crc8_hdr(bs, init=0x66, poly=0x39):
    c = init
    for b in bs:
        c ^= b
        for _ in range(8):
            c = ((c << 1) ^ poly) & 0xFF if (c & 0x80) else (c << 1) & 0xFF
    return c

def crc16_ccitt(bs, init=0x913D):
    c = init
    for b in bs:
        c ^= (b << 8)
        for _ in range(8):
            c = ((c << 1) ^ 0x1021) & 0xFFFF if (c & 0x8000) else (c << 1) & 0xFFFF
    return c
```

### 9.3 De‑stuffing (A‑series Variant)

```python
def destuff(payload: bytes) -> bytes:
    out, i = bytearray(), 0
    while i < len(payload):
        out.append(payload[i])
        if payload[i] in (0x61, 0x9D) and i + 1 < len(payload) and payload[i+1] == 0x00:
            i += 2  # skip sentinel
        else:
            i += 1
    return bytes(out)
```

### 9.4 HSS Tuple Decoder Skeleton (Hypothesis‑driven)

```python
LAYOUTS = {
  0x00: ("s16", ["dx","dy","dz","de"]),
  0x01: ("s12", ["dx","dy","dz","de"])  # nibble‑packed example
}

def decode_hss(payload):
    base_tick = int.from_bytes(payload[0:2], 'little')
    n = payload[2]
    code = payload[3]
    fmt, lanes = LAYOUTS.get(code, ("s16", ["dx","dy","dz","de"]))
    data = payload[4:]
    samples = parse_packed(data, fmt, len(lanes), n)
    return base_tick, [dict(zip(lanes, s)) for s in samples]
```
