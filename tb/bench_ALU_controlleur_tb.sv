module bench_ALU_controlleur();
  logic clk;
  logic [5:0] Rs1;
  logic [5:0] Rs2;
  logic [5:0] Rd;
  logic [31:0] Rd_val;
  logic [31:0] Rs1_val;
  logic [31:0] Rs2_val;
  logic [1:0] type_inst;
  logic [5:0] opcode;
  logic signed [15:0] imm;
  logic condition; //Si on detecte un saut conditionnel
  logic signed [31:0] res;
  logic reset_n;
	logic enable_write;
	logic enable_I;
	logic enable_reg;
	logic sel_inc;
	logic enable_PC;
	logic load_new_PC;
	logic link;
	logic read_word;

  ALU alu(.opcode(opcode), .Rs1_val(Rs1_val), .Rs2_val(Rs2_val), .imm(imm), .type_inst(type_inst), .condition(condition), .res(res));
  reg_bench bench(.clk(clk), .enable_reg(enable_reg), .reset_n(reset_n), .Rs1(Rs1), .Rs2(Rs2), .Rd(Rd), .Rd_val(Rd_val), .Rs1_val(Rs1_val), .Rs2_val(Rs2_val));
  controlleur cont(.clk(clk), .reset_n(reset_n), .opcode(opcode), .enable_write(enable_write), .enable_I(enable_I), .enable_reg(enable_reg), .sel_inc(sel_inc), .enable_PC(enable_PC), .load_new_PC(load_new_PC), .link(link),  .read_word(read_word));

  always@(*)
    Rd_val <= res;

  always
    #5ns
      clk <= !clk;

  initial
  begin
    clk <= 0;
    Rs1 <= 0;
    Rs2 <= 0;
    Rd <= 0;
    Rd_val <= 0;
    reset_n <= 1;
    opcode <= 0;
    #1ns
    reset_n <= 0;
    #3ns
    reset_n <= 1;
    type_inst <= 2'b11;
    imm <= 5;
    opcode <= 6'h08;
    Rs1 <= 1;
    Rd <= 3;
  end

endmodule
