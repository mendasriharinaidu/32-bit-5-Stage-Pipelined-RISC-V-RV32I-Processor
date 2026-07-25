module testbench( );
reg clk1,clk2;
reg reset;

riscv_top uut(clk1,clk2,reset);

integer k;
integer i;

initial
begin
reset=1;
#50 reset=0;
end

initial
begin
clk1=0;clk2=0;uut.pc=0;
repeat(19)
begin
#5 clk1=1; #5 clk1=0;
#5 clk2=1; #5 clk2=0;
end
end

initial 
for(k=0;k<32;k=k+1)
begin
uut.reg_file[k]=32'h0;
end

initial
for(i=0;i<1024;i=i+1)
begin
uut.data_mem[i]=32'h0;
end

integer j;

initial
for(j=0;j<1024;j=j+1)
begin
uut.inst_mem[j]=32'h0;
end

initial
begin
#2
// --- Pre-load Specific Initial Values into the Register File ---

uut.reg_file[1]  = 32'd5;    // x1 preset = 5
uut.reg_file[2]  = 32'd20;   // x2 preset = 20
uut.reg_file[5]  = 32'd100;  // x5 preset = 100 (Will be overwritten by LUI)
uut.reg_file[8]  = 32'd50;   // x8 preset = 50
uut.reg_file[9]  = 32'd25;   // x9 preset = 25
uut.reg_file[12] = 32'd99;   // x12 preset = 99 (Target value for loop exit condition)

// --- Pre-load Instruction Memory (Word-Addressable Hex) ---
uut.inst_mem[0]  = 32'h123452b7; // Index 0:  lui   x5, 0x12345    (x5 = 0x12345000)
uut.inst_mem[1]  = 32'h00002317; // Index 1:  auipc x6, 0x2        (x6 = PC + 0x2000)
uut.inst_mem[2]  = 32'h00209113; // Index 2:  slli  x2, x1, 2      (x2 = 5 << 2 = 20)
uut.inst_mem[3]  = 32'h009401b3; // Index 3:  add   x3, x8, x9     (x3 = 50 + 25 = 75)
uut.inst_mem[4]  = 32'h0021a023; // Index 4:  sw    x2, 0(x3)      (data_mem[75] = 20)
uut.inst_mem[5]  = 32'h001180a3; // Index 5:  sb    x1, 1(x3)      (data_mem[76] = 5)
uut.inst_mem[6]  = 32'h00000013; // Index 6:  nop
uut.inst_mem[7]  = 32'h0001a503; // Index 7:  lw    x10, 0(x3)     (x10 = data_mem[75] = 20)
uut.inst_mem[8]  = 32'h00000013; // Index 8:  nop                  (Load delay stall)
uut.inst_mem[9]  = 32'h002505b3; // Index 9:  add   x11, x10, x2   (x11 = 20 + 20 = 40)
uut.inst_mem[10] = 32'hfec59ee3; // Index 10: bne   x11, x12, -4   (If 40 != 99, jump back 3 instructions to Index 7!)
uut.inst_mem[11] = 32'h06300593; // Index 11: addi  x11, x0, 99    (TRAP: Should be FLUSHED out on loop jumps!)
end

endmodule
