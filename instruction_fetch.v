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
         
