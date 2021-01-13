module reg_bench(
	input logic 	     clk,
	input logic 	     enable_reg,
	input logic reset_n,
	input logic [4:0]   Rs1_s, //Registres de lecture
	input logic [4:0]   Rs2_s,
	input logic [4:0]   Rd_s, //Registre de lecture pour le SW
	input logic [4:0]   Rd_back, //Registre d'écriture
	input logic read_Rd, // Pour court circuiter WB
	input logic signed [31:0]  word_back, //Résultat du calcul
	input logic link_back,
	input logic set_back,
	input logic condition_back,
	output logic signed [31:0] Rs1_val_s, //Valeur lues
	output logic signed [31:0] Rs2_val_s,
	output logic signed [31:0] Rd_val_s
);

	logic [31:0] regs [31:0];


  always @(posedge clk or negedge reset_n) //Changement d'une valeur
		if(!reset_n)
		begin
			regs[0] <= 0;
			regs[1] <= 0;
			regs[2] <= 0;
			regs[3] <= 0;
			regs[4] <= 0;
			regs[5] <= 0;
			regs[6] <= 0;
			regs[7] <= 0;
			regs[8] <= 0;
			regs[9] <= 0;
			regs[10] <= 0;
			regs[11] <= 0;
			regs[12] <= 0;
			regs[13] <= 0;
			regs[14] <= 0;
			regs[15] <= 0;
			regs[16] <= 0;
			regs[17] <= 0;
			regs[18] <= 0;
			regs[19] <= 0;
			regs[20] <= 0;
			regs[21] <= 0;
			regs[22] <= 0;
			regs[23] <= 0;
			regs[24] <= 0;
			regs[25] <= 0;
			regs[26] <= 0;
			regs[27] <= 0;
			regs[28] <= 0;
			regs[29] <= 0;
			regs[30] <= 0;
			regs[31] <= 0;
		end
  	else
			if(enable_reg)
				if(link_back)
					regs[31] <= word_back+4;
				else
					if(Rd_back != 0)
					  if(set_back)
						  regs[Rd_back] <= condition_back;
						else
	 						regs[Rd_back] <= word_back;

	always @(*) //Branchement des sorties
	begin
		if(Rs1_s)
			Rs1_val_s <= regs[Rs1_s];
		else
			Rs1_val_s <= 0;

		if(Rs2_s)
			Rs2_val_s <= regs[Rs2_s];
		else
			Rs2_val_s <= 0;

		if(Rd_back)
			Rd_val_s <= regs[Rd_back];
		else
			Rd_val_s <= 0;

		if(read_Rd) // EN CAS DE LECTURE ON SORT LA VALEUR ACTUELLE DE RD
			if(Rd_s)
				Rd_val_s <= regs[Rd_s];
			else
				Rd_val_s <= 0;
	end


endmodule // reg_bench
