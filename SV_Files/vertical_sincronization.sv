module vertical_sincronization (input logic clk, rst, new_line,
										  input logic [9:0] v_count, 
										  output logic v_sync);
	
	logic sync = 1'b0;
	parameter width = 480;
	parameter front_porch = 10;
	parameter pulse = 2;
	
	assign v_sync = sync;
	
	always_ff @(posedge clk) begin
		if (rst)
			sync <= 1'b0;
		else if (new_line)
			sync <= (v_count + 1'b1 < width + front_porch) | (v_count + 1'b1 >= width + front_porch + pulse);
	end

endmodule
	