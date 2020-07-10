module multiplexer_4_to_1(input logic [31:0] d0, d1, d2, d3,
								 input logic [31:0] s, 
								 output logic [31:0] y);
	
	logic [31:0] mux_2_1;
	logic [31:0] mux_2_2;
	
	multiplexer multiplexer_2_to_1_1(d0, d1, s[0], mux_2_1);
	multiplexer multiplexer_2_to_1_2(d2, d3, s[0], mux_2_2);
	multiplexer multiplexer_2_to_1_result(mux_2_1, mux_2_2, s[1], y);

endmodule
