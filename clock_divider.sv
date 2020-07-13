module clock_divider (input logic clk_in, 
							 output logic clk_out);

	logic counter = 1'b0;
	
	always_ff @(posedge clk_in) begin
	
			counter <= ~counter;
	end
		
	assign clk_out = counter;

endmodule
