module riscv_top(
input clk1,
input clk2,
input reset); 


reg [31:0]pc;
reg [31:0]L12_IR,L12_pc;                               // IF / ID stage
  
reg [31:0]L23_A,L23_B,L23_imm,L23_pc,L23_IR;           // ID / EX stage
  
reg [31:0]L34_alu_out,L34_B,L34_IR,L34_pc,L34_imm;     // EX / MEM stage
reg L34_cond;

reg [31:0]L45_LMD,L45_alu_out,L45_IR,L45_pc,L45_imm;   // MEM / WB stage


reg [31:0]inst_mem[0:1023];                              // instruction memory of 32 bit wide having 1024 memory locations
reg [31:0]reg_file[0:31];                                // 32 - 32 bit register file
reg [31:0]data_mem[0:1023];                              // data memory of 32 bit wide having 1024 memory locations
 
