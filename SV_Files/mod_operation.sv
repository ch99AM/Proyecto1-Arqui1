

/**


*/
module mod_operation #(parameter WIDTH = 32)(
	input 	logic 				clock,
	input 	logic 				reset,
	input 	logic 				mod_ena,
	input 	logic	[WIDTH-1:0]	A_in,
	input 	logic	[WIDTH-1:0] B_in,
	output	logic [WIDTH-1:0] out,
	output	logic mod_state,
	output 	logic write_out
	);
	
	logic [WIDTH-1:0] Q = 32'h0;
	logic [WIDTH-1:0] M = 32'h0;
	logic [WIDTH-1:0] A = 32'h0;
	logic [WIDTH-1:0] N = 32'h0;
	logic [WIDTH-1:0] temp = 32'h0;
	logic [WIDTH-1:0]	w_s = 32'h0; 
	logic write = 1'b0;
	logic temp_modstate = 1'b0;
	
	assign write_out = write;
	assign mod_state = temp_modstate;
	assign out = temp;
	
	logic [WIDTH-1:0] n_max = 32'b0;
	logic [WIDTH-1:0] bits; 
	int_len_detc ildm (A_in, bits);
	
	
	always @(posedge clock)begin
		if(reset) begin
			write = 1'b0;
			N = 32'b0;
			w_s = 32'b0; 
			temp_modstate = 1'b0;
		end
		else begin
			if(A_in == B_in & mod_ena) begin
					A = 32'b0;
					w_s = 32'b1;
			end else if (A_in < B_in & mod_ena) begin 
					A = A_in;
					w_s = 32'b1;
			end else if (mod_ena) begin 
				Q = A_in;
				M = B_in;
				A = 32'h0;
				N = bits;
				n_max = bits-1;
				temp_modstate = 1;
				w_s = N + 32'b1;
			end
			if(temp_modstate == 1'b1)begin
				A = A << 1;
				A[0] = Q[n_max];
				Q = Q << 1;
				temp = A - M;
				if(temp[31])begin
					Q[0] = 1'b0;
				end else begin 
					Q[0] = 1'b1;
					A = temp; 				
				end
				N = N - 1'b1; 
				w_s = w_s - 1'b1;
			end
			
			if (N == 32'h0)begin
				temp_modstate = 0;
				temp = A;
			end
			if (w_s == 32'h1 & N == 32'h0) begin
				write = 1'b1;
				w_s = 32'h0;
			end else
				write = 1'b0;
		end
	end
	
endmodule
