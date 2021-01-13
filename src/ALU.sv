module ALU(
	//Signaux utiles
	input logic[5:0] opcode,
	input logic signed [31:0] Rs1_val,
	input logic signed [31:0] Rs2_val,
	input logic signed [15:0] imm,
	input logic [1:0] type_inst,

	output logic condition,
	output logic signed [31:0] res
	);

	logic signed [31:0] immExtended;

	always@(*)
	begin
		immExtended <= imm;
	end

	//Propagation

	always@(*)
	begin
		res <= 0;
		condition <= 1;
		case(type_inst)
			2'b01: //R
				case(opcode)
					6'h20: res <= Rs1_val + Rs2_val;
					6'h24: res <= Rs1_val & Rs2_val;
					6'h25: res <= Rs1_val | Rs2_val;
					6'h28:
					begin
						condition <= (Rs1_val == Rs2_val);
						res <= (Rs1_val == Rs2_val);
					end
					6'h2c:
					begin
						condition <= (Rs1_val <= Rs2_val);
						res <= (Rs1_val <= Rs2_val);
					end
					6'h04: res <= Rs1_val << (Rs2_val % 8);
					6'h2a:
					begin
						condition <= (Rs1_val < Rs2_val);
						res <= (Rs1_val < Rs2_val);
					end
					6'h29:
					begin
						condition <= (Rs1_val != Rs2_val);
						res <= (Rs1_val != Rs2_val);
					end
					6'h07: res <= Rs1_val >>> (Rs2_val % 8);
					6'h06: res <= Rs1_val >> (Rs2_val % 8);
					6'h22: res <= Rs1_val - Rs2_val;
					6'h26: res <= Rs1_val ^ Rs2_val;
				endcase


			2'b11: //I
				case(opcode)
					6'h08: res <= Rs1_val + immExtended;
					6'h0c: res <= Rs1_val & immExtended;
					6'h04:
					begin
						condition <= (Rs1_val == 0);
						res <= (Rs1_val != 0);
					end
					6'h05:
					begin
						condition <= (Rs1_val != 0);
						res <= Rs1_val;
					end
					//6'h13:
					//6'h12:
					6'h0f: res <= immExtended << 16;
					6'h23: res <= Rs1_val + immExtended;
					6'h0d: res <= Rs1_val | immExtended;
					6'h18:
					begin
						condition <= (Rs1_val == immExtended);
						res <= (Rs1_val == immExtended);
					end
					6'h1c:
					begin
						condition <= (Rs1_val <= immExtended);
						res <= (Rs1_val <= immExtended);
					end
					6'h14: res <= Rs1_val << (immExtended % 8);
					6'h1a:
					begin
						condition <= (Rs1_val < immExtended);
						res <= (Rs1_val < immExtended);
					end
					6'h19:
					begin
						condition <= (Rs1_val != immExtended);
						res <= (Rs1_val != immExtended);
					end
					6'h17: res <= Rs1_val >>> (immExtended % 8);
					6'h16: res <= Rs1_val >> (immExtended % 8);
					6'h0a: res <= Rs1_val - immExtended;
					6'h2b: res <= Rs1_val + immExtended;
					6'h0e: res <= Rs1_val ^ immExtended;

				endcase
		endcase
	end



endmodule
