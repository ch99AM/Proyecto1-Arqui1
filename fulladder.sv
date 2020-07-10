 module fulladder(input logic [31:0] a, b, 
						input logic cin, 
						output logic [31:0] c, 
						output logic cout);

	always @(a, b, cin) begin
		
		if (cin == 1'b1)
			{cout, c} = a + ~b + cin;
		
		else
			{cout, c} = a + b + cin;
			
	end
								
endmodule
