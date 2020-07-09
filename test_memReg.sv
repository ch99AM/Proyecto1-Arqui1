module test_memReg();

	logic reg_rd, reg_wr, clk;
	logic [3:0] Rd, Rs1, Rs2;
	logic [31:0] DI, D1, D2;
	
	memReg DUT(.reg_rd(reg_rd), .reg_wr(reg_wr), .clk(clk),
				  .Rd(Rd), .Rs1(Rs1), .Rs2(Rs2),
				  .DI(DI), .D1(D1), .D2(D2));
	
	initial begin
		
		reg_rd = 1'b0; reg_wr = 1'b0; clk = 1'b1;
		Rd = 4'd0; Rs1 = 4'd0; Rs2 = 4'd1;
		DI = 32'h45;
		#10 clk = 1'b0;
		#10 reg_wr = 1'b1; clk = 1'b1;
		#10 clk = 1'b0;
		#10 reg_rd = 1'b1; reg_wr = 1'b1; clk = 1'b1;
		Rd = 4'd1;
		DI = 32'h33;
		#10 clk = 1'b0;
		#10 clk = 1'b1;
		Rd = 4'd4;
		DI = 32'h777;
		#10 clk = 1'b0;
		#10 clk = 1'b1;
		Rd = 4'd7;
		DI = 32'h69;
		#10 clk = 1'b0;
		#10 reg_wr = 1'b0; clk = 1'b1;
		Rd = 4'd0; Rs1 = 4'd4;
		DI = 32'd0;
		#10 clk = 1'b0;
		#10 clk = 1'b1;
		Rs1 = 4'd3; Rs2 = 4'd7;
		#10 clk = 1'b0;
		#10 reg_rd = 1'b0; clk = 1'b1;
		#10 clk = 1'b0;
		
	end

endmodule
