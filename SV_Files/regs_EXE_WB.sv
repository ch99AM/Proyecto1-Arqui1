module regs_EXE_WB (input logic clk,
						  input logic [3:0] wr_allow, 
												  in_alu_Rd, in_ld_Rd, in_mul_Rd, in_div_Rd, 
						  input logic [31:0] alu_exe, ld_exe, mul_exe, div_exe, 
						  output logic [3:0] final_Rd,
													out_alu_Rd, out_ld_Rd, out_mul_Rd, out_div_Rd,
						  output logic [31:0] final_result,
													 alu_wb, ld_wb, mul_wb, div_wb,
						  output logic storage, wr_ena);

	logic [3:0] alu_Rd = 4'dZ;
	logic [31:0] alu = 32'd0;
	logic [3:0] ld_Rd = 4'dZ;
	logic [31:0] ld = 32'd0;
	logic [3:0] mul_Rd = 4'dZ;
	logic [31:0] mul = 32'd0;
	logic [3:0] div_Rd = 4'dZ;
	logic [31:0] div = 32'd0;
	logic [3:0] next_Rd = 4'd0;
	logic [3:0] ready_write = 4'd0;
	logic [3:0] readen = 4'd0;
	logic [31:0] next_result = 32'd0;
	logic write = 1'b0;
	
	assign wr_ena = write;
	assign out_alu_Rd = alu_Rd;
	assign alu_wb = alu;
	assign out_ld_Rd = ld_Rd;
	assign ld_wb = ld;
	assign out_mul_Rd = mul_Rd;
	assign mul_wb = mul;
	assign out_div_Rd = div_Rd;
	assign div_wb = div;
	assign final_Rd = next_Rd;
	assign final_result = next_result;
	assign storage = ready_write[0] & (ready_write[3] | ready_write[2] | ready_write[1]);
	
	always_ff @(negedge clk) begin
		if (wr_allow[3] & (~ready_write[3] | readen[3])) begin
			alu_Rd <= in_alu_Rd;
			alu <= alu_exe;
			ready_write[3] <= 1'b1;
		end
		else if (~wr_allow[3] & ready_write[3] & readen[3]) begin
			alu_Rd <= 4'dZ;
			alu <= 32'd0;
			ready_write[3] <= 1'b0;
		end
		
		if (wr_allow[2] & (~ready_write[2] | readen[2])) begin
			ld_Rd <= in_ld_Rd;
			ld <= ld_exe;
			ready_write[2] <= 1'b1;
		end
		else if (~wr_allow[2] & ready_write[2] & readen[2]) begin
			ld_Rd <= 4'dZ;
			ld <= 32'd0;
			ready_write[2] <= 1'b0;
		end
		
		if (wr_allow[1] & (~ready_write[1] | readen[1])) begin
			mul_Rd <= in_mul_Rd;
			mul <= mul_exe;
			ready_write[1] <= 1'b1;
		end
		else if (~wr_allow[1] & ready_write[1] & readen[1]) begin
			mul_Rd <= 4'dZ;
			mul <= 32'd0;
			ready_write[1] <= 1'b0;
		end
		
		if (wr_allow[0] & (~ready_write[0] | readen[0])) begin
			div_Rd <= in_div_Rd;
			div <= div_exe;
			ready_write[0] <= 1'b1;
		end
		else if (~wr_allow[0] & ready_write[0] & readen[0]) begin
			div_Rd <= 4'dZ;
			div <= 32'd0;
			ready_write[0] <= 1'b0;
		end
	end
	
	always_ff @(posedge clk) begin
		readen <= 4'd0;
		write <= 1'b1;
		if (ready_write[3]) begin
			next_Rd <= alu_Rd;
			next_result <= alu;
			readen[3] <= 1'b1;
		end
		
		else if (ready_write[2]) begin
			next_Rd <= ld_Rd;
			next_result <= ld;
			readen[2] <= 1'b1;
		end
		
		else if (ready_write[1]) begin
			next_Rd <= mul_Rd;
			next_result <= mul;
			readen[1] <= 1'b1;
		end
		
		else if (ready_write[0]) begin
			next_Rd <= div_Rd;
			next_result <= div;
			readen[0] <= 1'b1;
		end
		
		else
			write <= 1'b0;
	end

endmodule
