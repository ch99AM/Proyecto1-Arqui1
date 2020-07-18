module regs_ID_EXE (input logic clk, wr_allow,
						  input	logic [0:5] in_flags,
						  input logic [3:0] in_Rd, in_Rs1, in_Rs2, unit_in,
						  input logic [31:0] in_D1, in_D2, 
						  input logic [31:0] in_imm, 
						  output logic [3:0] out_Rd, out_Rs1, out_Rs2, unit_out, 
						  output logic [31:0] out_D1, out_D2, 
						  output logic [31:0] out_imm,
						  output logic [3:0] div_Rd,
						  output	logic [0:5]	out_flags);

	logic [3:0] Rd = 4'd0;
	logic [3:0] Rs1 = 4'd0;
	logic [31:0] D1 = 32'd0;
	logic [3:0] Rs2 = 4'd0;
	logic [31:0] D2 = 32'd0;
	logic [31:0] imm = 32'd0;
	logic [3:0] unit = 4'd0;
	logic [0:5] flags = 6'd0;
	logic [3:0] div_Rd_temp = 4'dZ;
	
	assign out_Rd = Rd;
	assign out_Rs1 = Rs1;
	assign out_D1 = D1;
	assign out_Rs2 = Rs2;
	assign out_D2 = D2;
	assign out_imm = imm;
	assign unit_out = unit;
	assign out_flags = flags;
	assign div_Rd = div_Rd_temp;
	
	always_ff @(negedge clk) begin
		if (wr_allow) begin
				Rd <= in_Rd;
				Rs1 <= in_Rs1;
				D1 <= in_D1; 
				Rs2 <= in_Rs2;
				D2 <= in_D2;
				imm <= in_imm;
				unit <= unit_in;
				flags <= in_flags;
		end
		if(unit_in[0])
			div_Rd_temp <= in_Rd;
	end

endmodule 
