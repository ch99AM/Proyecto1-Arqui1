

module test_mod_operation();
	parameter WIDTH = 32;
	
	logic 				clock;	
	logic 				mod_ena;
	logic	[WIDTH-1:0]	A_in;
	logic	[WIDTH-1:0] B_in;
	logic [WIDTH-1:0] out;
	logic mod_state;
	logic write;
	
	mod_operation dut(
	.clock(clock),	
	.mod_ena(mod_ena),
	.A_in(A_in),
	.B_in(B_in),
	.out(out),
	.mod_state(mod_state),
	.write_out(write));
	
	always #5 clock = ~clock;
	
	initial  begin 
		clock = 0;   
		mod_ena = 1'b1;
		A_in = 6051600;
		B_in = 4819;
		#10
		mod_ena = 0;
		#240
		mod_ena = 1'b1;
		A_in = 6481;
		B_in = 4819;
		#10
		mod_ena = 0;
	 end
endmodule
