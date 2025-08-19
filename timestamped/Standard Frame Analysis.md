Analysis of Standard G-code Packets
The updated parser successfully identified 30 frames using the standard_3d header format. This analysis decodes these packets and confirms they directly correspond to the G-code commands sent to the printer for setup and heating.

Packet Structure for G-code Commands
These standard frames follow a clear, addressable format. The key fields decoded by the parser are:

Source (src): The device sending the command. In all these cases, it's the MC (Main Controller).

Destination (dest): The device receiving the command. For these commands, it's the TH (Toolhead).

Packet Type (ptype): The value 0x0d (13) confirms the payload is a G-code command.

Payload (payload_hex): The raw G-code command, encoded as an ASCII string.

G-code and Captured Packet Correlation
The following table matches the G-code commands from your script with the actual packets captured on the bus. This confirms that commands like M104, M140, M109, and M190 are sent as plain text within these standard frames.

Original G-code Command

Captured Packet Details (Source -> Dest)

Decoded Payload (ASCII)

M140 S60

MC -> TH (seq: 0)

M140 S60

M104 S140

MC -> TH (seq: 1)

M104 S140

M190 S60

MC -> TH (seq: 2)

M190 S60

M109 S140

MC -> TH (seq: 3)

M109 S140

G28

MC -> TH (seq: 4)

G28

M83

MC -> TH (seq: 5)

M83

G91

MC -> TH (seq: 6)

G91

M73 P1

MC -> TH (seq: 7)

M73 P1

G1 X1 F3000

MC -> TH (seq: 8)

G1 X1 F3000

M400

MC -> TH (seq: 9)

M400

M73 P2

MC -> TH (seq: 10)

M73 P2

G1 X10 F3000

MC -> TH (seq: 11)

G1 X10 F3000

M400

MC -> TH (seq: 12)

M400

M73 P3

MC -> TH (seq: 13)

M73 P3

G1 X50 F3000

MC -> TH (seq: 14)

G1 X50 F3000

M400

MC -> TH (seq: 0)

M400

M73 P4

MC -> TH (seq: 1)

M73 P4

G1 X-10 F3000

MC -> TH (seq: 2)

G1 X-10 F3000

M400

MC -> TH (seq: 3)

M400

G90

MC -> TH (seq: 4)

G90

G1 X128 Y128 F18000

MC -> TH (seq: 5)

G1 X128 Y128 F18000

G91

MC -> TH (seq: 6)

G91

M73 P10

MC -> TH (seq: 7)

M73 P10

G1 X10 F600

MC -> TH (seq: 8)

G1 X10 F600

M400

MC -> TH (seq: 9)

M400

M73 P11

MC -> TH (seq: 10)

M73 P11

G1 X10 F6000

MC -> TH (seq: 11)

G1 X10 F6000

M400

MC -> TH (seq: 12)

M400

M73 P12

MC -> TH (seq: 13)

M73 P12

G1 X10 F18000

MC -> TH (seq: 14)

G1 X10 F18000

Note: The sequence number resets after reaching 15.

Conclusion
This analysis provides a clear picture of the dual nature of the Bambu-Bus:

High-Level Commands: Standard G-code commands for non-movement tasks (heating, status, etc.) are sent as human-readable ASCII strings inside standard, addressed packets.

Low-Level Movement: The actual execution of G0 and G1 commands is handled by the specialized, raw binary packets (3b33...) we decoded previously.

The printer's main controller (MC) acts as a translator: it receives a standard G-code command like G1 X10 F600, acknowledges it, and then generates one or more of the specialized 3b33 packets to send to the toolhead (TH) to execute the physical movement.