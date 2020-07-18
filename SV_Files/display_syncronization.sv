module display_syncronization(input clk, rst, 
										input logic [9:0] h_count, v_count, new_line, 
										output logic [9:0] x_pos, y_pos);
	
	logic [9:0] x_pixel = 10'd0;
	logic [9:0] y_pixel = 10'd0;
	parameter h_width = 640;
	parameter v_width = 480;
	
	assign x_pos = x_pixel;
	assign y_pos = y_pixel;
	
	always_ff @(posedge clk) begin
	
		if(rst == 1) begin
			x_pixel = 10'd0;
			y_pixel = 10'd0;
		end
		
		else begin
			if (h_count >= 799)
				x_pixel <= 1'b0;
			else if(h_count < h_width - 1)
				x_pixel <= h_count + 1'b1;
			
			if (new_line & v_count >= 524)
				y_pixel <= 1'b0;
			else if(new_line & v_count < v_width - 1)
				y_pixel <= y_pixel + 1'b1;
				
		end
	end
										
endmodule
