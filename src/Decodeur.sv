module Decodeur(
		 input logic clk,
		 input logic [31:0] instr,
		 input logic reset_n,
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
		 output logic link,
		 output logic load_new_PC,
		 output logic set
	);

	localparam BEQZ = 6'h04;
	localparam BNEZ = 6'h05;
	localparam J = 6'h02;
	localparam JAL = 6'h03;
	localparam JALR = 6'h13;
	localparam JR = 6'h12;
	localparam SW = 6'h2b;
	localparam LW = 6'h23;
	localparam SEQ = 6'h28;
	localparam SEQI = 6'h18;
	localparam SLE = 6'h2c;
	localparam SLEI = 6'h1c;
	localparam SLT = 6'h2a;
	localparam SLTI = 6'h1a;
	localparam SNE = 6'h29;
	localparam SNEI = 6'h19;


   always@(*)
	 begin
	 	type_inst <= 2'b00;
     if(instr[31:26]==0)
       type_inst <= 2'b01; // R
     else
       if(instr[31:26]==6'h02 || instr[31:26]==6'h03)
	 	 			type_inst <= 2'b10; //J
       else
	 	 			type_inst <= 2'b11; //I
	 end

	 always @(*)
	 begin
	 	read_word <= (opcode == LW);
		enable_reg <= (opcode != SW);
		enable_write <= (opcode == SW);
		jump_inc <= ((opcode == BEQZ) && (type_inst == 2'b11)) || (opcode == BNEZ) || (opcode == J) || (opcode == JAL);
		link <= (opcode == JAL) || (opcode == JALR);
		load_new_PC <= (opcode == JALR) || (opcode == JR);
		set <= (opcode == SEQ)||(opcode == SEQI)||(opcode == SLE)||(opcode == SLEI)||(opcode == SLT)||(opcode == SLTI)||(opcode == SNE)||(opcode == SNEI);
	 end

   always@(*)
   begin
   Rs1 <= 0;
   Rs2 <= 0;
   Rd <= 0;
   imm <= 0;
   opcode <= 0;
   value <= 0;

   case(type_inst)
			2'b01:begin
		   Rs1 <= instr[25:21];
		   Rs2 <= instr[20:16];
		   Rd <= instr[15:11];
		   opcode <= instr[5:0];
			end
      2'b10:begin
		   opcode <= instr[31:26];
		   value <= instr[25:0];
			end
			2'b11:begin
			   opcode <= instr[31:26];
			   Rs1 <= instr[25:21];
			   Rd <= instr[20:16];
			   imm <= instr[15:0];
			end

   endcase // case ({type_inst})
   end // always@ begin

endmodule
