


`timescale 1 ps / 1 ps
module test_main();

	logic  reset;
	logic h_sync, v_sync, n_blank, n_sync, clk_out;
	logic [7:0] R, G, B;
	integer f;	

	logic clk;
	always #5 clk =~ clk; 

	main i_main (clk, reset, h_sync, v_sync, n_blank, n_sync, clk_out, R, G, B);
	
	initial begin 
		clk = 0;
		reset = 0;
		
//		f = $fopen("vga.txt","w");
//		  repeat (4) begin
//				repeat (800) begin
//					 @(posedge clk_out)
//					 $fwrite(f,"%0d ns: ", $time);
//					 $fwrite(f,"%b ", h_sync);
//					 $fwrite(f,"%b ", v_sync);
//					 $fwrite(f,"%b ", R);
//					 $fwrite(f,"%b ", G);
//					 $fwrite(f,"%b\n", B);
//				end
//			  
//		  end
//		  $fclose(f);
//		  $finish;
		end
	
endmodule

