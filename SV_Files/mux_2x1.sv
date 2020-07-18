module mux_2x1(
    input logic [31:0] in_0, in_1,
    input logic sel,
    output logic [31:0] out);

    assign out = sel ? in_1 : in_0;
    
endmodule
