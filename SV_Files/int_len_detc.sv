

/**


*/
 
module int_len_detc(
        input logic [31:0] a,
        output logic [31:0] out
);
 
    logic [5:0] temp;
    assign out = temp;
    always_comb begin
        if(a[31])
            temp = 32'd32;
        else if(a[30])
            temp = 32'd31;
    else if(a[29])
            temp = 32'd30;
    else if(a[28])
            temp = 32'd29;
    else if(a[27])
            temp = 32'd28;
    else if(a[26])
            temp = 32'd27;
    else if(a[25])
            temp = 32'd26;
    else if(a[24])
            temp = 32'd25;
    else if(a[23])
            temp = 32'd24;
    else if(a[22])
            temp = 32'd23;
    else if(a[21])
            temp = 32'd22;
    else if(a[20])
            temp = 32'd21;
    else if(a[19])
            temp = 32'd20;
    else if(a[18])
            temp = 32'd19;
    else if(a[17])
            temp = 32'd18;
    else if(a[16])
            temp = 32'd17;
    else if(a[15])
            temp = 32'd16;
    else if(a[14])
            temp = 32'd15;
    else if(a[13])
            temp = 32'd14;
    else if(a[12])
            temp = 32'd13;
    else if(a[11])
            temp = 32'd12;
    else if(a[10])
            temp = 32'd11;
    else if(a[9])
            temp = 32'd10;
    else if(a[8])
            temp = 32'd9;
    else if(a[7])
            temp = 32'd8;
    else if(a[6])
            temp = 32'd7;
    else if(a[5])
            temp = 32'd6;
    else if(a[4])
            temp = 32'd5;
    else if(a[3])
            temp = 32'd4;
    else if(a[2])
            temp = 32'd3;
    else if(a[1])
            temp = 32'd2;
    else if(a[0])
            temp = 32'd1;
    else
            temp = 32'd0;
    end
 
endmodule
