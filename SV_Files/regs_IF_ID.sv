module regs_IF_ID (input logic clk, wr_allow, flush,
						 input logic [31:0] in,
						 output logic [1:0] nme,
						 output logic [3:0] Rd, Rs1, Rs2,
						 output logic [2:0] opcode,
						 output logic [18:0] imm_2R1, 
						 output logic [22:0] imm_RI, 
						 output logic [26:0] imm_J);

	logic [31:0] instruction = 32'd0;
	logic [1:0] nme_temp = 2'bZZ;
	logic [2:0] op_code_temp = 3'bZZZ;
	
//	assign nme = instruction [31:30];
//	assign opcode = instruction [2:0];
	assign Rd = instruction [29:26];
	assign Rs1 = instruction [25:22];
	assign Rs2 = instruction [21:18];
	assign imm_2R1 = instruction [21:3];
	assign imm_RI = instruction [25:3];
	assign imm_J = instruction [29:3];

	assign nme = nme_temp;
	assign opcode = op_code_temp;
	always_ff @(negedge clk) begin
		if (wr_allow)	begin
			instruction <= in; 
			nme_temp <= in[31:30];
			op_code_temp <= in[2:0];
		end 
		if(flush) begin 
			nme_temp <= 2'b00;
			op_code_temp <= 3'b100;
			
		end 
	end

endmodule
