
/**
	test bench multiplier
*/

`timescale 1 ps / 1 ps
module test_multiplier();
	
	
	logic [31:0]  a, b;
   logic [31:0] out;
	logic clock;
	
	mul dut1(clock, a, b, out);
	
	always #5 clock= ~clock;
	initial begin 
	clock = 0;
	
	a = 32'd5;
	b = 32'd5;
	
	#10
	a = 32'd65426;
	b = 32'd25453;
	end
	
endmodule

	 

	 
	 