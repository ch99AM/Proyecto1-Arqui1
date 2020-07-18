module test_branch_detector();
	
	logic[31:0] d1, d2;
	logic br_ctrl, branch_slct;
	
	branch_detector DTU(.d1(d1), .d2(d2), .br_ctrl(br_ctrl), .branch_slct(branch_slct));
	
	initial begin
	
		d1 = 32'b1010100001; d2 = 32'b1010100001;
		br_ctrl = 0;
		#10
		br_ctrl = 1;
		#10
		
		d1 = 32'b1000000010; d2 = 32'b1000000001;
		br_ctrl = 0;
		#10
		br_ctrl = 1;
		

	end
	
endmodule