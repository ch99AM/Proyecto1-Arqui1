

/**

	Main memory for instruccion and data

*/

`timescale 1 ps / 1 ps

module central_memory #(parameter WIDTH = 32)(
	input		logic					clock,
	input		logic [WIDTH-1:0] address_I,	// address to read instruction
	input 	logic 				r_iena,		// enable read instructions 
	input		logic [WIDTH-1:0] rdaddress_D,// address to read room memory
	input		logic [WIDTH-1:0] wraddress_D,// address to write ram memory
	input		logic [WIDTH-1:0] rdaddress_O,// address to read ram memory 
	input 	logic					r_dena, 		// 1 read room memory
	input 	logic					wr_dena,		// 1 write ram
	input		logic [WIDTH-1:0] data_in,		// data to write ram
	output	logic [WIDTH-1:0] q_I,			// output instruction
	output	logic [WIDTH-1:0] q_D,			// data read of room 
	output	logic [WIDTH-1:0] q_O			// data read of ram
); 
	// instrunction memory
	logic [WIDTH-1:0] out_q_I;
	logic [15:0] q_D1;
	logic [15:0] q_D2;
	logic [15:0] q_D3;
	logic [7:0] q_D4;
	logic [7:0] q_D5;
	logic [7:0] q_D6;
	
	logic wren_ram1;
	logic wren_ram2;
	logic wren_ram3;
	
	logic [WIDTH-1:0] real_rdaddress;
	fulladder subs(.a(rdaddress_D), 
				 .b(16384), 
				 .cin(1), 
				 .c(real_rdaddress)); 
	
	logic [WIDTH-1:0] real_wraddress;
	fulladder subs1(.a(wraddress_D), 
				 .b(16384), 
				 .cin(1), 
				 .c(real_wraddress)); 

	assign wren_ram1 = (!real_wraddress[18]&&real_wraddress[17]&&real_wraddress[16] && wr_dena)? 1'b1:1'b0;
	assign wren_ram2 = (real_wraddress[18]&&!real_wraddress[17]&&!real_wraddress[16]&& wr_dena)? 1'b1:1'b0;
	assign wren_ram3 = (real_wraddress[18]&&!real_wraddress[17]&&real_wraddress[16]&& wr_dena)? 1'b1:1'b0;

	logic [WIDTH-1:0] real_rdaddressRAM;
	fulladder subs2(.a(rdaddress_O), 
				 .b(16384), 
				 .cin(1), 
				 .c(real_rdaddressRAM)); 
				 
	codigo mem_code(	.address(address_I[13:0]),
							.clock(clock),
							.q(out_q_I));

	rom1 mem1 (	.address(real_rdaddress[15:0]),
							.clock(clock),
							.q(q_D1));
							
	rom2 mem2 (	.address(real_rdaddress[15:0]),
							.clock(clock),
							.q(q_D2));
							
	rom3 mem3 (	.address(real_rdaddress[15:0]),
							.clock(clock),
							.q(q_D3));
							
	ram2P mem4 (.clock(clock),
					.data(data_in[7:0]),
					.rdaddress(real_rdaddressRAM[15:0]),
					.wraddress(real_wraddress[15:0]),
					.wren(wren_ram1),
					.q(q_D4));
					
	ram2P mem5 (.clock(clock),
					.data(data_in[7:0]),
					.rdaddress(real_rdaddressRAM[15:0]),
					.wraddress(real_wraddress[15:0]),
					.wren(wren_ram2),
					.q(q_D5));
					
	ram2P mem6 (.clock(clock),
					.data(data_in[7:0]),
					.rdaddress(real_rdaddressRAM[15:0]),
					.wraddress(real_wraddress[15:0]),
					.wren(wren_ram3),
					.q(q_D6));
					
	always @(posedge clock) begin
		#1
		if(r_iena)
			q_I <= out_q_I;		
		else 
			q_I <= 32'b0;
		if(r_dena)begin 
			case(real_rdaddress[18:16])
				3'b000 : q_D <= {16'h000,q_D1};
				3'b001 : q_D <= {16'h000,q_D2};
				3'b010 : q_D <= {16'h000,q_D3};
			default: q_D <= 32'h0;
			endcase
		end else 
			q_D = 32'h0;
		
		case(real_rdaddressRAM[18:16])
			3'b011 : q_O <= {23'h00000,q_D4};
			3'b100 : q_O <= {23'h00000,q_D5};
			3'b101 : q_O <= {23'h00000,q_D6};
		default: q_O <= 32'h0;
		endcase
	
	end
endmodule
