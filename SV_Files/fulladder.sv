 module fulladder(input logic [31:0] a, b, 
						input logic cin, 
						output logic [31:0] c);

	always_comb begin
		
		if (cin == 1'b1)
			c = a + ~b + cin;
		
		else
			c = a + b;
			
	end
								
endmodule
