

/**



*/

`timescale 1 ps / 1 ps

module central_memory #(parameter WIDTH = 32)(
	input		logic					clock,
	input		logic [WIDTH-1:0] address_I,	// address to read instruction
	input 	logic 				r_iena,		// enable read instructions 
	input		logic [WIDTH-1:0] address_D,	// address to read/write data
	input 	logic 				d_ena,		// enable data section
	input 	logic					wr_dena, 	// 0 write / 1 read
	input		logic [WIDTH-1:0] data_in,		// data to write
	output	logic [WIDTH-1:0] q_I,			// output instruction
	output	logic [WIDTH-1:0] q_D			// data read
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
	
	logic [WIDTH-1:0] real_address;
	fulladder subs(.a(address_D), 
				 .b(16384), 
				 .cin(1), 
				 .c(real_address));

	assign wren_ram1 = (!address_D[18]&&address_D[17]&&address_D[16] && d_ena && !wr_dena)? 1'b1:1'b0;
	assign wren_ram2 = (!address_D[18]&&!address_D[17]&&!address_D[16]&& d_ena && !wr_dena)? 1'b1:1'b0;
	assign wren_ram3 = (!address_D[18]&&!address_D[17]&&address_D[16]&& d_ena && !wr_dena)? 1'b1:1'b0;

	codigo mem_code(	.address(address_I[13:0]),
							.clock(clock),
							.q(out_q_I));

	rom1 mem1 (	.address(real_address[15:0]),
							.clock(clock),
							.q(q_D1));
							
	rom2 mem2 (	.address(real_address[15:0]),
							.clock(clock),
							.q(q_D2));
							
	rom3 mem3 (	.address(real_address[15:0]),
							.clock(clock),
							.q(q_D3));
							
	ram mem4 (	.address(real_address[15:0]),
					.clock(clock),
					.data(data_in[7:0]),
					.wren(wren_ram1),
					.q(q_D4));
					
	ram mem5 (	.address(real_address[15:0]),
					.clock(clock),
					.data(data_in[7:0]),
					.wren(wren_ram2),
					.q(q_D5));
					
	ram mem6 (	.address(real_address[15:0]),
					.clock(clock),
					.data(data_in[7:0]),
					.wren(wren_ram3),
					.q(q_D6));
	
	always @(posedge clock) begin
		#1
		if(r_iena)
			q_I <= out_q_I;		
		else 
			q_I <= 32'b0;
			
		if(d_ena) begin
			if(wr_dena)begin 
				case(real_address[18:16])
					3'b000 : q_D <= {16'h000,q_D1};
					3'b001 : q_D <= {16'h000,q_D2};
					3'b010 : q_D <= {16'h000,q_D3};
					3'b011 : q_D <= {23'h00000,q_D4};
					3'b100 : q_D <= {23'h00000,q_D5};
					3'b101 : q_D <= {23'h00000,q_D6};
				default: q_D <= 32'h0;
				endcase
			end else 
				q_D = 32'h0;
		end else 
			q_D <= 32'h0;
	end
	
endmodule
