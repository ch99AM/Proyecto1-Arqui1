/**

*/

/*
sel_pc        	|    	[0:1]
pc_on        	|    	[2]
rd_allow    	|    	[3]
slct_rs1    	|    	[4]
slct_rs2    	|    	[5]
reg_rd        	|    	[6]
reg_wr        	|    	[7]
imm_ctrl    	|    	[8:9]
br_ctrl        |    	[10]
sela_alu    	|    	[11]
div_ena        |    	[12]
alu_code    	|    	[13:14]
ld_ena        	|    	[15]
sw_ena        	|    	[16]	
w_IFD				|		[17]
w_IDE				|		[18]
w_EWB				|		[19:22]
flush				|		[23]
*/

module control_unit(
	input	logic [4:0] code_funct,
	input logic 		br_result, 
	input logic 		div_state,
	input	logic			risk_result, storage, 
	output logic [0:24] flags
	);
	
	always_comb begin  
		if(storage)
			flags = {2'b00,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,2'b11,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'b0,1'b1,4'b0000,1'b0,1'b0};
		else if ((risk_result & div_state) | (div_state & code_funct == 5'b00001))
			flags = {2'b00,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,2'b11,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'b0,1'b1,4'b0000,1'b0,1'b0};
		else begin 
			case(code_funct)
				5'b00000 : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,2'b11,1'b0,1'b0,1'b0,2'b00,1'b1,1'b0,1'b1,1'b1,4'b0100,1'b0,1'b0}; // cargar 2 bytes***
				5'b00001 : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,2'b11,1'b0,1'b0,1'b1,2'b00,1'b0,1'b0,1'b1,1'b1,4'b0001,1'b0,1'b0}; // modulo
				5'b00010 : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,2'b11,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'b1,1'b1,4'b0010,1'b0,1'b0};	// multiplicacion
				5'b01000 : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,2'b00,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'b1,1'b1,4'b1000,1'b0,1'b0};	// suma imm
				5'b01001 : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,2'b00,1'b0,1'b0,1'b0,2'b10,1'b0,1'b0,1'b1,1'b1,4'b1000,1'b0,1'b0};	// AND imm
				5'b01100 : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,2'b11,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'b1,1'b1,4'b1000,1'b0,1'b0};	// mov 
				5'b01101 : flags = {2'b00,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,2'b00,1'b0,1'b0,1'b0,2'b00,1'b0,1'b1,1'b1,1'b1,4'b0000,1'b0,1'b1};	// sw
				5'b01110 : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,2'b01,1'b0,1'b0,1'b0,2'b11,1'b0,1'b0,1'b1,1'b1,4'b1000,1'b0,1'b0};	// shri
				5'b10000 : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b0,1'b1,2'b10,1'b0,1'b1,1'b0,2'b00,1'b0,1'b0,1'b1,1'b1,4'b1000,1'b0,1'b0};	// li
				5'b11000 : flags = {2'b01,1'b1,1'b1,1'b0,1'b0,1'b0,1'b1,2'b11,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'b1,1'b1,4'b0000,1'b1,1'b0};	// jump
				5'b01010 : begin  
								flags = {2'bZZ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,2'b11,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'bZ,1'b1,4'b0000,1'bZ,1'b0};	// branch equal
								if(br_result) begin
									flags[0:1] = 2'b10;	
									flags[17] = 1'b0;
			 						flags[23] = 1'b1;
								end
								else begin
									flags[0:1] = 2'b00;
									flags[17] = 1'b1;
									flags[23] = 1'b0;
								end	
							  end
				5'b01011 : begin
								flags = {2'bZZ,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,2'b11,1'b1,1'b0,1'b0,2'b00,1'b0,1'b0,1'bZ,1'b1,4'b0000,1'bZ,1'b0};	// branch not equal
								if(br_result) begin
									flags[0:1] = 2'b10;
									flags[17] = 1'b0;	
									flags[23] = 1'b1;
								end
								else begin
									flags[0:1] = 2'b00;
									flags[17] = 1'b1;
									flags[23] = 1'b0;
								end
							  end
				5'b11111 : flags = {2'b00,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,2'b11,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'b0,1'b0,4'b0000, 1'b0,1'b0};
				default  : flags = {2'b00,1'b1,1'b1,1'b0,1'b0,1'b0,1'b1,2'b11,1'b0,1'b0,1'b0,2'b00,1'b0,1'b0,1'b1,1'b0,4'b0000, 1'b0,1'b0};
			endcase
		end
	end

endmodule 


