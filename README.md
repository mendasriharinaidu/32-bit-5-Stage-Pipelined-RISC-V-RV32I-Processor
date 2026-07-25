# 32-bit-5-Stage-Pipelined-RISC-V-RV32I-Processor 

# 🚀 32-bit 5-Stage Pipelined RISC-V Processor (RV32I)

A complete RTL implementation of a **32-bit 5-stage pipelined RISC-V (RV32I) processor** designed in **Verilog HDL**. The processor implements the classic pipelined architecture with hazard handling, forwarding logic, branch support, and dedicated instruction/data memories. Functional verification was performed using a custom Verilog testbench.

---

## 📌 Project Overview

This project implements a **32-bit RISC-V RV32I processor** using a **5-stage pipelined architecture** consisting of:

- **Instruction Fetch (IF)**
- **Instruction Decode (ID)**
- **Execute (EX)**
- **Memory Access (MEM)**
- **Write Back (WB)**

The design includes pipeline registers between every stage, hazard detection mechanisms, forwarding logic, and branch control to improve instruction throughput while maintaining correct program execution.

---

## ✨ Features

- ✅ Complete support for the RISC-V RV32I instruction subset
- ✅ 5-stage pipelined processor architecture
- ✅ Dual-phase clocking model
- ✅ Pipeline registers between all stages
- ✅ Data forwarding unit for resolving RAW hazards
- ✅ Control hazard handling through pipeline flushing
- ✅ Support for Branch, JAL, and JALR instructions
- ✅ Load and Store operations using dedicated Data Memory
- ✅ Separate Instruction Memory, Data Memory, and Register File architecture
- ✅ Modular RTL implementation in Verilog HDL

---

## 🏗️ Pipeline Architecture

```
Instruction Memory
        │
        ▼
+-------+-------+
|      IF       |
+-------+-------+
        │
     IF/ID
        │
        ▼
+-------+-------+
|      ID       |
+-------+-------+
        │
     ID/EX
        │
        ▼
+-------+-------+
|      EX       |
+-------+-------+
        │
    EX/MEM
        │
        ▼
+-------+-------+
|     MEM       |
+-------+-------+
        │
    MEM/WB
        │
        ▼
+-------+-------+
|      WB       |
+---------------+
```

---

## 🧩 Processor Components

- Program Counter (PC)
- Instruction Memory
- Register File (32 × 32-bit)
- Immediate Generator
- ALU
- Data Memory
- Pipeline Registers
  - IF/ID
  - ID/EX
  - EX/MEM
  - MEM/WB
- Data Forwarding Unit
- Branch & Jump Control Logic

---

## ⚠️ Hazard Handling

### Data Hazards

- Forwarding unit implemented
- Resolves Read-After-Write (RAW) hazards
- Eliminates unnecessary pipeline stalls for dependent instructions

### Control Hazards

- Pipeline flushing implemented
- Correct branch redirection
- Supports:
  - BEQ
  - BNE
  - BLT
  - BGE
  - JAL
  - JALR

---

## 📖 Supported Instruction Categories

### Arithmetic Instructions

- ADD
- SUB
- ADDI
- LUI
- AUIPC

### Logical Instructions

- AND
- OR
- XOR
- ANDI
- ORI
- XORI

### Shift Instructions

- SLL
- SRL
- SRA
- SLLI
- SRLI
- SRAI

### Comparison Instructions

- SLT
- SLTU
- SLTI
- SLTIU

### Memory Instructions

- LW
- SW

### Branch Instructions

- BEQ
- BNE
- BLT
- BGE

### Jump Instructions

- JAL
- JALR

---

## 🛠️ Verification

A custom Verilog testbench was developed to verify processor functionality.

### Verification Coverage

- ✅ Arithmetic operations
- ✅ Logical operations
- ✅ Shift operations
- ✅ Load and Store instructions
- ✅ Branch instructions
- ✅ Jump instructions (JAL & JALR)
- ✅ Upper-immediate instructions
- ✅ Forwarding logic
- ✅ Branch redirection
- ✅ Pipeline hazard scenarios
- ✅ Loop execution using conditional branches

---

## 📂 Project Structure

```
├── rtl/
│   ├── riscv_top.v
│   ├── alu.v
│   ├── register_file.v
│   ├── instruction_memory.v
│   ├── data_memory.v
│   ├── forwarding_unit.v
│   └── pipeline_registers.v
│
├── testbench/
│   └── riscv_tb.v
│
├── simulation/
│   ├── waveforms.vcd
│   └── screenshots/
│
├── docs/
│   └── architecture.png
│
└── README.md
```

---

## 🔬 Simulation

The processor was functionally verified using simulation.

Typical verification included:

- Pipeline execution
- Register updates
- Memory read/write operations
- Hazard resolution
- Branch redirection
- Loop execution
- Waveform analysis

---

## 🧰 Tools Used

- **Verilog HDL**
- **Xilinx Vivado Simulator**
- **GTKWave** (optional)
- **Icarus Verilog** (optional)

---

## 🎯 Learning Outcomes

This project provided practical experience in:

- RTL Processor Design
- Pipeline Architecture
- RISC-V RV32I ISA
- Datapath & Control Unit Design
- Pipeline Register Design
- Hazard Detection & Forwarding
- Branch Control
- Memory Interface Design
- Functional Verification
- Testbench Development
- Waveform Analysis

---

## 📈 Future Improvements

- Hazard Detection Unit with automatic pipeline stalling
- Branch Prediction
- CSR Instruction Support
- RV32M Extension (Multiply/Divide)
- Instruction & Data Cache
- AXI Bus Interface
- FPGA Implementation
- SystemVerilog-based Verification Environment

---

## 👨‍💻 Author

**Srihari Naidu**

RTL Design | Digital Design | FPGA | RISC-V | Verilog HDL
