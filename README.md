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

 ## Figure 1: Custom testbench used to verify forwarding paths, load/store operations, branch flushing, and pipeline hazard handling in the RV32I processor.

 <img width="1633" height="892" alt="link2" src="https://github.com/user-attachments/assets/13bd0696-3b56-4ecd-8857-3e4d2433cc68" />

 ## Figure 2. Simulation Waveforms for Testbench 1

 <img width="1918" height="976" alt="link3" src="https://github.com/user-attachments/assets/26b0814e-80d6-4449-9765-64c88486e267" />

 ## Figure 3. Testbench for Data Forwarding, Load Hazards, and Control Hazard Verification.

 <img width="1625" height="867" alt="link4" src="https://github.com/user-attachments/assets/dfe4a489-b7e7-4fd5-b8d1-1d681fb04ea2" />

 ## Figure 4. Simulation Waveforms for Testbench 2

 <img width="1902" height="987" alt="link5" src="https://github.com/user-attachments/assets/ba88eca2-8874-4dfd-a098-b0125c182263" />


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
