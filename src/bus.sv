/*
-----MAPPAGE-----
bit 16 = 0 et 15 = 0 => RAM
bit 16 = 0 et 15 = 1 => gpio
bit 16 = 1           => graph

*/

module bus
#(parameter ROM_ADDR_WIDTH=10, parameter RAM_ADDR_WIDTH=10)
(
  input logic clk,
  input logic [31:0] d_address,
  input logic [31:0] d_data_write,
  input logic d_write_enable,
  input logic d_data_valid,
  output logic [31:0] d_data_read,

  output logic [31:0] ram_addr,
  output logic [31:0] ram_wdata,
  output logic ram_we,
  input logic  [31:0] ram_rdata,

  output logic gpio_we,
  output logic [31:0] gpio_addr,
  output logic [31:0] gpio_wdata,
  input logic [31:0] gpio_rdata,

  output logic graph_we,
  output logic [31:0] graph_addr,
  output logic [31:0] graph_wdata,
  input logic [31:0] graph_rdata
  );

  logic ram_cs_w;
  logic gpio_cs_w;
  logic graph_cs_w;

  logic ram_cs_r;
  logic gpio_cs_r;
  logic graph_cs_r;


  always@(posedge clk)
  begin
  ram_cs_r <=0;
  gpio_cs_r <= 0;
  graph_cs_r <= 0;
  if(d_address[15] == 0)
    if(d_address[14] == 0)
      ram_cs_r <= 1;
    else
      gpio_cs_r <= 1;
  else
    graph_cs_r <=1;
  end

  always@(*)
  begin
  ram_cs_w <=0;
  gpio_cs_w <= 0;
  graph_cs_w <= 0;
  if(d_address[15] == 0)
    if(d_address[14] == 0)
      ram_cs_w <= 1;
    else
      gpio_cs_w <= 1;
  else
    graph_cs_w <=1;
  end

  always@(*)
  begin
  if(ram_cs_r)
    d_data_read <= ram_rdata;
  else
    if(gpio_cs_r)
      d_data_read <= gpio_rdata;
    else
      if(graph_cs_r)
        d_data_read <= graph_rdata;
      else
        d_data_read <= 0;
  end

  always@(*)
  begin
    gpio_we <= (d_write_enable & gpio_cs_w);
    ram_we  <= (d_write_enable & ram_cs_w);
    graph_we  <= (d_write_enable & graph_cs_w);
  end

  always@(*)
  begin
    gpio_addr <= (d_address & 32'b00000000000000000011111111111111);
    ram_addr <= (d_address & 32'b00000000000000000011111111111111);
    graph_addr <= (d_address & 32'b00000000000000001111111111111111);
    ram_wdata <= d_data_write;
    gpio_wdata <= d_data_write;
    graph_wdata <= d_data_write;
  end



endmodule
