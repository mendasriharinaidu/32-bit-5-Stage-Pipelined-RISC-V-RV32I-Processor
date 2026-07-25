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

