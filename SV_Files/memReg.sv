module memReg(input logic rd_allow, wr_allow, clk,
				  input logic [3:0] Rd, Rs1, Rs2,
				  input logic [31:0] DI,
				  output logic [31:0] D1, D2);

	logic [15:0][31:0] memory = 512'd0;
	
	always_ff @(negedge clk) begin
		if (wr_allow)
			memory[Rd][31:0] <= DI;
	end
	
	always_ff @(posedge clk) begin
		if (rd_allow) begin
			D1 <= memory[Rs1][31:0];
			D2 <= memory[Rs2][31:0];
		end
		else begin
			D1 <= 32'd0;
			D2 <= 32'd0;
		end
	end

endmodule
