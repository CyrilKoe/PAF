module no_ram_version_td();
  logic clk;
  logic [31:0] pc_val;
  logic [31:0] instr;
  logic [4:0] Rs1;
  logic [4:0] Rs2;
  logic [4:0] Rd;
  logic [31:0] Rd_val;
  logic [31:0] Rs1_val;
  logic [31:0] Rs2_val;
  logic [1:0] type_inst;
  logic [5:0] opcode;
  logic signed [15:0] imm;
  logic signed [25:0] value;
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
  logic signed [31:0]  d_data_read;

  ALU alu(.opcode(opcode), .Rs1_val(Rs1_val), .Rs2_val(Rs2_val), .imm(imm), .type_inst(type_inst), .condition(condition), .res(res));
  reg_bench bench(.clk(clk), .enable_reg(enable_reg), .reset_n(reset_n), .Rs1(Rs1), .Rs2(Rs2), .Rd(Rd), .res(res), .d_data_read(d_data_read), .read_word(read_word), .Rs1_val(Rs1_val), .Rs2_val(Rs2_val));
  controlleur cont(.clk(clk), .reset_n(reset_n), .opcode(opcode), .condition(condition), .enable_write(enable_write), .enable_I(enable_I), .enable_reg(enable_reg), .sel_inc(sel_inc), .enable_PC(enable_PC), .load_new_PC(load_new_PC), .link(link),  .read_word(read_word));
  PC pc(.clk(clk), .reset_n(reset_n), .sel_inc(sel_inc), .enable_PC(enable_PC), .load_new_PC(load_new_PC), .Rs1_val(Rs1_val), .imm(imm), .value(value), .pc_val(pc_val));
  Decodeur dec(.clk(clk), .instr(instr), .enable_I(enable_I), .reset_n(reset_n), .Rs1(Rs1), .Rs2(Rs2), .Rd(Rd), .imm(imm), .opcode(opcode), .value(value), .type_inst(type_inst));

  always@(*)
    Rd_val <= res;

  always
    #5ns
      clk <= !clk;

  always@(posedge clk)
  case(pc_val)
    0: instr <= 32'b001000_00000_00010_0000000000000101; //
    4: instr <= 32'b001000_00000_00011_0000000000000110; //
    8: instr <= 32'b000010_00000000000000000000000111; //
    15: instr <= 32'b000000_00010_00011_00010_100000; //
    19: instr <= 32'b000010_11111111111111111111111000; //


  endcase

  initial
  begin
    instr <= 32'b001000_00000_00010_0000000000000101;
    clk <= 0;
    reset_n <= 1;

    #1ns
    reset_n <= 0;

    #1ns
    reset_n <= 1;
  end

endmodule
