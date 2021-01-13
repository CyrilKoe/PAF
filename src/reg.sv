module registre(input logic clk,
		input logic  reset_n,
		input logic  in,
		input logic  enable,
		output logic out);

   always @(posedge clk or negedge reset_n)
     if (~reset_n)
       out <= 0;
     else
       if (enable)
	 out <= in;
endmodule // reg
