module horizontal_counter (input logic clk, rst, 
									output logic [9:0] h_count,
									output logic new_line);
		
	logic [9:0] count = 10'd0;
	logic line = 1'b0;
	parameter width = 640;
	parameter front_porch = 16;
	parameter pulse = 96;
	parameter back_porch = 48;
	parameter total = width + front_porch + pulse + back_porch;
	
	assign h_count = count;
	assign new_line = line;
	
	always_ff @(posedge clk) begin
		
		if (rst) begin
			count <= 10'd0;
			line <= 1'b0;
		end
		
		else if (count >= total - 1) begin
			count <= 10'd0;
			line <= 1'b0;
		end
		
		else begin
			count <= count + 10'd1;
			line <= 1'b0;
			if (count == total - 2)
				line <= 1'b1;
		end
	end
	
endmodule
	