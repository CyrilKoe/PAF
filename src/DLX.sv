module DLX
  (
   input logic 	       clk,
   input logic 	       reset_n,

   // RAM contenant les données
   output logic [31:0] d_address, //
   input logic [31:0]  d_data_read, //
   output logic [31:0] d_data_write,  //
   output logic        d_write_enable, //
   input logic 	       d_data_valid,

   // ROM contenant les instructions
   output logic [31:0] i_address, //
   input logic [31:0]  i_data_read, //
   input logic 	       i_data_valid
   );

   logic [31:0]  d_data_read_full;
   logic [31:0]  i_data_read_full;

   //SIGNAUX QUI SORTENT
   logic [31:0] pc_val_if;

   logic [4:0] Rs1_id;
   logic [4:0] Rs2_id;
   logic [4:0] Rd_id;
   logic [15:0] imm_id;
   logic [5:0] opcode_id;
   logic [25:0] value_id;
   logic enable_write_id;
   logic read_word_id;
   logic enable_reg_id;
   logic jump_inc_id;
   logic [1:0] type_inst_id;
   logic [31:0] pc_val_id;
   logic link_id;
   logic load_new_PC_id;
   logic set_id;

   logic signed [31:0] res_ex;
   logic condition_ex;
   logic signed [31:0] Rd_val_ex;
   logic [4:0] Rd_ex;
   logic enable_write_ex;
   logic read_word_ex;
   logic enable_reg_ex;
   logic jump_inc_ex;
   logic [15:0] imm_ex;
   logic [25:0] value_ex;
   logic [31:0] pc_val_ex;
   logic link_ex;
   logic load_new_PC_ex;
   logic [31:0] Rs1_val_ex;
   logic set_ex;

   logic  [31:0] d_address_mem;
   logic signed [31:0] Rd_val_mem;
   logic enable_write_mem;
   logic signed [31:0] res_mem;
   logic [4:0] Rd_mem;
   logic read_word_mem;
   logic enable_reg_mem;
   logic [31:0] pc_val_mem;
   logic link_mem;
   logic set_mem;
   logic condition_mem;

   logic signed [31:0] word_wb;
   logic signed [31:0] word_wb_bef;
   logic signed [4:0] Rd_wb;
   logic enable_reg_wb;
   logic signed [31:0] res_wb;
   logic [31:0] pc_val_wb;
   logic link_wb;
   logic set_wb;
   logic condition_wb;




   If IF(.clk(clk), .reset_n(reset_n), .imm(imm_ex), .value(value_ex), .jump_inc(jump_inc_ex), .condition(condition_ex), .pc_val_back(pc_val_ex), .load_new_PC(load_new_PC_ex), .Rs1_val_back(Rs1_val_ex),.pc_val(pc_val_if));
   Id ID(.clk(clk), .i_address(pc_val_if), .reset_n(reset_n), .i_data_read(i_data_read_full), .pc_val(pc_val_if), .Rs1(Rs1_id), .Rs2(Rs2_id), .Rd(Rd_id), .imm(imm_id), .opcode(opcode_id), .value(value_id),.type_inst(type_inst_id), .enable_write(enable_write_id), .read_word(read_word_id), .enable_reg(enable_reg_id), .jump_inc(jump_inc_id), .pc_val_s(pc_val_id), .link(link_id), .load_new_PC(load_new_PC_id), .set(set_id));
   Ex EX(.clk(clk), .reset_n(reset_n), .Rs1(Rs1_id), .Rs2(Rs2_id), .Rd(Rd_id), .Rd_back(Rd_wb), .read_word(read_word_id), .res_mem(res_mem), .res_wb(word_wb) , .word_back(word_wb), .opcode(opcode_id), .imm(imm_id), .value(value_id), .type_inst(type_inst_id), .enable_reg(enable_reg_id), .enable_reg_back(enable_reg_wb), .enable_write(enable_write_id), .jump_inc(jump_inc_id), .link(link_id), .load_new_PC(load_new_PC_id), .pc_val(pc_val_id), .link_back(link_wb), .set(set_id), .set_back(set_wb), .condition_back(condition_wb), .condition(condition_ex), .res(res_ex), .Rd_val_s(Rd_val_ex), .Rd_s(Rd_ex), .enable_reg_s(enable_reg_ex), .read_word_s(read_word_ex), .enable_write_s(enable_write_ex), .jump_inc_s(jump_inc_ex), .imm_s(imm_ex), .value_s(value_ex), .pc_val_s(pc_val_ex), .load_new_PC_s(load_new_PC_ex), .link_s(link_ex), .Rs1_val_s_r(Rs1_val_ex), .set_s(set_ex));
   Mem MEM(.clk(clk), .reset_n(reset_n), .res(res_ex), .Rd_val(Rd_val_ex), .enable_reg(enable_reg_ex), .read_word(read_word_ex), .enable_write(enable_write_ex), .Rd(Rd_ex), .pc_val(pc_val_ex), .link(link_ex), .word_wb(word_wb), .word_wb_bef(word_wb_bef), .set(set_ex), .condition(condition_ex), .d_address_s(d_address_mem), .Rd_val_s_r(Rd_val_mem),.enable_write_s(enable_write_mem),.Rd_s(Rd_mem), .enable_reg_s(enable_reg_mem), .read_word_s(read_word_mem), .res_s(res_mem), .pc_val_s(pc_val_mem), .link_s(link_mem), .set_s(set_mem), .condition_s(condition_mem));
   Wb WB(.clk(clk), .reset_n(reset_n), .res(res_mem), .d_data_read_s(d_data_read_full), .enable_reg(enable_reg_mem), .Rd(Rd_mem), .read_word(read_word_mem), .pc_val(pc_val_mem), .link(link_mem), .set(set_mem), .condition(condition_mem), .Rd_s(Rd_wb), .word(word_wb), .enable_reg_s(enable_reg_wb), .pc_val_s(pc_val_wb), .link_s(link_wb), .word_bef(word_wb_bef), .set_s(set_wb), .condition_s(condition_wb));

   always@(*)
   begin
    d_write_enable <= enable_write_mem;
    d_data_write <= Rd_val_mem;
    i_address <= pc_val_if;
    d_address <= d_address_mem;

    if((i_data_read >= 32'h00000000) && (i_data_read <= 32'hffffffff))
      i_data_read_full <= i_data_read;
    else
      i_data_read_full <= 0;

    if((d_data_read >= 32'h00000000) && (d_data_read <= 32'hffffffff))
      d_data_read_full <= d_data_read;
    else
      d_data_read_full <= 0;
  end

endmodule // DLX
