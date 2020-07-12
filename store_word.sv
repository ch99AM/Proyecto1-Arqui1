
/**


*/

module store_word #(parameter WIDTH = 32)(
	input 	logic 				clock,
	input 	logic [WIDTH-1:0]	data_in,
	input 	logic	[WIDTH-1:0]	address_in,
	input 	logic 				sw_ena,
	output 	logic	[WIDTH-1:0]	data_out,
	output	logic [WIDTH-1:0] address_out,
	output 	logic 				d_ena,
	output	logic 				wr_dena
);
	
	logic temp_dena;
	logic temp_wr_dena;
	
	assign data_out = (sw_ena)? data_in : 32'hZZZZZZZZ;
	assign address_out = (sw_ena)? address_in : 32'hZZZZZZZZ;
	
	always @(posedge clock)begin 
		if(sw_ena)begin 
			temp_dena <= 1;
			temp_wr_dena <= 0;
		end else begin 
			temp_dena <= 1'bZ;
			temp_wr_dena <= 1'bZ;
		end
	end 
	
	assign d_ena = temp_dena;
	assign wr_dena = temp_wr_dena;



endmodule
