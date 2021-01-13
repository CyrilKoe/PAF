/*
Horloge à 25 MHz
640
HFP = 16
HPULSE = 96
HBP = 48

(Arrivée en écriture à 160)

480
VFP = 11
VPULSE = 2
VBP = 31

somme = 44
*/

module vga(
  input logic clock_50,
  input logic reset_n,

  // VERS CARTE GRAPH

  input logic [31:0] vga_data_read,
  output logic vga_clk,
  output logic vga_hs,
  output logic vga_vs,
  output logic vga_blank,
  output logic vga_sync,

  output logic [7:0] R,
  output logic [7:0] G,
  output logic [7:0] B,
  output logic [31:0] vga_address

  );

  logic [9:0] vga_x;
  logic [8:0] vga_y;

  localparam HFP = 16;
  localparam HPULSE = 96;
  localparam HBP = 48;
  localparam HBLANK = (HFP+HPULSE+HBP);

  localparam VFP = 11;
  localparam VPULSE = 2;
  localparam VBP = 31;
  localparam VBLANK = (VFP+VPULSE+VBP);

  logic [9:0] x;
  logic [9:0] y;

  pixel pix(.vga_blank(vga_blank), .vga_x(vga_x), .vga_y(vga_y), .R(R), .G(G), .B(B), .vga_address(vga_address), .vga_data_read(vga_data_read));

  always @(posedge clock_50 or negedge reset_n)
  if (! reset_n)
    vga_clk <= 0;
  else
    vga_clk <= ! vga_clk;

  always @(posedge clock_50 or negedge reset_n)
  if (! reset_n)
  begin
    x <= 0;
    y <= 0;
  end
  else
  begin
    if (vga_clk)
    begin
        if(x < (HFP+HPULSE+HBP+640)-1)
          x <= x+1;
        else
        begin
          x <= 0;
          if(y == (VFP+VPULSE+VBP+480)-1)
            y <= 0;
          else
            y <= y+1;
        end
    end
  end

  always @ ( * )
  begin
      vga_hs <= !( (x >= HFP) && (x < HFP+HPULSE) );
      vga_vs <= !( (y >= VFP) && (y < VFP+VPULSE) );
      vga_blank <= !( (x < HBLANK) || (y < VBLANK) ) ;

      if(x < HBLANK)
        vga_x <= 0;
      else
        vga_x <= x - HBLANK;

      if(y < VBLANK)
        vga_y <= 0;
      else
        vga_y <= y - VBLANK;
  end

  assign vga_sync = 0;
endmodule
