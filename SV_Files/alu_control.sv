module alu_control(input logic[1:0] code,
						 output logic[1:0] alu_funct);
						 
	always_comb begin
		case(code)
			3'b00: alu_funct = 2'b00;
			3'b01: alu_funct = 2'b01;
			3'b10: alu_funct = 2'b10;
			3'b11: alu_funct = 2'b11;
			default: alu_funct = 2'b00;
		endcase
	
	end

endmodule
