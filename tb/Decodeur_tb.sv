module Decodeur_tb();
   logic clk;
   logic [31:0] instr;
   logic enable_I;
   logic reset_n;
   logic [4:0] 	reg_in_1;
   logic [4:0] 	reg_in_2;
   logic [4:0] 	reg_out;
   logic [15:0] imm;
   logic [6:0] 	opcode;
   logic [25:0] value;
   logic [1:0] type_inst;

   Decodeur decodeur0(.clk(clk),.instr(instr),.enable_I(enable_I),.reset_n(reset_n),.reg_in_1(reg_in_1),.reg_in_2(reg_in_2),.reg_out(reg_out),.imm(imm),.opcode(opcode),.value(value),.type_inst(type_inst));
   always
    begin
      #5ns
        clk <= !clk;
    end

   always
   begin
      #50ns
        enable_I <=1;
      #10ns
        enable_I <=0;
  end

   initial
     begin
        clk <=0;
      	instr <=0;
        enable_I <=0;
        reset_n <=1;
      	#45ns
      	  instr <= 32'b00_1101_00000_00001_0000_0000_0000_0001;
      	#50ns
      	  instr <= 32'b00_0000_00000_00001_00010_00000_011001;
      	#50ns
      	  instr <=32'b000010_00000000000000000000100000;

     end // initial begin
endmodule // Decodeur_tb
