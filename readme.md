# Bambu‑Bus: Community Spec & Implementation Notes (2025-08-15)

> **Scope.** This document consolidates what the community has published and observed about the Bambu‑Bus used by Bambu Lab printers (X/P/A series) to communicate with peripherals like the toolhead (TH) and AMS/AMS‑Lite. It blends public references with empirical findings from bus captures. It is **unofficial** and may be incomplete or wrong in places—verify on your hardware.

---

## 1) Physical & Link Layer

- **Medium:** Differential **RS‑485** (half‑duplex).  
- **Framing UART:** **1,228,800 bps**, **8E1** (8 data bits, **E**ven parity, 1 stop).  
- **Cabling / connectors:**
  - X/P series use 4‑pin & 6‑pin “Bambu‑Bus” cables (printer↔hub/buffer↔AMS).  
  - **A1/A1 mini toolhead** uses a **USB‑C** harness end‑to‑end (mechanical form factor). Despite the connector, traffic observed on the lines matches RS‑485 timing and parity, not USB. (Bambu has not published the electrical pinout.)

**Topology (practical):**
- One printer host (AP/MC) and multiple peripherals (AMS/AMS‑Lite/TH). Many installs behave like a **multi‑drop shared bus** with addressing in the frame; printers often expose **two Bambu‑Bus ports** (one used by AMS). On A‑series, the toolhead link is point‑to‑point physically but still carries addressed frames.

> **Safety**: Always **sniff read‑only**. Use an isolated RS‑485/USB dongle; share ground; never power inject. Avoid “monitor mode” devices that might drive the bus.

---

## 2) Framing & Headers (wire protocol)

Two header styles appear across devices, both starting with a fixed **SOF byte** and followed by header CRC and a trailing **CRC‑16** for the full frame.

### 2.1 Long Header (multi‑device addressed)

```
Offset  Size  Field
0       1     SOF = 0x3D
1       1     Flag (must be < 0x80)
2..3    2     Sequence (LE)
4..5    2     Total length L (LE) — whole frame
6       1     CRC8(header)
7..8    2     Target address (LE)
9..10   2     Source address (LE)
11..L-3 L-13  Payload
L-2..L-1 2    CRC16(frame) (LE)
```

**CRC8(header)**: poly `0x39`, init `0x66`, no xor/reflection.  
**CRC16(frame)**: CCITT‑16 poly `0x1021`, init **`0x913D`**, no xor/reflection, **LE** storage.

### 2.2 Short Header (fixed master↔slave channel)

```
Offset  Size  Field
0       1     SOF = 0x3D
1       1     Flag|Seq (>= 0x80)
2       1     Total length L (incl. CRC)
3       1     CRC8(header)
4       1     Packet Type
5..L-3  L-7   Payload
L-2..L-1 2    CRC16(frame) (LE)
```

Same CRC8/CRC16 algorithms as above.

> **Empirical A‑series note**: On the A1 toolhead link, a recurring **two‑byte signature `0x61 0x9D`** is often seen at the start of framed bursts. Payloads appear **byte‑stuffed** (see §3) and validate with CRC‑16/CCITT using **init `0xFFFF`** once de‑stuffed. This seems to be an *on‑wire variant* of the same logical frames.

---

## 3) Escaping / Byte‑Stuffing

On certain links (notably A‑series toolhead), captures show **stuffing** to protect in‑band control bytes. A practical de‑stuffer that yields many CRC‑valid frames is:

- In the **payload region** (after the header): if a payload byte equals **0x61** or **0x9D**, and the **next byte is `0x00`**, **drop the `0x00`**.  
- Compute CRC over the **de‑stuffed** bytes.

Stuffing may be applied only to a subset of bytes (implementation detail varies). Always check CRC after de‑stuffing.

---

## 4) Addressing

Community‑collected IDs (LE unless noted); names vary by model:

| ID    | Name / Role                                  |
|-------|----------------------------------------------|
| 0x03  | **MC** – Motion Controller                   |
| 0x06  | **AP** – “Upper computer” (X‑series)         |
| 0x09  | **AP2** – “Upper computer” (P/A‑series)      |
| 0x07  | **AMS**                                      |
| 0x12  | **AMS‑Lite**                                 |
| 0x08  | **TH** – Toolhead                            |
| 0x0E  | **AHB**                                      |
| 0x0F  | **EXT** (external / expansion)               |
| 0x13  | **CTC**                                      |
| 0x01  | SYS (seen on some units)                     |
| 0x02  | UI/LCD (model‑dependent)                     |

> **Tip**: When sniffing, homing/motion sequences typically show **MC → TH** commands and **TH → MC** status/telemetry traffic.

---

## 5) Short‑Type Codes (seen with AMS‑Lite)

The **Short Header** packet `Type` byte values commonly observed on AMS‑Lite links:

| Type | Purpose (community interpretation)           |
|------|----------------------------------------------|
| 0x03 | Read filament movement info                  |
| 0x04 | Read/Change AMS‑Lite motion state            |
| 0x05 | Liveness / “is device online”                |
| 0x06 | Unknown                                      |
| 0x07 | Read NFC info                                |
| 0x20 | Printer heartbeat                            |

> **Note**: Toolhead traffic uses different opcodes; these remain under active reverse‑engineering.

---

## 6) Parsing Outline (pseudocode)

```python
# Detect SOF and header form
if buf[0] == 0x3D:
    if buf[1] < 0x80:    # long
        hdr = parse_long(buf)
    else:                # short
        hdr = parse_short(buf)
# A-series toolhead variant (empirical)
elif buf[0:2] == b"\x61\x9D":
    hdr = parse_variant_619d(buf)  # length after sig; payload likely stuffed

# Verify CRC8(header) if present; then compute CRC16 over frame_minus_crc
if not crc8_ok(hdr): reject()
frame_no_crc = maybe_destuff(hdr.payload_region) joined with header
if crc16_ccitt(frame_no_crc, init=hdr.crc16_init) == crc16_from_tail:
    accept()
else:
    try_other_crc16_inits_or_destuffing()
```

**CRC8 (header):** poly `0x39`, init `0x66`.  
**CRC16 (frame):** CCITT poly `0x1021`; **init either `0x913D` (documented) or `0xFFFF` (empirical on A‑series toolhead)**; store CRC **LE**.

---

## 7) Sniffing & Lab Setup

- **Adapter**: USB⇄RS‑485 (5V‑isolated preferred). Configure **1,228,800 baud, 8E1**.  
- **Tap points**:
  - **X/P‑series**: spare AMS/Hub port with official 4‑pin/6‑pin cables (GND + differential pair).  
  - **A‑series toolhead**: break out the **USB‑C** harness (non‑USB signaling) to RS‑485 A/B. **Do not** attach to live USB hosts.
- **Minimal logger**: capture raw bytes and hex; then parse in a second pass (length → de‑stuff → CRC).  
- **Non‑intrusive**: keep the converter *receive‑only*. Some adapters expose RE/DE—leave them **disabled**.

---

## 8) Tooling & Projects

- **Docs & Parsers**: Community **Bambu‑Bus** repo includes header specs, address map, and a Python “Protoparser”.  
- **Emulators**: **AMCU** (AMS emulator).  
- **A‑series AMS alternative**: **BMCU** (open DIY AMS‑like for A1/A1 mini).

---

## 9) Legal / Policy Notes (non‑lawyer)

- The bus is **proprietary** and undocumented by the vendor. Reverse‑engineering for **interoperability** may be permitted in some jurisdictions. Avoid using vendor firmware/binaries or secrets. Prefer **clean‑room** approaches, publish **original** code, and avoid trademarked names in your project branding.

---

## 10) Field Notes & Gotchas

- Expect **both** header styles in mixed systems (e.g., AP↔AMS long; MC↔peripheral short).  
- Different sub‑systems may use different **CRC init** values (0x913D vs 0xFFFF). Check both on de‑stuffed payloads.  
- Some frames are **ACK‑only** (no payload).  
- When logs show bogus giant frames, switch to **CRC‑anchored** slicing (scan for valid CRC tails rather than “next signature”).  
- On A‑series toolhead, the "USB‑C" harness is mechanically USB‑C; **traffic is not USB** on the data pair.

---

## 11) Checklists

**Hook‑up checklist**  
- [ ] RS‑485 dongle on **RX‑only**  
- [ ] GND common with printer  
- [ ] 1,228,800 / 8E1  
- [ ] Disable local echo / TX  
- [ ] Start with passive capture

**Parser checklist**  
- [ ] Find SOF (0x3D or 0x61 0x9D)  
- [ ] Determine header form  
- [ ] Verify CRC8 (if present)  
- [ ] De‑stuff payload (if variant)  
- [ ] CRC16 over frame (try 0x913D, then 0xFFFF)  
- [ ] Map addresses / opcodes

---

## 12) References (selected)

- Bambu‑Bus community spec & tools (headers, CRC, address map):  
  - README (long/short headers; CRC8=0x39 init 0x66; CRC16=0x1021 init 0x913D; addressing).  
- Bambu official hardware guides (A1/A1 mini/X1): USB‑C **cable** replacement + toolhead/board service docs (connector is USB‑C; signaling not documented).  
- Official “Bambu‑Bus Cable” (X/P series) product pages (4‑pin/6‑pin variants; indicates dedicated bus cabling).  
- AMCU emulator + notes; BMCU (A‑series DIY AMS) write‑ups.

> For link list, see the appendix below.

---

## Appendix: Link List

- Bambu‑Bus spec & tools (community):  
  - https://github.com/Bambu-Research-Group/Bambu-Bus  
  - https://github.com/iceblu3710/Bambu-Bus (fork)

- A1/A1 mini official maintenance guides (USB‑C harness used to the toolhead):  
  - https://wiki.bambulab.com/en/a1/maintenance/usb-c-cable-replacement-guide  
  - https://wiki.bambulab.com/en/a1-mini/maintenance/usb-c-replacement-guide  
  - https://wiki.bambulab.com/en/a1-mini/maintenance/toolhead  
  - https://wiki.bambulab.com/en/x1/maintenance/replace-typec-cable

- Bambu‑Bus cable product pages (X/P series cabling):  
  - https://us.store.bambulab.com/products/bambu-bus-cable  
  - https://asia.store.bambulab.com/products/bambu-bus-cable-4pin

- Community AMS emulation / alternatives:  
  - https://github.com/Bambu-Research-Group/Bambu-Bus (AMCU folder)  
  - https://adriel.dev/posts/2025-06-05-bmcu-an-open-source-ams-for-the-a1-mini  
  - https://wiki.yuekai.fr/BMCU

---

*Prepared for offline use; no external scripts required.*