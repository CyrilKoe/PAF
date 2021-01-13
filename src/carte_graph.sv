module carte_graph
  #(parameter int ADDRESS_WIDTH = 13)
(
  input logic clk,
  input logic reset_n,

  input logic [31:0] DLX_address,
  input logic [31:0] DLX_data_write,
  input logic DLX_write_enable,
  output logic [31:0] DLX_data_read,


  // VERS FPGA

  output logic VGA_CLK,
  output logic VGA_HS,
  output logic VGA_VS,
  output logic VGA_BLANK,
  output logic [7:0] VGA_R,
  output logic [7:0] VGA_G,
  output logic [7:0] VGA_B,
  output logic VGA_SYNC
  );


  logic [31:0] vga_address;
  logic [31:0] vga_data_read;


  logic [ADDRESS_WIDTH-1:0] DLX_address_short;
  logic [ADDRESS_WIDTH-1:0] vga_address_short;

  logic [31:0] graph_data_read;

  always@(*)
  begin
  DLX_address_short <= DLX_address[ADDRESS_WIDTH-1:0];
  vga_address_short <= vga_address[ADDRESS_WIDTH-1:0];
  end

  byte_enabled_true_dual_port_ram ram_dp_graph(.addr1(DLX_address_short),.addr2(vga_address_short),.data_in1(DLX_data_write),.we1(DLX_write_enable),.clk(clk),.data_out1(DLX_data_read),.data_out2(vga_data_read));
  vga my_vga(.clock_50(clk), .reset_n(reset_n), .vga_data_read(vga_data_read),.vga_clk(VGA_CLK), .vga_hs(VGA_HS), .vga_vs(VGA_VS), .vga_blank(VGA_BLANK), .vga_sync(VGA_SYNC),
  .R(VGA_R), .G(VGA_G), .B(VGA_B), .vga_address(vga_address));

endmodule
