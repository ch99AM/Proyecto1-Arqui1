module regs_EXE_WB (input logic clk,
						  input logic [3:0] wr_allow, 
												  in_alu_Rd, in_ld_Rd, in_mul_Rd, in_div_Rd, 
						  input logic [31:0] alu_exe, ld_exe, mul_exe, div_exe, 
						  output logic [3:0] out_alu_Rd, out_ld_Rd, out_mul_Rd, out_div_Rd,
						  output logic [31:0] alu_wb, ld_wb, mul_wb, div_wb);

	logic [3:0] alu_Rd = 4'd0;
	logic [31:0] alu = 32'd0;
	logic [3:0] ld_Rd = 4'd0;
	logic [31:0] ld = 32'd0;
	logic [3:0] mul_Rd = 4'd0;
	logic [31:0] mul = 32'd0;
	logic [3:0] div_Rd = 4'd0;
	logic [31:0] div = 32'd0;
	
	assign out_alu_Rd = alu_Rd;
	assign alu_wb = alu;
	assign out_ld_Rd = ld_Rd;
	assign ld_wb = ld;
	assign out_mul_Rd = mul_Rd;
	assign mul_wb = mul;
	assign out_div_Rd = div_Rd;
	assign div_wb = div;
	
	always_ff @(negedge clk) begin
		if (wr_allow[3]) begin
				alu_Rd <= in_alu_Rd;
				alu <= alu_exe;
		end
		if (wr_allow[2]) begin
				ld_Rd <= in_ld_Rd;
				ld <= ld_exe;
		end
		if (wr_allow[1]) begin
				mul_Rd <= in_mul_Rd;
				mul <= mul_exe;
		end
		if (wr_allow[0]) begin
				div_Rd <= in_div_Rd;
				div <= div_exe;
		end
	end

endmodule
