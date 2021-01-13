module controlleur_tb();

  logic clk;
  logic reset_n;
  logic [5:0] opcode;
	logic enable_write;
	logic enable_I;
	logic enable_reg;
	logic sel_inc;
	logic enable_PC;
	logic load_new_PC;
	logic link;
	logic read_word;

  controlleur cont(.clk(clk), .reset_n(reset_n), .opcode(opcode), .enable_write(enable_write), .enable_I(enable_I), .enable_reg(enable_reg), .sel_inc(sel_inc), .enable_PC(enable_PC), .load_new_PC(load_new_PC), .link(link),  .read_word(read_word));

  always
  begin
    #5ns
      clk <= !clk;
  end

  initial
  begin
    reset_n <= 1;
    clk <= 0;
    opcode <= 0;
    #1ns
    reset_n <= 0;
    #3ns
    reset_n <= 1;
    #200ns
    reset_n <= 0;
  end



endmodule // reg_bench_tb
