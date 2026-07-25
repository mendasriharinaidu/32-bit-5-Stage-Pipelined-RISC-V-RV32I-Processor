//////////////////////////// WB /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


always@(posedge clk1)
if(!reset)
begin
if(L45_IR[6:0]==7'b0110011||L45_IR[6:0]==7'b0010011||L45_IR[6:0]==7'b0010111)  // R_type,I_type,AUIPC instruction
reg_file[L45_IR[11:7]]<=L45_alu_out;   
else if(L45_IR[6:0]==7'b0110111)       // LUI instruction
reg_file[L45_IR[11:7]]<=L45_imm;
else if(L45_IR[6:0]==7'b1100111||L45_IR[6:0]==7'b1101111)    // JAL,JALR instructions
reg_file[L45_IR[11:7]]<=L45_pc+1;
else if(L45_IR[6:0]==7'b0000011)       // Load instruction
case(L45_IR[14:12])
3'b000: reg_file[L45_IR[11:7]]<={{24{L45_LMD[7]}},L45_LMD[7:0]};         // LB          
3'b001: reg_file[L45_IR[11:7]]<={{16{L45_LMD[15]}},L45_LMD[15:0]};       // LH     
3'b010: reg_file[L45_IR[11:7]]<=L45_LMD;                                 // LW                   
3'b100: reg_file[L45_IR[11:7]]<={24'b0,L45_LMD[7:0]};                    // LBU       
3'b101: reg_file[L45_IR[11:7]]<={16'b0,L45_LMD[15:0]};                   // LHU
endcase
end


endmodule
