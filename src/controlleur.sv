module controlleur(
	input logic clk,
	input logic reset_n,
	input logic [5:0] opcode,
	input logic condition,
	output logic enable_write,
	output logic enable_I,
	output logic enable_reg,
	output logic sel_inc,
	output logic enable_PC,
	output logic load_new_PC,
	output logic link,
	output logic read_word
	);

	localparam BEQZ = 6'h04;
	localparam BENZ = 6'h05;
	localparam J = 6'h02;
	localparam JAL = 6'h03;
	localparam JALR = 6'h13;
	localparam JR = 6'h12;
	localparam SW = 6'h2b;
	localparam LW = 6'h23;

	enum logic[2:0] {IF, ID, EX, MEM, WB} state, next_state;

	always@(*)
	case(state)
		IF: next_state <= ID;
		ID: next_state <= EX;
		EX: next_state <= MEM;
		MEM: next_state <= WB;
		WB: next_state <= IF;
	endcase

	always@(posedge clk or negedge reset_n)
	begin
		if(!reset_n)
			state <= IF;
		else
			state <= next_state;
	end

	always@(*) //SIGNAUX INTERNES
	begin
		enable_PC <= (state == IF) || ((opcode == J || opcode == JAL|| opcode == JALR || opcode == JR) && (state == EX))  || ((opcode == BEQZ || opcode == BENZ) && (state == EX) && (condition == 1));
		enable_I <= (state == IF);
		enable_reg <= (state == WB && opcode != SW) ||((opcode == JAL || opcode == JALR) && state == EX);
		sel_inc <= !(state == EX); //A 1 on incrémente de 4
		load_new_PC <= ((opcode == JR || opcode == JALR) && state == EX);
		link <= (opcode == JAL || opcode == JALR) && state == EX;
		read_word <= (opcode == LW) && (state == WB);
		enable_write <= (opcode == SW) && (state == MEM);
	end


endmodule
