
/**
	Num extend imm brach and  jump
*/

module branch_jump_pc(
  input  logic [26:0]	imm_jump,
  input	logic [18:0] 	imm_branch,
  output logic [31:0]	pc_jump,
  output	logic [31:0] 	pc_branch 
);
	
	logic [14:0] temp;
	
	assign pc_jump = {7'b0000000,imm_jump[26:2]};
	assign temp = {15{imm_branch[18]}};
	assign pc_branch = {temp, imm_branch[18:2]};
	
endmodule
