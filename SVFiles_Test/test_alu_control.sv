module test_alu_control();
	
	logic[2:0] code;
	logic[1:0] alu_funct;
	
	alu_control DTU(code, alu_funct);
	
	initial begin
		
		code = 3'b000;
		#10
		code = 3'b010;
		#10
		code = 3'b001;
		#10
		code = 3'b110;	

	end
	
endmodule