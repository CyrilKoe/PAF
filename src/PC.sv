module PC(input logic clk,
	  input logic 	      reset_n,
		input logic 				jump_inc,
		input logic signed [15:0] imm,
		input logic signed [25:0] value,
		input logic condition,
		input logic [31:0] pc_val_back,
		input logic load_new_PC,
		input logic signed [31:0]	Rs1_val_back,
		output logic [31:0] pc_val
		);

		logic [31:0] imm_extended;
		logic [31:0] val_extended;
		logic [31:0] my_pc_val;

	 always@(*)
	 begin
	 	imm_extended <= imm;
		val_extended <= value;
	 end

	always @(*)
	begin
		if(jump_inc && condition)
			pc_val <= pc_val_back + (imm_extended | val_extended);
		else
			if(load_new_PC)
				pc_val <= Rs1_val_back;
			else
				pc_val <= my_pc_val;
	end

	always @(posedge clk or negedge reset_n)
	begin
			if (!reset_n)
				my_pc_val <= 0;
			else
			begin
				if(jump_inc && condition)
					my_pc_val <= pc_val_back + (imm_extended | val_extended) + 4;
				else
					if(load_new_PC)
						my_pc_val <=	Rs1_val_back + 4;
					else
						my_pc_val <= my_pc_val + 4;
			end
		end

endmodule // PC
