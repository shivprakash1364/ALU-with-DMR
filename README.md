# Fault-Detection-in-ALU-with-DMR(dual modular redundancy)
This project presents the RTL design and verification of a fault-tolerant Arithmetic Logic Unit (ALU) based on Dual Modular Redundancy (DMR-A lightweight redundancy technique). Two identical ALU instances operate in parallel, and a comparator detects mismatches to identify datapath faults. The design is implemented in Verilog HDL and verified using RTL-level fault injection and waveform analysis.

## Motivation and Background
As CMOS technology scales, digital systems become increasingly vulnerable to transient and permanent faults caused by noise, aging, and radiation effects. In safety-critical and high-reliability systems, fault detection at the hardware level is essential.

## Architecture Overview
The proposed architecture consists of two identical combinational ALU modules operating on the same input operands and control signals. The outputs of both ALUs are compared using bitwise XOR logic followed by a 'reduction OR' operation. Any mismatch between the outputs raises an error flag, indicating the presence of a fault. The final result is taken from the primary ALU, while the error flag signals output validity to the system.

## ALU Functionality
The ALU supports the following operations:

| Opcode | Operation |
|--------|-----------|
| 000    | Addition |
| 001    | Subtraction |
| 010    | Bitwise AND |
| 011    | Bitwise OR |
| 100    | Bitwise XOR |
| 101    | Bitwise NOT (A) |
| 110    | Logical Shift Left |
| 111    | Logical Shift Right |

## Fault Model and Detection Logic
The fault model targets logic-level faults that cause incorrect ALU output bits, such as stuck-at faults or transient bit flips. Fault detection is implemented by comparing the outputs of the two ALU instances using bitwise XOR logic followed by a reduction OR operation. If any output bit differs, the error flag is asserted. This design focuses on fault detection and does not implement fault correction.

## Verification Methodology
The design was verified using RTL simulation. Normal operation was first validated for all supported ALU operations. Fault injection was then performed in the testbench by forcing a stuck-at fault on a selected output bit of the redundant ALU instance. Waveforms were captured using VCD dumping and analyzed to confirm correct assertion and de-assertion of the error flag under faulty and fault-free conditions.

## Results and Observations
Simulation results show that the ALU operates correctly under fault-free conditions, with identical outputs from both ALU instances and a de-asserted error flag. Upon fault injection, mismatches between redundant outputs were correctly detected, and the error flag was asserted. After fault removal, normal operation was restored. These results confirm the effectiveness of the DMR-based fault detection logic. Snipetts of the actual obtained outputs and waveforms of the verilog code are attached here:
<img width="638" height="389" alt="Screenshot (52)" src="https://github.com/user-attachments/assets/50a0734b-6ddd-4bfa-9b14-f736202d3ebb" />
and <img width="1274" height="153" alt="Screenshot (53)" src="https://github.com/user-attachments/assets/e9d05298-7ef9-427c-8f12-eb873aff7a5c" />

## Limitations and Future Work
The current design detects faults but does not perform error correction. Additionally, timing-related faults and analog effects are not modeled at the RTL level. Future extensions will include Triple Modular Redundancy (TMR), dynamic redundancy activation, or integration of the fault-tolerant ALU into a pipelined processor datapath.
