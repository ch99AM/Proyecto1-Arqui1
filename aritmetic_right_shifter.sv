 module aritmetic_right_shifter(input signed [31:0] a, b, 
											output signed [31:0] c); 

	assign c = a >>> b;

endmodule
