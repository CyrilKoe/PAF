module Id(
		 input logic clk,
		 input logic [31:0] i_address,
		 input logic reset_n,
     input logic [31:0] i_data_read,
		 input logic [31:0] pc_val,
		 output logic [4:0] Rs1,
		 output logic [4:0] Rs2,
		 output logic [4:0] Rd,
		 output logic [15:0] imm,
		 output logic [5:0] opcode,
		 output logic [25:0] value,
		 output logic [1:0] type_inst,
		 output logic enable_write,
		 output logic read_word,
     output logic enable_reg,
		 output logic jump_inc,
		 output logic [31:0] pc_val_s,
		 output logic link,
		 output logic load_new_PC,
		 output logic set
     );

     Decodeur dec(.clk(clk), .instr(i_data_read), .reset_n(reset_n), .Rs1(Rs1), .Rs2(Rs2), .Rd(Rd), .imm(imm), .opcode(opcode), .value(value), .type_inst(type_inst), .enable_write(enable_write), .read_word(read_word), .enable_reg(enable_reg), .jump_inc(jump_inc), .link(link), .load_new_PC(load_new_PC), .set(set));

		 always @(posedge clk or negedge reset_n)
		 if(!reset_n)
		 	pc_val_s <= 0;
		else
			pc_val_s <= pc_val;



endmodule
