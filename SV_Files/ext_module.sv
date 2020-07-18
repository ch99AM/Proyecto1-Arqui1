module ext_module(input logic [18:0] imm_1,
						input logic [22:0] imm_2,
						input logic [1:0] imm_ctrl,
						output logic [31:00] imm_ext);

	logic [12:0] temp1;
	logic [8:0] temp2;
	assign temp1 = {13{imm_1[18]}};
	assign temp2 = {9{imm_2[22]}};
	always_comb begin
		
		case(imm_ctrl)
			2'b00:	imm_ext = {13'b0, imm_1};
			2'b01: 	imm_ext = {temp1, imm_1};
			2'b10:	imm_ext = {temp2, imm_2};			
			default:	imm_ext = 32'b00;
		
		endcase
		
	end	
					

endmodule
