module test_and();
	
	logic[25:0] imm;
	logic[1:0] imm_ctrl;
	logic[31:0] imm_ext;
	
	ext_module DTU(.imm(imm), .imm_ctrl(imm_ctrl), .imm_ext(imm_ext));
	
	initial begin
		
		imm_ctrl = 2'b00;
		imm = 13'b11;
		#10
		imm = 13'b00;
		#10
		imm = 13'b0111111111111;
		#10
		
		imm_ctrl = 2'b01;
		imm = 13'b11;
		#10
		imm = 13'b01;
		#10
		imm = 13'b1000000000000;
		#10
		imm = 13'b1111111111111;
		#10
		
		imm_ctrl = 2'b10;
		imm = 26'b11;
		#10
		imm = 26'b01;
		#10
		imm = 26'b00;
		#10
		imm = 26'b11111111111111111111111111;
		#10
		imm = 26'b10000000000000000000000000;

	end
	
endmodule
