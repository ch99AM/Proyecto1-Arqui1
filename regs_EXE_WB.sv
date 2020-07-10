module regs_EXE_WB (input logic clk,
						  input logic [3:0] wr_allow, in_alu_Rd, in_alu_Rs1, in_alu_Rs2,
												  in_ld_Rd, in_ld_Rs1, in_ld_Rs2,
												  in_mul_Rd, in_mul_Rs1, in_mul_Rs2,
												  in_div_Rd, in_div_Rs1, in_div_Rs2,
						  input logic [31:0] alu_exe, ld_exe, mul_exe, div_exe, 
						  output logic [3:0] out_alu_Rd, out_alu_Rs1, out_alu_Rs2,
												   out_ld_Rd, out_ld_Rs1, out_ld_Rs2,
												   out_mul_Rd, out_mul_Rs1, out_mul_Rs2,
												   out_div_Rd, out_div_Rs1, out_div_Rs2,
						  output logic [31:0] alu_wb, ld_wb, mul_wb, div_wb);

	logic [3:0] alu_Rd = 4'd0;
	logic [3:0] alu_Rs1 = 4'd0;
	logic [3:0] alu_Rs2 = 4'd0;
	logic [31:0] alu = 32'd0;
	logic [3:0] ld_Rd = 4'd0;
	logic [3:0] ld_Rs1 = 4'd0;
	logic [3:0] ld_Rs2 = 4'd0;
	logic [31:0] ld = 32'd0;
	logic [3:0] mul_Rd = 4'd0;
	logic [3:0] mul_Rs1 = 4'd0;
	logic [3:0] mul_Rs2 = 4'd0;
	logic [31:0] mul = 32'd0;
	logic [3:0] div_Rd = 4'd0;
	logic [3:0] div_Rs1 = 4'd0;
	logic [3:0] div_Rs2 = 4'd0;
	logic [31:0] div = 32'd0;
	
	assign out_alu_Rd = alu_Rd;
	assign out_alu_Rs1 = alu_Rs1;
	assign out_alu_Rs2 = alu_Rs2;
	assign alu_wb = alu;
	assign out_ld_Rd = ld_Rd;
	assign out_ld_Rs1 = ld_Rs1;
	assign out_ld_Rs2 = ld_Rs2;
	assign ld_wb = ld;
	assign out_mul_Rd = mul_Rd;
	assign out_mul_Rs1 = mul_Rs1;
	assign out_mul_Rs2 = mul_Rs2;
	assign mul_wb = mul;
	assign out_div_Rd = div_Rd;
	assign out_div_Rs1 = div_Rs1;
	assign out_div_Rs2 = div_Rs2;
	assign div_wb = div;
	
	always_ff @(negedge clk) begin
		if (wr_allow[3]) begin
				alu_Rd <= in_alu_Rd;
				alu_Rs1 <= in_alu_Rs1;
				alu_Rs2 <= in_alu_Rs2;
				alu <= alu_exe;
		end
		if (wr_allow[2]) begin
				ld_Rd <= in_ld_Rd;
				ld_Rs1 <= in_ld_Rs1;
				ld_Rs2 <= in_ld_Rs2;
				ld <= ld_exe;
		end
		if (wr_allow[1]) begin
				mul_Rd <= in_mul_Rd;
				mul_Rs1 <= in_mul_Rs1;
				mul_Rs2 <= in_mul_Rs2;
				mul <= mul_exe;
		end
		if (wr_allow[0]) begin
				div_Rd <= in_div_Rd;
				div_Rs1 <= in_div_Rs1;
				div_Rs2 <= in_div_Rs2;
				div <= div_exe;
		end
	end

endmodule