module vga_controller (input logic clk_in, rst, 
							  output logic h_sync, v_sync, n_blank, n_sync, clk_out, 
							  output [7:0] R, G, B);

	logic clk;
	logic [9:0] h_count;
	logic [9:0] v_count;
	logic [9:0] x_pixel;
	logic [9:0] y_pixel;
	logic enable;
	logic [7:0] R_color;
	logic [7:0] G_color;
	logic [7:0] B_color;
	logic new_line;
	
	assign n_blank = 1'b1;
	assign n_sync = 1'b0;
	assign clk_out = clk;
	assign R = R_color;
	assign G = G_color;
	assign B = B_color;
	
	clock_divider clock_divider (.clk_in(clk_in),
										  .clk_out(clk));
	
	horizontal_counter horizontal_counter (.clk(clk),
														.rst(rst),
														.new_line(new_line),
														.h_count(h_count));
														
	vertical_counter vertical_counter (.clk(clk),
												  .rst(rst),
												  .v_count(v_count),
												  .new_line(new_line));
	
	horizontal_sincronization horizontal_sincronization (.clk(clk),
																		  .rst(rst),
																		  .h_count(h_count),
																		  .h_sync(h_sync));
	
	vertical_sincronization vertical_sincronization (.clk(clk),
																	 .rst(rst),
																	 .v_count(v_count),
																	 .new_line(new_line),
																	 .v_sync(v_sync));
	
	display_syncronization display_syncronization (.clk(clk),
																  .rst(rst),
																  .h_count(h_count),
																  .v_count(v_count),
																  .new_line(new_line),
																  .x_pos(x_pixel),
																  .y_pos(y_pixel));
	
	display_enable display_enable (.clk(clk),
											.rst(rst),
											.h_count(h_count),
											.v_count(v_count),
											.new_line(new_line),
											.enable(enable));
	
	always_comb begin 
		
		if (x_pixel < 10'd300) begin
			R_color = 8'hf5;
			G_color = 8'h42;
			B_color = 8'hd1;
		end
		
		else if (y_pixel < 10'd200) begin
			R_color = 8'hf5;
			G_color = 8'hc2;
			B_color = 8'h42;
		end		
		else if (enable) begin
			R_color = 8'h42;
			G_color = 8'hef;
			B_color = 8'hf5;
		end
		
		else begin
			R_color = 8'h00;
			G_color = 8'h00;
			B_color = 8'h00;
		end
		
	end

endmodule
