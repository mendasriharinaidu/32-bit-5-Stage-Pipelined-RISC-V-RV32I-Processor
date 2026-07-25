////////////////////// MEM /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


always@(posedge clk2)

 if (reset) 
      begin
      L45_LMD<= 32'h0;
      L45_alu_out<= 32'h0;
      L45_imm<= 32'h0;
      L45_pc<= 32'h0;
      L45_IR<= 32'h00000013; // NOP
      end 
   
else
     begin
     L45_IR<= L34_IR;
     L45_alu_out<= L34_alu_out; 
     L45_LMD<= 32'h0;
     L45_imm<= L34_imm;
     L45_pc<= L34_pc;

if(L34_IR[6:0]==7'b0100011)  // Store instruction
case(L34_IR[14:12])                                        
3'b000: data_mem[L34_alu_out]<={24'b0,L34_B[7:0]};              // SB
3'b001: data_mem[L34_alu_out]<={16'b0,L34_B[15:0]};             // SH
3'b010: data_mem[L34_alu_out]<=L34_B;                           // SW
endcase
else if(L34_IR[6:0]==7'b0000011)  // load instruction
L45_LMD<=data_mem[L34_alu_out];

//else if(L34_IR[6:0]==7'b0110011||L34_IR[6:0]==7'b0010011||L34_IR[6:0]==7'b0010111) // R_type,I_type,AUIPC instruction
//L45_alu_out<=L34_alu_out;
//else if(L34_IR[6:0]==7'b0110111)  // LUI instruction
//L45_imm<=L34_imm;
//else if(L34_IR[6:0]==7'b1100111||L34_IR[6:0]==7'b1101111)        // JAL,JALR instructions
//L45_pc<=L34_pc;

end
