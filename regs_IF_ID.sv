module regs_IF_ID (input logic clk, wr_allow,
						 input logic [31:0] in,
						 output logic [1:0] nme, opcode_3R, 
						 output logic [3:0] Rd, Rs1, Rs2,
						 output logic [2:0] opcode_2R1,
						 output logic [18:0] imm_2R1, 
						 output logic [25:0] imm_RI, 
						 output logic [29:0] imm_J);

	logic [31:0] instruction = 32'd0;
	
	assign nme = instruction [31:30];
	assign opcode_3R = instruction [1:0];
	assign Rd = instruction [29:26];
	assign Rs1 = instruction [25:22];
	assign Rs2 = instruction [21:18];
	assign opcode_2R1 = instruction [2:0];
	assign imm_2R1 = instruction [21:3];
	assign imm_RI = instruction [25:0];
	assign imm_J = instruction [29:0];
	
	always_ff @(negedge clk) begin
		if (wr_allow)
			instruction <= in; 
	end

endmodule
