// Quartus Prime SystemVerilog Template
//
// True Dual-Port RAM with different read/write addresses and single read/write clock
// and with a control for writing single bytes into the memory word; byte enable

// Read during write produces old data on ports A and B and old data on mixed ports
// For device families that do not support this mode (e.g. Stratix V) the ram is not inferred

module byte_enabled_true_dual_port_ram
	#(parameter int ADDRESS_WIDTH = 13)
(
	input [ADDRESS_WIDTH-1:0] addr1,
	input [ADDRESS_WIDTH-1:0] addr2,
	input [31:0] data_in1,
	input we1, clk,
	output [31:0] data_out1,
	output [31:0] data_out2 );


	localparam RAM_DEPTH = 1 << ADDRESS_WIDTH;

	// model the RAM with two dimensional packed array
	logic [31:0] ram[0:RAM_DEPTH-1];

	reg [31:0] data_reg1;
	reg [31:0] data_reg2;

	// port A
	always@(posedge clk)
	begin
		if(we1)
			ram[addr1] <= data_in1;
	data_reg1 <= ram[addr1];
	end

	assign data_out1 = data_reg1;

	// port B
	always@(posedge clk)
	begin
	data_reg2 <= ram[addr2];
	end

	assign data_out2 = data_reg2;

endmodule
