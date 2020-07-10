module regs_ID_EXE (input logic clk, wr_allow,
						  input logic [3:0] in_Rd, in_Rs1, in_Rs2, 
						  input logic [31:0] in_D1, in_D2, 
						  input logic [18:0] in_imm_2R1, 
						  input logic [25:0] in_imm_RI, 
						  output logic [3:0] out_Rd, out_Rs1, out_Rs2, 
						  output logic [31:0] out_D1, out_D2, 
						  output logic [18:0] out_imm_2R1, 
						  output logic [25:0] out_imm_RI);

	logic [3:0] Rd = 4'd0;
	logic [3:0] Rs1 = 4'd0;
	logic [31:0] D1 = 32'd0;
	logic [3:0] Rs2 = 4'd0;
	logic [31:0] D2 = 32'd0;
	logic [21:3] imm_2R1 = 19'd0;
	logic [25:0] imm_RI = 26'd0;
	
	assign out_Rd = Rd;
	assign out_Rs1 = Rs1;
	assign out_D1 = D1;
	assign out_Rs2 = Rs2;
	assign out_D2 = D2;
	assign out_imm_2R1 = imm_2R1;
	assign out_imm_RI = imm_RI;
	
	always_ff @(negedge clk) begin
		if (wr_allow) begin
				Rd <= in_Rd;
				Rs1 <= in_Rs1;
				D1 <= in_D1;
				Rs2 <= in_Rs2;
				D2 <= in_D2;
				imm_2R1 <= in_imm_2R1;
				imm_RI <= in_imm_RI;
		end
	end

endmodule
