module ALU(input logic [31:0] a, b,
			  input logic [1:0] alu_funct,
			  output logic [31:0] alu_out);
			  
	logic [31:0] and_result;
	logic [31:0] sum_result;
	logic [31:0] res_result;
	logic [31:0] asr_result;
	
	and_gate and_op(a, b, and_result);
	fulladder sum_op(a, b, 1'b0, sum_result);
	fulladder res_op(a, b, 1'b1, res_result);
	aritmetic_right_shifter asr_op(a, b, asr_result);
	
	mux_4x1 op_selector(sum_result, res_result, and_result, asr_result, alu_funct, alu_out);

endmodule
