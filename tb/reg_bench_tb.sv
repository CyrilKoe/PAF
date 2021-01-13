module reg_bench_tb();

  logic clk;
  logic enable;
  logic [5:0] Rs1;
  logic [5:0] Rs2;
  logic [5:0] Rd;
  logic [31:0] Rd_val;
  logic [31:0] Rs1_val;
  logic [31:0] Rs2_val;

  reg_bench bench(.clk(clk), .enable(enable), .Rs1(Rs1), .Rs2(Rs2), .reg_out(reg_out), .val(val), .Rs1_val(Rs1_val), .Rs2_val(Rs2_val));

  always
    #5ns
      clk <= !clk;

  initial
  begin
    clk <= 0;
    enable <= 0;
    Rs1 <= 6;
    Rs2 <= 2;
    reg_out <= 0;
    Rd_val <= 0;

    #12ns
      Rd_val <= 11;

    #1ns
      reg_out <= 6;

    #8ns
      enable <= 1;

    #10ns
      enable <= 0;

    #10ns
      Rd_val <= 255;
      reg_out <= 7;

    #10ns
      enable <= 1;

    #10ns
      enable <= 0;

    #10ns
      Rs1 <= 7;
      Rs2 <= 0;

  end



endmodule // reg_bench_tb
