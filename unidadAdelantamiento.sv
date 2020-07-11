module unidadAdelantamiento (input logic clk, in_mod, 
									  input logic [3:0] alu_Rd, ld_Rd, mul_Rd, div_Rd,
															  ID_Rs1, ID_Rs2, EXE_Rs1, EXE_Rs2,
									  input logic [31:0] alu_DI, ld_DI, mul_DI, div_DI,
									  output logic ID1_adel, ID2_adel, EXE1_adel, EXE2_adel,
									  output logic [31:0] ID_D1, ID_D2, EXE_D1, EXE_D2);
	
	always_ff @(posedge clk) begin
		ID1_adel <= 1'b1;
		ID2_adel <= 1'b1;
		EXE1_adel <= 1'b1;
		EXE2_adel <= 1'b1;
		if (~in_mod) begin
			if (ID_Rs1 == alu_Rd)
				ID_D1 <= alu_DI;
			else if (ID_Rs1 == ld_Rd)
				ID_D1 <= ld_DI;
			else if (ID_Rs1 == mul_Rd)
				ID_D1 <= mul_DI;
			else if (ID_Rs1 == div_Rd)
				ID_D1 <= div_DI;
			else
				ID1_adel <= 1'b0;
				
			if (ID_Rs2 == alu_Rd)
				ID_D2 <= alu_DI;
			else if (ID_Rs2 == ld_Rd)
				ID_D2 <= ld_DI;
			else if (ID_Rs2 == mul_Rd)
				ID_D2 <= mul_DI;
			else if (ID_Rs2 == div_Rd)
				ID_D2 <= div_DI;
			else
				ID2_adel <= 1'b0;
			
			if (EXE_Rs1 == alu_Rd)
				EXE_D1 <= alu_DI;
			else if (EXE_Rs1 == ld_Rd)
				EXE_D1 <= ld_DI;
			else if (EXE_Rs1 == mul_Rd)
				EXE_D1 <= mul_DI;
			else if (EXE_Rs1 == div_Rd)
				EXE_D1 <= div_DI;
			else
				EXE1_adel <= 1'b0;
				
			if (EXE_Rs2 == alu_Rd)
				EXE_D2 <= alu_DI;
			else if (EXE_Rs2 == ld_Rd)
				EXE_D2 <= ld_DI;
			else if (EXE_Rs2 == mul_Rd)
				EXE_D2 <= mul_DI;
			else if (EXE_Rs2 == div_Rd)
				EXE_D2 <= div_DI;
			else
				EXE2_adel <= 1'b0;
		end
	end

endmodule
