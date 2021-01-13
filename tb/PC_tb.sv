module PC_tb();

   logic clk;
   logic reset_n;
   logic sel_inc;
   logic enable_PC;
   logic load_new_PC;
   logic [31:0] RS1_val;
   logic signed [15:0] immediate;
   logic signed [25:0] value;
   logic [31:0] pc_val;

   PC pc0(.clk(clk), .reset_n(reset_n), .sel_inc(sel_inc), .enable_PC(enable_PC), .load_new_PC(load_new_PC),.RS1_val(RS1_val),.immediate(immediate),.value(value) ,.pc_val(pc_val));

   always
     #5ns
       clk <= !clk;
   initial
     begin
  	clk <= 0;
  	reset_n <= 0;
  	sel_inc <= 0;
  	enable_PC <= 1;
  	load_new_PC <= 0;
    RS1_val <=0;
    immediate <= 0;
    value <=0;

  	#7ns
  	  reset_n <= 1;

  	#10ns
  	  sel_inc <= 1;

  	#40ns
      enable_PC <=0;
    #35ns
    enable_PC <= 1;
    immediate <= 16'hDEAD;
    sel_inc <= 0;
    #10ns
    immediate <= 0;
    value <= 26'b00000000000000000000000001;
  	#10ns
    load_new_PC<=1;
    RS1_val <= 32'hDEADBEEF;

  	#10ns
  	  load_new_PC <= 0;
  	  sel_inc <= 1;
    #20ns
      reset_n <= 0;

     end


endmodule // PC_tb
