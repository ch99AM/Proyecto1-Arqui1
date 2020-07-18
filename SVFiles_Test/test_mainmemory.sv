
/**
		Test for main memory
*/

`timescale 1 ps / 1 ps

module test_mainmemory();

	parameter 			WIDTH = 32;
	
	logic					clk;
	logic [WIDTH-1:0] address_I;	// address to read instruction
	logic 				r_iena;		// enable read instructions 
	logic [WIDTH-1:0] rdaddress_D;// address to read room memory
	logic [WIDTH-1:0] wraddress_D;// address to write ram memory
	logic [WIDTH-1:0] rdaddress_O;// address to read ram memory 
	logic					r_dena;		// 1 read room memory
	logic					wr_dena;		// 1 write ram
	logic [WIDTH-1:0] data_in;		// data to write ram
	logic [WIDTH-1:0] q_I;			// output instruction
	logic [WIDTH-1:0] q_D;			// data read of room 
	logic [WIDTH-1:0] q_O;		
	
	central_memory dut1(	.clock(clk),
								.address_I(address_I),
								.r_iena(r_iena),		 
								.rdaddress_D(rdaddress_D),	
								.wraddress_D(wraddress_D),
								.rdaddress_O(rdaddress_O),
								.r_dena(r_dena),		
								.wr_dena(wr_dena), 	
								.data_in(data_in),		
								.q_I(q_I),			
								.q_D(q_D),
								.q_O(q_O));	 
	
	always #5 clk = ~clk;

	initial begin 
		clk = 0;
		
		r_iena = 1'b1;
		address_I = 32'b0;
								//Lectura simultanea de la memoria
		r_dena = 1'b1;
		rdaddress_D = 32'h4000;
		
		wr_dena = 1'b1;
		wraddress_D = 32'd212992;
		data_in = 32'd3;
		#10
		r_iena = 1'b0;
		address_I = 32'b1;
		
		r_dena = 1'b1;
		rdaddress_D = 32'h4001;
		
		wr_dena = 1'b0;
		rdaddress_O = 32'd212992;
		#10
		r_iena = 1'b1; 		
		address_I = 32'b10;
		
		r_dena = 1'b0;	
		rdaddress_D = 32'h4001;
		
		
		rdaddress_O = 32'h34000;
		#10
		
		wr_dena = 1'b1;
		wraddress_D = 32'd344065;
		data_in = 32'd2;
		#10
		
		wr_dena = 1'b1;
		wraddress_D = 32'd265536;
		data_in = 32'd2;
		 
		r_dena = 1'b1; 
		rdaddress_O	= 32'd278529;
		
		#10
		r_dena = 1'b1;
		rdaddress_O = 32'd344065;
		
		#10
		r_dena = 1'b1;
		rdaddress_O = 32'd265536;
		
	end

endmodule
