G-code Command Fingerprinting Analysis (v2)
This document details the reverse-engineering of the Bambu-Bus motor movement packet format, based on the Gem_hurist_nakkid capture. The heuristic G-code file provided a systematic way to isolate and identify the function of each byte in the command packets.

Key Findings
The analysis confirms that both G0 (rapid) and G1 (linear) movement commands use the same fundamental packet structure, starting with the 3b33 header. The primary difference is encoded in a "move type" flag. We were also able to decode the formats for distance and velocity.

Command Equivalence: G0 and G1 commands are functionally identical on the bus for simple moves; the only difference is a flag within the packet. The firmware likely interprets this flag to apply different acceleration profiles.

Data Encoding: Both distance and velocity are encoded as standard 32-bit single-precision floating-point numbers (IEEE 754 format), stored in little-endian byte order.

Correlation of G-code to Bus Frames
Block A: G1 with Varying Distance (F3000)
G1 X1 F3000 -> 3b33 01 00 00 0000803f 00004842

G1 X10 F3000 -> 3b33 01 00 00 00002041 00004842

G1 X50 F3000 -> 3b33 01 00 00 00004842 00004842

G1 X-10 F3000 -> 3b33 01 01 00 00002041 00004842

Analysis: The 4-byte value starting at byte [5] changes with distance, while the value at [9] (velocity) remains constant as expected. The direction byte [3] flips for negative movement.

Block B: G1 with Varying Feedrate (X10)
G1 X10 F600 -> 3b33 01 00 00 00002041 00002041

G1 X10 F6000 -> 3b33 01 00 00 00002041 00007042

G1 X10 F18000 -> 3b33 01 00 00 00002041 0000e143

Analysis: The distance value remains constant, while the 4-byte value at byte [9] changes with the feedrate.

Block C: G0 with Varying Distance
G0 X10 -> 3b33 01 00 01 00002041 00009644

G0 X50 -> 3b33 01 00 01 00004842 00009644

Analysis: G0 commands produce a packet with a 01 in the "Move Type" flag at byte [4]. The velocity is set to a constant high value (00009644, which is 1200.0 in float), representing the machine's maximum rapid travel speed.

Block D: Combined Axis Movement
G1 X10 Y10 F6000 -> 3b33 03 00 00 00002041 00007042

Analysis: As hypothesized, the axis byte [2] is a bitmask. 03 is the result of 01 (X-axis) OR 02 (Y-axis), correctly indicating a diagonal move.

Final Inferred Packet Format
The complete format for a G0/G1 movement command is a 13-byte payload (plus CRC).

Byte(s)

Example (G1 X10 F6000)

Inferred Purpose

Data Type / Notes

[0:2]

3b33

Command Header

Static identifier for a motor movement command.

[2]

01

Axis Bitmask

8-bit mask. 01=X, 02=Y, 04=Z, 08=E. Values are OR'd for combined moves (e.g., 03=XY).

[3]

00

Direction Flag

00 for positive (+), 01 for negative (-).

[4]

00

Move Type Flag

00 for G1 (Linear Move), 01 for G0 (Rapid Move).

[5:9]

00002041

Distance (mm)

32-bit float (little-endian). 0x41200000 = 10.0.

[9:13]

00007042

Velocity (mm/s)

32-bit float (little-endian). 0x42700000 = 60.0 (from F6000 mm/min).

