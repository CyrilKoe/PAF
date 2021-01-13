module Ex(
  input logic 	     clk,
	input logic        reset_n,
	input logic [4:0]   Rs1, //Rs1_id
	input logic [4:0]   Rs2, //Rs
	input logic [4:0]   Rd, //Registre d'écriture
  input logic [4:0]   Rd_back, //Registre d'écriture
	input logic read_word,
	//input logic link,
  input logic [31:0] res_mem,
  input logic [31:0] res_wb,

  input logic signed [31:0] word_back,
  input logic[5:0] opcode,
	input logic signed [15:0] imm,
  input logic signed [25:0] value,
	input logic [1:0] type_inst,
  input logic enable_reg, //Propagation du signal WE de l'instuction actuelle
  input logic enable_reg_back, //Retour du signal WE de l'instuction N-2
  input logic enable_write,
  input logic jump_inc,
  input logic link,
  input logic load_new_PC,
  input logic [31:0] pc_val,
  input logic link_back,
  input logic set,
  input logic set_back,
  input logic condition_back,

	output logic condition,
	output logic signed [31:0] res,
  output logic signed [31:0] Rd_val_s,
  output logic signed [4:0] Rd_s,
  output logic enable_reg_s, //Propagation du signal WE de l'instuction actuelle
  output logic read_word_s,
  output logic enable_write_s,
  output logic jump_inc_s,
  output logic signed [15:0] imm_s,
  output logic signed [25:0] value_s,
  output logic [31:0] pc_val_s, //Inutile en fait la valeur du pc passe dans res
  output logic load_new_PC_s,
  output logic link_s,
  output logic signed [31:0] Rs1_val_s_r,
  output logic set_s
  );

  logic [4:0]   Rs1_s;
	logic [4:0]   Rs2_s;

  logic signed [31:0] Rs1_val_s;
	logic signed [31:0] Rs2_val_s;
  logic signed [31:0] ALUres;

  logic signed [31:0] Rs2_val_s_r;

  logic [1:0] type_inst_s;
  logic[5:0] opcode_s;

  logic [4:0] Rd_bef;
  logic [4:0] Rd_bef_bef;


  always @(posedge clk or negedge reset_n)
  begin
    if(!reset_n)
    begin
      imm_s <= 0;
      value_s <= 0;
      opcode_s <= 0;
      Rd_s <= 0;
      enable_reg_s <= 0;
      read_word_s <= 0;
      type_inst_s <= 0;
      enable_write_s <= 0;
      Rd_bef <= 0;
      Rd_bef_bef <= 0;
      Rs1_s <= 0;
      Rs2_s <= 0;
      jump_inc_s <= 0;
      pc_val_s <= 0;
      link_s <= 0;
      load_new_PC_s <= 0;
      set_s <= 0;
    end
    else
    begin
      Rd_bef <= Rd_s;
      Rd_bef_bef <= Rd_bef;

      imm_s <= imm;
      value_s <= value;
      opcode_s <= opcode;
      Rd_s <= Rd;
      enable_reg_s <= enable_reg;
      read_word_s <= read_word;
      type_inst_s <= type_inst;
      enable_write_s <= enable_write;
      Rs1_s <= Rs1;
      Rs2_s <= Rs2;
      jump_inc_s <= jump_inc;
      pc_val_s <= pc_val;
      link_s <= link;
      load_new_PC_s <= load_new_PC;
      set_s <= set;
    end
  end


  reg_bench bench(.clk(clk), .enable_reg(enable_reg_back), .reset_n(reset_n), .Rs1_s(Rs1_s), .Rs2_s(Rs2_s), .Rd_s(Rd_s), .Rd_back(Rd_back), .read_Rd(enable_write_s), .word_back(word_back), .link_back(link_back), .set_back(set_back), .condition_back(condition_back),.Rs1_val_s(Rs1_val_s), .Rs2_val_s(Rs2_val_s), .Rd_val_s(Rd_val_s));
  ALU alu(.opcode(opcode_s), .Rs1_val(Rs1_val_s_r), .Rs2_val(Rs2_val_s_r), .imm(imm_s), .type_inst(type_inst_s), .condition(condition), .res(ALUres));

  always @(*)
  begin
    if((Rs1_s == Rd_bef) && (Rs1_s!=0))
      Rs1_val_s_r <= res_mem;
    else
      if((Rs1_s == Rd_bef_bef) && (Rs1_s!=0))
        Rs1_val_s_r <= res_wb;
      else
        Rs1_val_s_r <= Rs1_val_s;
  end

  always @(*)
  begin
    if((Rs2_s == Rd_bef) && (Rs2_s!=0))
      Rs2_val_s_r <= res_mem;
    else
      if((Rs2_s == Rd_bef_bef) &&(Rs2_s!=0))
        Rs2_val_s_r <= res_wb;
      else
        Rs2_val_s_r <= Rs2_val_s;
  end

  always @(*)
  if(link_s)
    res <= pc_val_s;
  else
    res <= ALUres;



endmodule
