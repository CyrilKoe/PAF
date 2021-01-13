module Wb(
  input logic clk,
  input logic reset_n,
  input logic signed [31:0] res,
  input logic signed [31:0] d_data_read_s,
  input logic enable_reg,
  input logic signed [4:0] Rd,
  input logic read_word,
  input logic [31:0] pc_val,
  input logic link,
  input logic set,
  input logic condition,

  output logic signed [4:0] Rd_s,
  output logic signed [31:0] word,
  output logic enable_reg_s,
  output logic [31:0] pc_val_s,
  output logic link_s,
  output logic signed [31:0] word_bef,
  output logic set_s,
  output logic condition_s
  );

  logic read_word_s;
  logic signed [31:0] res_s;

  always @(*)
  if(read_word_s)
    word <= d_data_read_s;
  else
    word <= res_s;

  always @(posedge clk or negedge reset_n)
  begin
    if(!reset_n)
    begin
      enable_reg_s <= 0;
      read_word_s <= 0;
      res_s <= 0;
      Rd_s <= 0;
      pc_val_s <= 0;
      link_s <= 0;
      word_bef <= 0;
      set_s <= 0;
      condition_s <= 0;
    end
    else
    begin
      enable_reg_s <= enable_reg;
      read_word_s <= read_word;
      res_s <= res;
      Rd_s <= Rd;
      pc_val_s <= pc_val;
      link_s <= link;
      word_bef <= word;
      set_s <= set;
      condition_s <= condition;
    end
  end

endmodule
