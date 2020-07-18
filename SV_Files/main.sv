


module main (
	input logic clk, reset,
	output logic h_sync, v_sync, n_blank, n_sync, clk_out,
	output logic [7:0] R, G, B		
);
	logic [31:0] address_IO;
	logic [7:0] q_IO;
	procesador core_i12(clk, address_IO, q_IO);

	vga_controller DUT (.clk_in(clk),
								.pix(q_IO),
							  .rst(reset),
							  .h_sync(h_sync),
							  .v_sync(v_sync),
							  .n_blank(n_blank),
							  .n_sync(n_sync),
							  .clk_out(clk_out),
							  .R(R),
							  .G(G),
							  .B(B),
							  .address_pix(address_IO));
							  
endmodule
