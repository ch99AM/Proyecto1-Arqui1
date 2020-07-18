module horizontal_sincronization (input logic clk, rst, 
											 input logic [9:0] h_count, 
											 output logic h_sync);
	
	logic sync = 1'b0;
	parameter width = 640;
	parameter front_porch = 16;
	parameter pulse = 96;
	
	assign h_sync = sync;
	
	always_ff @(posedge clk) begin
		if (rst)
			sync <= 1'b0;
		else
			sync <= (h_count + 1'b1 < width + front_porch) | (h_count + 1'b1 >= width + front_porch + pulse);
	end

endmodule
	