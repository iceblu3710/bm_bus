Advanced G-code Command Analysis
This report details the findings from the m400_pause.raw.bin capture, which tested the printer's handling of inline G-code comments and user-initiated pauses (M400 U1).

Finding 1: Inline Comments in M971
The test definitively shows that the printer's firmware strips all inline comments before packaging and sending the G-code command on the bus.

G-code Sent: M971 S1 C1 ; EJECT PLATE

Packet Details:

Source: 0x03 (MC)

Destination: 0x10 (Unknown)

Packet Type: 0x0d (G-code)

Decoded ASCII Payload: M971 S1 C1

Conclusion: The comment ; EJECT PLATE was completely removed. This means you can safely add comments to your custom M971 commands in your G-code for readability without affecting the data received by your custom device. The device will only see the clean command.

Finding 2: Simulating the "Continue" Button
The analysis of the M400 U1 (wait for user) command reveals the exact mechanism for pausing and resuming, which can be simulated.

During the Pause
While the printer was paused waiting for the user to press "Resume," the UI screen (device 0x02) sent a continuous stream of status request packets to the Main Controller (MC - device 0x03). The MC responded with an ACK, but no other device sent any "resume" command.

The "Resume" Action
The "Resume" command is not sent from the UI screen. Instead, pressing the button on the screen causes the AP Board (Accessory Port - device 0x06) to send a specific, non-G-code command packet to the Main Controller.

Trigger Event: User presses "Resume" on the UI.

Resulting Packet:

Parser Type: standard_3d

Source: 0x06 (AP)

Destination: 0x03 (MC)

Packet Type: 0x07 (Control)

Payload (Hex): 05

Conclusion: The "continue" signal is a Control packet with a payload of 0x05, sent from the AP board to the MC.

How to Implement a "Wait for Device" Handshake
This discovery provides a clear path to creating a software-only handshake for your auto plate changer, without needing to wire into the probe pins.

Send Command to Plate Changer: Your G-code sends M971 S1 (or similar) to your device at address 0x10.

Initiate Pause: Your G-code immediately follows with M400 U1. The printer will now pause and wait.

Device Completes Task: Your auto plate changer performs its function.

Device Sends "Resume" Packet: Once finished, your custom device must send the following packet onto the bus:

Source Address: 0x06 (It must impersonate the AP board)

Destination Address: 0x03 (MC)

Packet Type: 0x07 (Control)

Payload: 0x05

Printer Resumes: The MC will receive this packet, interpret it as the "Resume" command, and continue executing the G-code file.

This method allows your custom device to tell the printer when it's finished, creating a robust, software-based handshake.