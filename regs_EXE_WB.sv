module regs_EXE_WB (input logic clk,
						  input logic [3:0] wr_allow, 
												  in_alu_Rd, in_ld_Rd, in_mul_Rd, in_div_Rd, 
						  input logic [31:0] alu_exe, ld_exe, mul_exe, div_exe, 
						  output logic [3:0] final_Rd, busy,
													out_alu_Rd, out_ld_Rd, out_mul_Rd, out_div_Rd,
						  output logic [31:0] final_result,
													 alu_wb, ld_wb, mul_wb, div_wb);

	logic [3:0] alu_Rd = 4'd0;
	logic [31:0] alu = 32'd0;
	logic [3:0] ld_Rd = 4'd0;
	logic [31:0] ld = 32'd0;
	logic [3:0] mul_Rd = 4'd0;
	logic [31:0] mul = 32'd0;
	logic [3:0] div_Rd = 4'd0;
	logic [31:0] div = 32'd0;
	logic [3:0] ready_write = 4'd0;
	logic [3:0] next_Rd = 4'd0;
	logic [31:0] next_result = 32'd0;
	
	assign out_alu_Rd = alu_Rd;
	assign alu_wb = alu;
	assign out_ld_Rd = ld_Rd;
	assign ld_wb = ld;
	assign out_mul_Rd = mul_Rd;
	assign mul_wb = mul;
	assign out_div_Rd = div_Rd;
	assign div_wb = div;
	assign final_Rd = next_Rd;
	assign busy = ready_write;
	assign final_result = next_result;
	
	always_ff @(negedge clk) begin
		if (wr_allow[3]) begin
				alu_Rd <= in_alu_Rd;
				alu <= alu_exe;
				ready_write[3] <= 1'b1;
		end
		if (wr_allow[2]) begin
				ld_Rd <= in_ld_Rd;
				ld <= ld_exe;
				ready_write[2] <= 1'b1;
		end
		if (wr_allow[1]) begin
				mul_Rd <= in_mul_Rd;
				mul <= mul_exe;
				ready_write[1] <= 1'b1;
		end
		if (wr_allow[0]) begin
				div_Rd <= in_div_Rd;
				div <= div_exe;
				ready_write[0] <= 1'b1;
		end
	end
	
	always_ff @(posedge clk) begin
		if (ready_write[3]) begin
				next_Rd <= alu_Rd;
				next_result <= alu;
				ready_write[3] <= 1'b0;
				alu_Rd <= 4'd0;
				alu <= 32'd0;
		end
		else if (wr_allow[2]) begin
				next_Rd <= ld_Rd;
				next_result <= ld;
				ready_write[2] <= 1'b0;
				ld_Rd <= 4'd0;
				ld <= 32'd0;
		end
		else if (wr_allow[1]) begin
				next_Rd <= mul_Rd;
				next_result <= mul;
				ready_write[1] <= 1'b0;
				mul_Rd <= 4'd0;
				mul <= 32'd0;
		end
		else if (wr_allow[0]) begin
				next_Rd <= div_Rd;
				next_result <= div;
				ready_write[0] <= 1'b0;
				div_Rd <= 4'd0;
				div <= 32'd0;
		end
	end

endmodule
