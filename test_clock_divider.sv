module test_clock_divider ();

	logic clk_in, clk_out;
	
	clock_divider DUT(.clk_in(clk_in), 
							.clk_out(clk_out));
							
	initial begin
	
		clk_in = 1'b1;
		#10 clk_in = 1'b0;
		#10 clk_in = 1'b1;
		#10 clk_in = 1'b0;
		#10 clk_in = 1'b1;
		#10 clk_in = 1'b0;
		#10 clk_in = 1'b1;
		#10 clk_in = 1'b0;
	
	end

endmodule
