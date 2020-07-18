
/**
	

*/
module div_risk(
	input logic [3:0] rs1_ID, rs2_ID, rd_div_EXE,
	output logic result	
	);
	
	logic temp_result;
	assign result = temp_result;
	
	always_comb begin 
		if(rs1_ID == rd_div_EXE | rs2_ID == rd_div_EXE)
			temp_result = 1'b1;
		else 
			temp_result = 1'b0;
	end
	
endmodule
