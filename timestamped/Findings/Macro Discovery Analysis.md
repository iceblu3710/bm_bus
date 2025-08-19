Macro Discovery & Unassigned Address Analysis
The macro_analysis capture was successful in identifying a non-standard G-code command that communicates with an unassigned address on the Bambu-Bus. This provides a potential "hook" for triggering a custom device without interfering with normal printer operations.

Analysis of G-code Blocks
Each M code from your discovery script was correlated with the bus traffic captured immediately after its corresponding M73 marker.

M6xx Range (M650-M654): These commands generated no bus traffic. They appear to be unrecognized by the firmware and were likely ignored.

M9xx Range (M970-M979): The majority of these commands also produced no bus traffic. However, one command stands out.

M10xx Range (M1000-M1007): Similar to the M6xx range, these commands were unrecognized and produced no bus traffic.

Key Finding: M971 and Address 0x10
The G-code command M971 S1 C1 was the only command in the test set to generate a unique, standard 0x3D packet to an address not in the known device list.

G-code Command: M971 S1 C1 (Corresponds to M73 P201)

Captured Packet Details:

Parser Type: standard_3d

Source: 0x03 (MC - Main Controller)

Destination: 0x10 (Unknown Device)

Packet Type: 0x0d (G-code)

Decoded Payload: M971 S1 C1

The address 0x10 is not assigned to any known Bambu Lab peripheral (TH, AMS, AP, UI, etc.). This makes it an ideal candidate for a custom device address. The printer's main controller is capable of sending a standard G-code packet to this address, but since no device is there to respond, the command is simply sent once and forgotten.

Conclusion for Auto Plate Changer
The M971 command is a perfect trigger for your project.

Unique & Unused: It's a command that the firmware recognizes and acts upon (by sending a packet), but it targets an address that is, on a standard printer, unoccupied.

Non-Interfering: Sending M971 S1 C1 will not affect any other part of the printer's operation.

Implementation: You can program your custom plate changer's controller to listen on the Bambu-Bus for a packet addressed to 0x10. When it sees this specific G-code, it can trigger the physical plate-changing mechanism.

You can now add M971 S1 C1 to the end of your print G-code files to signal the plate changer to activate after a print is finished.