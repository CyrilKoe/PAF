module DE1_SoC
    #(parameter ROM_ADDR_WIDTH=10, parameter RAM_ADDR_WIDTH=10)
    (
      ///////// clock /////////
      input logic 	clock_50,

      ///////// hex  /////////
      output logic [6:0] hex0,
      output logic [6:0] hex1,
      output logic [6:0] hex2,
      output logic [6:0] hex3,
      output logic [6:0] hex4,
      output logic [6:0] hex5,

      ///////// key /////////
      input logic [3:0] 	key,

      ///////// ledr /////////
      output logic [9:0] ledr,

      ///////// sw /////////
      input logic [9:0] 	sw,

      ///////// VGA  /////////
      output logic VGA_CLK,
      output logic VGA_HS,
      output logic VGA_VS,
      output logic VGA_BLANK,
      output logic [7:0] VGA_R,
      output logic [7:0] VGA_G,
      output logic [7:0] VGA_B,
      output logic VGA_SYNC

     );


   // Génération d'un reset à partir du bouton key[0]
   logic 			    reset_n;
   gene_reset gene_reset(.clk(clock_50), .key(sw[0]), .reset_n(reset_n));


   // Instantication de la ROM pour les instructions
   logic [31:0] 		    rom_addr;
   logic [31:0] 		    rom_rdata;
   logic 			    rom_rdata_valid;

   rom #(.ADDR_WIDTH(ROM_ADDR_WIDTH)) rom_instructions
     (
      .clk         ( clock_50                         ),
      .addr        ( rom_addr[(ROM_ADDR_WIDTH-1)+2:2] ),
      .rdata       ( rom_rdata                        ),
      .rdata_valid ( rom_rdata_valid                  )
      );

   logic [31:0]  d_address;
   logic [31:0]  d_data_read;
   logic [31:0] d_data_write;
   logic        d_write_enable;
   logic 	       d_data_valid;

   logic [31:0] 		    ram_addr;
   logic [31:0] 		    ram_wdata;
   logic 			        ram_we;
   logic 			        ram_rdata_valid;
   logic  [31:0] 		    ram_rdata;

   logic               gpio_we;
   logic [31:0] 		    gpio_addr;
   logic [31:0] 		    gpio_wdata;
   logic 			        gpio_rdata_valid;
   logic [31:0] 		    gpio_rdata;

   logic [31:0] 		    graph_addr;
   logic [31:0] 		    graph_wdata;
   logic 			        graph_we;
   logic 			        graph_rdata_valid;
   logic  [31:0] 		    graph_rdata;

   bus my_bus(.clk(clock_50),.d_address(d_address), .d_data_write(d_data_write),
  .d_write_enable(d_write_enable), .d_data_valid(d_data_valid),.d_data_read(d_data_read), .ram_addr(ram_addr),.ram_wdata(ram_wdata),.ram_we(ram_we),.ram_rdata(ram_rdata),.gpio_we(gpio_we),.gpio_addr(gpio_addr),.gpio_wdata(gpio_wdata),.gpio_rdata(gpio_rdata), .graph_we(graph_we), .graph_addr(graph_addr), .graph_wdata(graph_wdata), .graph_rdata(graph_rdata));

   ram #(.ADDR_WIDTH(RAM_ADDR_WIDTH)) ram_data
     (
      .clk         ( clock_50                       ),
      .addr        ( ram_addr[(RAM_ADDR_WIDTH-1)+2:2] ), //jbnkcejb
      .we          ( ram_we                           ),
      .wdata       ( ram_wdata                        ),
      .rdata       ( ram_rdata                        ),
      .rdata_valid ( ram_rdata_valid                  )
      );

    GPIO gpio(.clk(clock_50), .reset_n(reset_n),.gpio_address(gpio_addr),.gpio_data_write(gpio_wdata),.gpio_write_enable(gpio_we),.gpio_rdata_valid(gpio_rdata_valid),.gpio_data_read(gpio_rdata), .sw(sw), .key(key), .ledr(ledr));



   // Instanciation du processeur
   DLX dlx
     (
      .clk            ( clock_50        ),
      .reset_n        ( reset_n         ),
      .d_address      ( d_address        ),
      .d_data_read    ( d_data_read       ),
      .d_data_write   ( d_data_write       ),
      .d_write_enable ( d_write_enable          ),
      .d_data_valid   ( d_data_valid ),
      .i_address      ( rom_addr        ),
      .i_data_read    ( rom_rdata       ),
      .i_data_valid   ( rom_rdata_valid )
      );

      carte_graph my_carte_graph (
        .clk(clock_50), .reset_n(reset_n), .DLX_address(graph_addr), .DLX_data_write(graph_wdata), .DLX_write_enable(graph_we), .DLX_data_read(graph_rdata), .VGA_CLK(VGA_CLK), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .VGA_BLANK(VGA_BLANK), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_SYNC(VGA_SYNC)
      );


endmodule
