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
 

//////////////// IF STAGE ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always@(posedge clk1)

if(reset)
    begin
    L12_IR<=32'h00000013; // NOP
    //taken_branch<=0;
    pc<=32'h0;
    L12_pc<=32'h0;
    end
    
else

if(L34_IR[6:0]==7'b1100011 && L34_cond==1)    // branch instruction
    begin
    L12_IR<=inst_mem[L34_alu_out];
    //taken_branch<=1;
    pc<=L34_alu_out+1;
    L12_pc<=L34_alu_out;
    end
else if(L34_IR[6:0]==7'b1101111)              // JAL instruction 
     begin
     L12_IR<=inst_mem[L34_alu_out];
     pc<=L34_alu_out+1;
     L12_pc<=L34_alu_out;
     end
else if(L34_IR[6:0]==7'b1100111)              // JALR instruction
     begin
     L12_IR<=inst_mem[(L34_alu_out)&32'hfffffffe];
     pc<=((L34_alu_out)&32'hfffffffe)+1;
     L12_pc<=(L34_alu_out)&32'hfffffffe;
     end   
else                                          // for rest of all instructions
     begin
     L12_IR<=inst_mem[pc];
     pc<=pc+1;
     L12_pc<=pc;
     //taken_branch<=0;
     end
         
//////////////////////// ID stage //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


always@(posedge clk2)

if (reset || (L34_IR[6:0]==7'b1100011 && L34_cond==1))  // for removing control hazards
begin
L23_A<= 32'h0;
L23_B<= 32'h0;
L23_imm<= 32'h0;
L23_IR<= 32'h00000013; // NOP
L23_pc<= 32'h0;
end
         
else
begin                 
L23_IR<= L12_IR;
L23_pc<=L12_pc;

case(L12_IR[6:0])
7'b0110011: begin                                         // R type
              L23_A<=reg_file[L12_IR[19:15]];
              L23_B<=reg_file[L12_IR[24:20]];
              L23_imm<=32'b0;
            end
7'b0010011,7'b0000011,7'b1100111: begin                   // I tpe(load instruction and JALR instructions)
                                    L23_A<=reg_file[L12_IR[19:15]];
                                    L23_B<=32'b0;
                                    L23_imm<={{20{L12_IR[31]}},L12_IR[31:20]};
                                  end
7'b0100011: begin                                          // Store Type
             L23_A<=reg_file[L12_IR[19:15]];
             L23_B<=reg_file[L12_IR[24:20]];
             L23_imm<={{20{L12_IR[31]}},L12_IR[31:25],L12_IR[11:7]};  
            end          
7'b1100011: begin                                          // Branch type
              L23_A<=reg_file[L12_IR[19:15]];
              L23_B<=reg_file[L12_IR[24:20]]; 
              L23_imm<={{19{L12_IR[31]}},L12_IR[31],L12_IR[7],L12_IR[30:25],L12_IR[11:8],1'b0};
            end 
7'b0110111,7'b0010111: begin                               // Upper imm type
                         L23_imm<={L12_IR[31:12],12'b0};
                         L23_A<=32'b0;
                         L23_B<=32'b0;
                       end
7'b1101111: begin                                          // jump type
              L23_imm<={{11{L12_IR[31]}},L12_IR[31],L12_IR[19:12],L12_IR[20],L12_IR[30:21],1'b0}; 
              L23_A<=32'b0;
              L23_B<=32'b0;
            end                  
endcase


end


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

