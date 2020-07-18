


module clock_divider (input logic clk_in, 
							 output logic clk_out);

	logic counter = 1'b0;
	
	always_ff @(posedge clk_in) begin
	
			counter <= ~counter;
	end
		
	assign clk_out = counter;
//	logic [16:0] counter = 16'd0;
//	logic clk = 1'b0;
//	
//	assign clk_out = clk;
//	
//	always_ff @(posedge clk_in) begin
//			counter <= counter + 16'd1;
//			if (counter == 16'd1500) begin
//				clk <= ~clk;
//				counter <= 16'd0;
//			end
//	end

endmodule
