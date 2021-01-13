module DE1_SoC_tb();

   logic 	clock_50;
   logic [6:0] hex0;
   logic [6:0] hex1;
   logic [6:0] hex2;
   logic [6:0] hex3;
   logic [6:0] hex4;
   logic [6:0] hex5;

   ///////// key /////////
   logic [3:0] 	key;

   ///////// ledr /////////
   logic [9:0] ledr;

   ///////// sw /////////
   logic [9:0] 	sw;

   logic VGA_CLK;
   logic VGA_HS;
   logic VGA_VS;
   logic VGA_BLANK;
   logic [7:0] VGA_R;
   logic [7:0] VGA_G;
   logic [7:0] VGA_B;
   logic VGA_SYNC;

   DE1_SoC fpga(.clock_50(clock_50), .hex0(hex0), .hex1(hex1), .hex2(hex2), .hex3(hex3), .hex4(hex4), .hex5(hex5), .key(key), .ledr(ledr), .sw(sw),
   .VGA_CLK(VGA_CLK), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .VGA_BLANK(VGA_BLANK), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .VGA_SYNC(VGA_SYNC));


   always
     #5ns
       clock_50 <= !clock_50;

   initial
     begin
       clock_50 <= 0;
       key <= 0;
       sw[0] <= 0;
       key <= 0'b1111;

       #20ns
       sw[0] <= 1;
       #1000ns
       key <= 0'b1110;
       #1000ns
       key <= 0'b1111;
       #1000ns
       key <= 0'b1011;
     end


endmodule
