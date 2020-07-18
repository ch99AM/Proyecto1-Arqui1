
/**
		Test for branch and jump pc
*/

module test_branch_jump_pc();
	logic [26:0]	imm_jump;
	logic [18:0] 	imm_branch;
	logic [31:0]	pc_jump;
	logic [31:0] 	pc_branch; 

	branch_jump_pc uut(
		.imm_jump(imm_jump),
		.imm_branch(imm_branch),
		.pc_jump(pc_jump),
		.pc_branch(pc_branch) 
	);


	initial begin 
	
	imm_jump = 27'b0000_0011_1111;
	imm_branch = 18'b0000_0110;
	
	
	end
endmodule
