module half_word(input logic[31:0] in,
					  output logic[15:0] msb, lsb);

	assign msb = {in[31:16]};
	assign lsb = {in[15:0]};

endmodule
