module branch_detector(input logic[31:0] d1, d2,
							  input logic br_ctrl,
							  output logic branch_slct);
	
	reg[31:0] tmp;
	reg cmp;
		
	always_comb begin
	
		tmp = d1 ^ d2;
		cmp = tmp == 32'b0;
		if (cmp & br_ctrl == 1'b0 || ~cmp & br_ctrl == 1'b1)
				branch_slct = 1'b1;
		else	
				branch_slct = 1'b0;
				
	end

endmodule
