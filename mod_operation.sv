

/**


*/
module mod_operation #(parameter WIDTH = 32)(
	input 	logic 				clock,	
	input 	logic 				mod_ena,
	input 	logic	[WIDTH-1:0]	A_in,
	input 	logic	[WIDTH-1:0] B_in,
	output	logic [WIDTH-1:0] out,
	output	logic mod_state
	);
	
	logic [WIDTH-1:0] Q;
	logic [WIDTH-1:0] M = 1'h0;
	logic [WIDTH-1:0] A = 1'h0;
	logic [WIDTH-1:0] N;
	logic [WIDTH-1:0] temp;
	
	
	always @(posedge clock)begin 
		if (mod_ena) begin 
			Q = A_in;
			M = B_in;
			A = 32'h0;
			N = 32'h10;
			mod_state = 1;
		end
		if(mod_state == 1'b1)begin
			A = A << 1;
			A[0] = Q[15];
			Q = Q << 1;
			temp = A - M;
			if(temp[15])begin
				Q[0] = 1'b0;
			end else begin 
				Q[0] = 1'b1;
				A = temp; 				
			end
			N = N - 1'b1;
		end
		
		if (N == 32'h0)begin
			mod_state = 0;
		end		
	end
	
	assign out = temp;
	
endmodule
