/////////////////////// EX stage /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


always @(posedge clk1) 

if (reset)
    begin
    L34_alu_out <= 32'h0;
    L34_B<= 32'h0;
    L34_IR<= 32'h00000013; // NOP
    L34_pc<= 32'h0;
    L34_imm<= 32'h0;
    L34_cond<= 1'b0;
    end 

else
     begin
     L34_IR<= L23_IR;
     L34_pc<= L23_pc;
     L34_B<= L23_B_new;   
     L34_imm<= L23_imm; 
     L34_cond<= 1'b0; 
            
if(L23_IR[6:0]==7'b0110011)  // R type
begin
case(L23_IR[14:12])
3'b000: if(L23_IR[31:25]==7'b0000000)                 // ADD
           L34_alu_out <=L23_A_new+L23_B_new; 
        else if(L23_IR[31:25]==7'b0100000)            // SUB
           L34_alu_out <=L23_A_new-L23_B_new;
           
3'b001: if(L23_IR[31:25]==7'b0000000)                 // SLL
           L34_alu_out <=L23_A_new<<L23_B_new[4:0];
           
3'b010: if(L23_IR[31:25]==7'b0000000)                 // SLT
           L34_alu_out <=($signed(L23_A_new)<$signed(L23_B_new))?32'b1:32'b0;
           
3'b011: if(L23_IR[31:25]==7'b0000000)                 // SLTU
           L34_alu_out <=(L23_A_new<L23_B_new)?32'b1:32'b0;
           
3'b100: if(L23_IR[31:25]==7'b0000000)                 // XOR
           L34_alu_out <=L23_A_new^L23_B_new;
           
3'b101: if(L23_IR[31:25]==7'b0000000)                 // SRL
           L34_alu_out <=L23_A_new>>L23_B_new[4:0]; 
        else if(L23_IR[31:25]==7'b0100000)            // SRA
           L34_alu_out <=$signed(L23_A_new)>>>L23_B_new[4:0]; 
           
3'b110: if(L23_IR[31:25]==7'b0000000)                 // OR
           L34_alu_out <=L23_A_new|L23_B;                   
           
3'b111: if(L23_IR[31:25]==7'b0000000)                 // AND
           L34_alu_out <=L23_A_new&L23_B_new;    
           
endcase
end

else if(L23_IR[6:0]==7'b0010011)  // I type
begin
case(L23_IR[14:12])
3'b000: L34_alu_out <=L23_A_new+L23_imm;                                         // ADDI
3'b010: L34_alu_out <=($signed(L23_A_new)<$signed(L23_imm))?32'b1:32'b0;         // SLTI
3'b011: L34_alu_out <=(L23_A_new<L23_imm)?32'b1:32'b0;                           // SLTIU
3'b100: L34_alu_out <=L23_A_new^L23_imm;                                         // XORI
3'b110: L34_alu_out <=L23_A_new|L23_imm;                                         // ORI
3'b111: L34_alu_out <=L23_A_new&L23_imm;                                         // ANDI
3'b001: if(L23_IR[31:25]==7'b0000000)                                        // SLLI
            L34_alu_out <=L23_A_new<<L23_imm[4:0];
3'b101: if(L23_IR[31:25]==7'b0000000)                                        // SRLI
            L34_alu_out <=L23_A_new>>L23_imm[4:0];
        else if(L23_IR[31:25]==7'b0100000)                                   // SRAI
            L34_alu_out <=$signed(L23_A_new)>>>L23_imm[4:0];
endcase
end

else if(L23_IR[6:0]==7'b0000011)  // Load instructions
begin
if(L23_IR[14:12]==3'b000||L23_IR[14:12]==3'b001||L23_IR[14:12]==3'b010||L23_IR[14:12]==3'b100||L23_IR[14:12]==3'b101)
L34_alu_out <=L23_A_new+L23_imm;
end

else if(L23_IR[6:0]==7'b1100111)  // JALR instruction
begin
L34_alu_out <=L23_A_new+L23_imm;
end

else if(L23_IR[6:0]==7'b0100011)  // Store instruction
begin
if(L23_IR[14:12]==3'b000||L23_IR[14:12]==3'b001||L23_IR[14:12]==3'b010)
L34_alu_out <=L23_A_new+L23_imm;
end

else if(L23_IR[6:0]==7'b1100011)  // Branch instructions
begin
L34_alu_out<=L23_imm+L23_pc;
case(L23_IR[14:12])
3'b000: L34_cond<=(L23_A_new==L23_B_new);         
3'b001: L34_cond<=(L23_A_new!=L23_B_new);
3'b100: L34_cond<=($signed(L23_A_new)<$signed(L23_B_new));        
3'b101: L34_cond<=($signed(L23_A_new)>=$signed(L23_B_new));        
3'b110: L34_cond<=(L23_A_new<L23_B_new);        
3'b111: L34_cond<=(L23_A_new>=L23_B_new);
default: L34_cond<=0;
endcase
end

else if(L23_IR[6:0]==7'b0110111)  // LUI instruction
begin
L34_alu_out<=L23_imm;
end

else if(L23_IR[6:0]==7'b0010111)  // AUIPC instruction
begin
L34_alu_out<=L23_imm+L23_pc;
end

else if(L23_IR[6:0]==7'b1101111)  // JAL instruction
begin
L34_alu_out<=L23_imm+L23_pc;
end

end
