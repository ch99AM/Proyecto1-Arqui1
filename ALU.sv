module ALU(input logic [31:0] a, b,
			  input logic [1:0] alu_funct,
			  output logic [31:0] alu_out,
			  output logic zero, _carry);
			  
	logic [31:0] and_result;
	logic [31:0] sum_result;
	logic [31:0] res_result;
	logic [31:0] asr_result;
	logic sum_cout;
	logic res_cout;
	
	and_gate and_op(a, b, and_result);
	fulladder sum_op(a, b, 1'b0, sum_result, sum_cout);
	fulladder res_op(a, b, 1'b1, res_result, res_cout);
	aritmetic_right_shifter asr_op(a, b, asr_result);
	
	multiplexer_4_to_1 op_selector(sum_result, res_result, and_result, asr_result, alu_funct, alu_out);

endmodule
