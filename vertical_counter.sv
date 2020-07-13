module vertical_counter (input logic clk, rst, new_line,
								 output logic [9:0] v_count);
		
	logic [9:0] count = 10'd0;
	parameter width = 480;
	parameter front_porch = 10;
	parameter pulse = 2;
	parameter back_porch = 33;
	parameter total = width + front_porch + pulse + back_porch;
	
	assign v_count = count;
	
	always_ff @(posedge clk) begin
		
		if (rst | (new_line & count >= total - 1))
			count <= 10'd0;
		else if (new_line)
			count <= count + 10'd1;
		
	end
	
endmodule
	