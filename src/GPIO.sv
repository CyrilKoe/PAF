/*  MAPAGE

0  : SW
4  : LEDR
8  : KEYS

*/

module GPIO(
  input clk,
  input reset_n,
  input logic [31:0] gpio_address,
  input logic [31:0] gpio_data_write,
  input logic gpio_write_enable,
  output logic gpio_rdata_valid,
  output logic [31:0] gpio_data_read,

  input logic [9:0] 	sw,
  input logic [3:0]   key,
  output logic [9:0] ledr
  );


  logic [31:0] sw_extended;
  logic [31:0] key_extended;
  logic [31:0] ledr_extended;

  always @(*)
  begin
    sw_extended <= sw;
    key_extended <= key;
    ledr <= ledr_extended[9:0];
  end

  always @(posedge clk)
   begin
    gpio_data_read <= 0;

    if(gpio_address == 0)
      gpio_data_read <= sw_extended;
    else if(gpio_address == 4)
      gpio_data_read <= ledr_extended;
    else if(gpio_address == 8)
      gpio_data_read <= key_extended;
  end

  always @(posedge clk or negedge reset_n)
  if(!reset_n)
    ledr_extended <= 0;
  else
    if(gpio_write_enable && (gpio_address == 4))
      ledr_extended <= gpio_data_write;



endmodule
