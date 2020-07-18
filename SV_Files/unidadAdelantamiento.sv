module unidadAdelantamiento (input logic [3:0] alu_Rd, ld_Rd, mul_Rd, div_Rd,
															  ID_Rs1, ID_Rs2, EXE_Rs1, EXE_Rs2,
									  input logic [31:0] alu_DI, ld_DI, mul_DI, div_DI,
									  output logic ID1_adel, ID2_adel, EXE1_adel, EXE2_adel,
									  output logic [31:0] ID_D1, ID_D2, EXE_D1, EXE_D2);
	
	logic ID1=1'b0;
	logic ID2=1'b0;
	logic EXE1=1'b0;
	logic EXE2 = 1'b0;
	
	assign ID1_adel = ID1;
	assign ID2_adel = ID2;
	assign EXE1_adel = EXE1;
	assign EXE2_adel = EXE2;
	
	always_comb begin
		if (ID_Rs1 == alu_Rd) begin 
			ID_D1 = alu_DI;
			ID1 = 1'b1;
		end
		else if (ID_Rs1 == ld_Rd)begin
			ID_D1 = ld_DI;
			ID1 = 1'b1;
		end
		else if (ID_Rs1 == mul_Rd) begin
			ID_D1 = mul_DI;
			ID1 = 1'b1;
		end	
		else if (ID_Rs1 == div_Rd)begin
			ID_D1 = div_DI;
			ID1 = 1'b1;
		end
		else begin
			ID1 = 1'b0;
			ID_D1 = 32'b0;
		end
			
		if (ID_Rs2 == alu_Rd)begin
			ID_D2 = alu_DI;
			ID2 = 1'b1;
		end
		else if (ID_Rs2 == ld_Rd)begin
			ID_D2 = ld_DI;
			ID2 = 1'b1;
		end
		else if (ID_Rs2 == mul_Rd)begin
			ID_D2 = mul_DI;
			ID2 = 1'b1;
		end
		else if (ID_Rs2 == div_Rd)begin
			ID_D2 = div_DI;
			ID2 = 1'b1;
		end
		else begin
			ID_D2 = 32'b0;
			ID2 = 1'b0;
		end
		
		if (EXE_Rs1 == alu_Rd) begin
			EXE_D1 = alu_DI;
			EXE1 = 1'b1;
		end
		else if (EXE_Rs1 == ld_Rd)begin
			EXE_D1 = ld_DI;
			EXE1 = 1'b1;
		end
		else if (EXE_Rs1 == mul_Rd)begin
			EXE_D1 = mul_DI;
			EXE1 = 1'b1;
		end
		else if (EXE_Rs1 == div_Rd)begin
			EXE_D1 = div_DI;
			EXE1 = 1'b1;
		end
		else begin
			EXE1 = 1'b0;
			EXE_D1 = 32'b0;
		end
			
		if (EXE_Rs2 == alu_Rd) begin
			EXE_D2 = alu_DI;
			EXE2 = 1'b1;
		end
		else if (EXE_Rs2 == ld_Rd) begin 
			EXE_D2 = ld_DI;
			EXE2 = 1'b1;
		end else if (EXE_Rs2 == mul_Rd) begin
			EXE_D2 = mul_DI;
			EXE2 = 1'b1;
		end
		else if (EXE_Rs2 == div_Rd) begin
			EXE_D2 = div_DI;
			EXE2 = 1'b1;
		end
		else begin
			EXE2 = 1'b0;
			EXE_D2 = 32'b0;
		end
	end

endmodule
