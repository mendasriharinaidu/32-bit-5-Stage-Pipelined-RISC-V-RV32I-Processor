/////////////////////// Forwarding unit /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

reg [31:0]L23_A_new,L23_B_new;

always @(*) 

begin
// for getting new L23_A values
if(L23_IR[19:15]==L34_IR[11:7])  // if current inst rs1 is equals to the prev inst rd
begin
case(L34_IR[6:0])
7'b0110011,7'b0010011,7'b0110111,7'b0010111: L23_A_new= L34_alu_out;     // if prev inst is a R-type,I-type,U-type
7'b1100111,7'b1101111: L23_A_new= L34_pc+1;                              // if prev inst is JAL, JALR
7'b0000011: L23_A_new= L45_LMD;                                          // if prev inst is LOAD  
endcase
end
else if(L23_IR[19:15]==L45_IR[11:7])   // if current inst rs1 is equals to the previous to the prev inst rd
begin
case(L45_IR[6:0])
7'b0110011,7'b0010011,7'b0110111,7'b0010111: L23_A_new= L45_alu_out;      // if that inst is a R-type,I-type,U-type
7'b1100111,7'b1101111: L23_A_new= L45_pc+1;                               // if that inst is JAL, JALR
endcase
end
else
begin
L23_A_new= L23_A;
end

// for getting new L23_B values
if(L23_IR[24:20]==L34_IR[11:7])  // if current inst rs2 is equals to the prev inst rd
begin
case(L34_IR[6:0])
7'b0110011,7'b0010011,7'b0110111,7'b0010111: L23_B_new= L34_alu_out;     // if prev inst is a R-type,I-type,U-type
7'b1100111,7'b1101111: L23_B_new= L34_pc+1;                              // if prev inst is JAL, JALR
7'b0000011: L23_B_new= L45_LMD;                                          // if prev inst is LOAD  
endcase
end
else if(L23_IR[24:20]==L45_IR[11:7])   // if current inst rs1 is equals to the previous to the prev inst rd
begin
case(L45_IR[6:0])
7'b0110011,7'b0010011,7'b0110111,7'b0010111: L23_B_new= L45_alu_out;      // if that inst is a R-type,I-type,U-type
7'b1100111,7'b1101111: L23_B_new= L45_pc+1;                               // if that inst is JAL, JALR
endcase
end
else
begin
L23_B_new= L23_B;
end

end
