module ALU_tb();
  logic [1:0] type_inst;
  logic [5:0] opcode;
  logic signed [31:0] Rs1_val;
  logic signed [31:0] Rs2_val;
  logic signed [15:0] imm;
  logic condition; //Si on detecte un saut conditionnel
  logic signed [31:0] res;

  ALU alu(.opcode(opcode), .Rs1_val(Rs1_val), .Rs2_val(Rs2_val), .imm(imm), .type_inst(type_inst), .condition(condition), .res(res));


  initial
  begin
    #5ns // 3 + 4
    type_inst <= 2'b01;
    opcode <= 6'h20;
    Rs1_val <= 3;
    Rs2_val <= 4;
    imm <= 0;

    #5ns // 3 - 4
    type_inst <= 2'b01;
    opcode <= 6'h20;
    Rs1_val <= 3;
    Rs2_val <= -4;
    imm <= 0;

    #5ns // 3 - 4
    type_inst <= 2'b01;
    opcode <= 6'h2a;
    Rs1_val <= 3;
    Rs2_val <= 4;
    imm <= 0;
  end

endmodule // Decodeur_tb
