# 🚀 32-bit 5-Stage Pipelined RISC-V Processor (RV32I) in Verilog HDL

Designed and verified a **32-bit RISC-V RV32I processor** featuring a complete **5-stage pipelined architecture** in **Verilog HDL**. This project focuses on implementing a pipelined processor with efficient hazard management and functional verification.

## 🔹 Key Features

- Complete support for the **RISC-V RV32I instruction subset**
- 5-stage pipelined architecture (IF, ID, EX, MEM, WB)
- Dual-phase clocking model
- Pipeline registers between all stages
- Data forwarding unit to resolve RAW data hazards
- Control hazard handling through pipeline flushing
- Support for **Branch**, **JAL**, and **JALR** instructions
- Load/Store operations using dedicated Data Memory
- Separate Instruction Memory, Data Memory, and Register File architecture

## 🔹 Verification

- Developed a custom **Verilog testbench** for functional verification
- Tested arithmetic, logical, shift, load/store, branch, jump, and upper-immediate instructions
- Verified forwarding logic and branch redirection mechanisms
- Simulated loop execution using conditional branch instructions
- Confirmed correct pipeline operation under various hazard scenarios

## 📚 Learning Outcomes

This project provided hands-on experience in:

- RTL Processor Design
- RISC-V RV32I Architecture
- Pipeline Design
- Data and Control Hazard Management
- Forwarding Techniques
- RTL Functional Verification
- Testbench Development
- Processor Datapath and Control Design
