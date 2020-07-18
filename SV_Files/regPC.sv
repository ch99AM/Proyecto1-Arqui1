module regPC (input logic clk, pc_ld, 
				  input logic [31:0] in,
				  output logic [31:0] out);

	logic [31:0] pc = 32'd0;
	
	assign out = pc;
	
	always_ff @(negedge clk) begin
		if (pc_ld)
			pc <= in; 
	end

endmodule
