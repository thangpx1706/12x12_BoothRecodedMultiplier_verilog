//===================================================================
// File Name	:  csa.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement Carry Save Array with full and half adder modules
//===================================================================
`include "adder.v"

module CSA_fa #(
    parameter bits = 4
)(
    a,b,cin,sum,cout
);
    input [bits-1:0] a, b, cin;
    output [bits-1:0] sum, cout;

    genvar i;
    generate
        for(i=0;i<bits;i=i+1) begin
            full_adder fa(a[i],b[i],cin[i],cout[i],sum[i]);
        end
    endgenerate

endmodule

module CSA_ha #(
    parameter bits = 4
)(
    a,b,sum,cout
);
    input [bits-1:0] a, b;
    output [bits-1:0] sum, cout;

    genvar i;
    generate
        for(i=0;i<bits;i=i+1) begin
            half_adder ha(a[i],b[i],cout[i],sum[i]);
        end
    endgenerate

endmodule