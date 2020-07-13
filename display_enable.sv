module display_enable(input logic clk, rst, new_line, 
							 input logic [9:0] h_count, v_count, 
							 output logic enable);
							  
	logic visible = 0;
	parameter h_width = 640;
	parameter v_width = 480;
	
	assign enable = visible;
	
	always_ff @(posedge clk) begin
		if (rst == 1)
			visible <= 1'b0;
			
		else if (h_count < h_width - 1 | h_count == 799) begin
		
			if (v_count == v_width - 1 & new_line)
				visible <= 1'b0;
				
			else if (v_count <= v_width - 1)
				visible <= 1'b1;
				
		end
		
		else
			visible <= 1'b0;
	end

endmodule
