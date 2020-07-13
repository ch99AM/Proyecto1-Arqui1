module test_vga_controller ();

	logic clk_in, rst, h_sync, v_sync, n_blank, n_sync, clk_out;
	logic [7:0] R, G, B;
	
	vga_controller DUT (.clk_in(clk_in),
							  .rst(rst),
							  .h_sync(h_sync),
							  .v_sync(v_sync),
							  .n_blank(n_blank),
							  .n_sync(n_sync),
							  .clk_out(clk_out),
							  .R(R),
							  .G(G),
							  .B(B));
	
	initial begin
		
		clk_in = 1'b0; rst = 1'b0;
		
		repeat (800) begin
		
			repeat (5000) begin
				#1 clk_in = ~clk_in;
				#1 clk_in = ~clk_in;
			end
			
		end
	
	end
	
endmodule
