module pixel_address(input [9:0] x_pixel, y_pixel,
							output in_region,
                     output [31:0] address);
							
	logic in_temp = 1'b0;
	logic [31:0] add = 32'd0;
	parameter location = 32'd212992;

	assign address = location + add;
	assign in_region = in_temp;
	
	always_comb begin
		if (x_pixel == 9'd159 & y_pixel == 9'd80) begin
			add = 32'd0;
			in_temp = 1'b0;
		end
		else if (x_pixel < 9'd160 | x_pixel >= 9'd480 | 
			y_pixel < 9'd80 | y_pixel >= 9'd400) begin
			add = 32'd0;
			in_temp = 1'b0;
		end
		else begin
			add = (x_pixel - 9'd160) + 32'd320 * (y_pixel - 9'd80) + 1'b1;
			in_temp = 1'b1;
		end
	end
    
endmodule

//	always_comb begin 
//		
//		if (x_pixel < 10'd300) begin
//			R_color = 8'hf5;
//			G_color = 8'h42;
//			B_color = 8'hd1;
//		end
//		
//		else if (y_pixel < 10'd200) begin
//			R_color = 8'hf5;
//			G_color = 8'hc2;
//			B_color = 8'h42;
//		end		
//		else if (enable) begin
//			R_color = 8'h42;
//			G_color = 8'hef;
//			B_color = 8'hf5;
//		end
//		
//		else begin
//			R_color = 8'h00;
//			G_color = 8'h00;
//			B_color = 8'h00;
//		end
//		
//	end

//	always_comb begin 
//		
//		if (in_region) begin
//			R_color = pixel_color;
//			G_color = pixel_color;
//			B_color = pixel_color;
//		end
//		
//		else if (enable) begin
//			R_color = 8'h80;
//			G_color = 8'h92;
//			B_color = 8'h9e;
//		end
//		
//		else begin
//			R_color = 8'h00;
//			G_color = 8'h00;
//			B_color = 8'h00;
//		end
//		
//	end