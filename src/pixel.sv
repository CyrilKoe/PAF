// largeur : 80
// hauteur : 60

module pixel(
  input logic vga_blank,
  input logic [9:0] vga_x,
  input logic [8:0] vga_y,

  output logic[7:0] R,
  output logic[7:0] G,
  output logic[7:0] B,

  output logic [31:0] vga_address,
  input logic [31:0] vga_data_read
  );

  logic [6:0] vga_x_quot; //division par 8
  logic [5:0] vga_y_quot;
  logic [2:0] vga_x_rest;
  logic [2:0] vga_y_rest;

  always @(*)
  begin
    vga_x_rest <= vga_x[2:0];
    vga_y_rest <= vga_y[2:0];
    vga_x_quot <= vga_x >> 3;
    vga_y_quot <= vga_y >> 3;
  end

  always@(*)
  begin
    vga_address <= vga_y_quot*80 + vga_x_quot;
  end

  always @(*)
  if(vga_blank)
  begin
    R <= vga_data_read[7:0];
    G <= vga_data_read[15:8];
    B <= vga_data_read[25:16];
  end
  else
  begin
    R <= 0;
    G <= 0;
    B <= 0;
  end

/*
  always @(*)
  if(!vga_blank)
  begin
    R <= 255;
    G <= 0;
    B <= 255;
  end
  else
  begin
    R <= 0;
    G <= 0;
    B <= 0;
  end

*/
endmodule
