module ext_module(input logic [25:0] imm,
						input logic [1:0] imm_ctrl,
						output logic [31:00] imm_ext);

						
	always @(imm, imm_ctrl) begin
		
		case(imm_ctrl)
		
			2'b00:	imm_ext = {13'b0, {imm[12:0]}};
			2'b01: 	imm_ext = {{13{imm[18]}}, imm[18:0]};
			2'b10:	imm_ext = {{6{imm[25]}}, imm};			
			default:	imm_ext = 32'b00;
		
		endcase
		
	end	
					

endmodule
