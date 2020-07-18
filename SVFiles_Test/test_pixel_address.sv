`timescale 1ns/1ns

module test_pixel_address ();

	logic [9:0] x_pixel, y_pixel;
	logic in_region;
	logic [31:0] address;
	
	pixel_address DUT (.x_pixel(x_pixel),
							 .y_pixel(y_pixel), 
							 .address(address),
							 .in_region(in_region));
	
	initial begin
		x_pixel = 9'd0; y_pixel = 9'd0;
		repeat(480) begin
			repeat(640) begin
				#1 x_pixel = x_pixel + 9'd1;
			end
			y_pixel = y_pixel + 9'd1; x_pixel = 9'd0;
		end
	end
	
endmodule
