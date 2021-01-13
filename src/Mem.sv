module Mem(
  input logic clk,
  input logic reset_n,
  input logic signed [31:0] res,
  input logic signed [31:0] Rd_val,
  input logic enable_reg,
  input logic read_word,
  input logic enable_write,
  input logic [4:0] Rd,
  input logic [31:0] pc_val,
  input logic link,
  input logic signed [31:0] word_wb,
  input logic signed [31:0] word_wb_bef,
  input logic set,
  input logic condition,
  output logic  [31:0] d_address_s,
  output logic signed [31:0] Rd_val_s_r,
  output logic enable_write_s,
  output logic signed [4:0] Rd_s,
  output logic enable_reg_s,
  output logic read_word_s,
  output logic signed [31:0] res_s,
  output logic [31:0] pc_val_s,
  output logic link_s,
  output logic set_s,
  output logic condition_s
  );

  logic [4:0] Rd_bef;
  logic [4:0] Rd_bef_bef;
  logic enable_write_bef;
  logic enable_write_bef_bef;
  logic signed [31:0] Rd_val_s;

  always @(*)
  if((Rd_s == Rd_bef) && Rd_s != 0 && !enable_write_bef )
    Rd_val_s_r <= word_wb;
  else
    if((Rd_s == Rd_bef_bef) && Rd_s != 0 && !enable_write_bef_bef)
      Rd_val_s_r <= word_wb_bef;
    else
      Rd_val_s_r <= Rd_val_s;


  always @(posedge clk or negedge reset_n)
  begin
    if(!reset_n)
    begin
      d_address_s <= 0;
      Rd_val_s <= 0;
      enable_write_s <= 0;
      enable_reg_s <= 0;
      read_word_s <= 0;
      Rd_s <= 0;
      res_s <= 0;
      pc_val_s <= 0;
      link_s <= 0;
      set_s <= 0;
      condition_s <= 0;
      enable_write_bef <= 0;
      enable_write_bef_bef <= 0;
    end
    else
    begin
      d_address_s <= res;
      Rd_val_s <= Rd_val;
      enable_write_s <= enable_write;
      enable_reg_s <= enable_reg;
      read_word_s <= read_word;
      Rd_s <= Rd;
      res_s <= res;
      pc_val_s <= pc_val;
      link_s <= link;
      Rd_bef <= Rd_s;
      Rd_bef_bef <= Rd_bef;
      set_s <= set;
      condition_s <= condition;
      enable_write_bef <= enable_write_s;
      enable_write_bef_bef <= enable_write_bef;
    end
  end

endmodule
