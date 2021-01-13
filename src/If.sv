module If(
    input logic clk,
	  input logic 	      reset_n,

		input logic signed [15:0] imm,
		input logic signed [25:0] value,
    input logic jump_inc,
    input logic condition,
    input logic [31:0] pc_val_back,
    input logic load_new_PC,
    input logic signed [31:0]	Rs1_val_back,
		output logic [31:0] pc_val
		);

		//logic [31:0] imm_extended;
		//logic [31:0] val_extended;

	 /*always@(*)
	 begin
	 	imm_extended <= imm;
		val_extended <= value;
  end*/

  PC pc(.clk(clk), .reset_n(reset_n), .jump_inc(jump_inc), .imm(imm), .value(value), .condition(condition), .pc_val_back(pc_val_back), .load_new_PC(load_new_PC), .Rs1_val_back(Rs1_val_back), .pc_val(pc_val));



endmodule // PC
