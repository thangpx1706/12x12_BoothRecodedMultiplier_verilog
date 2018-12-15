//===================================================================
// File Name	:  cla_24bit.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement 24-bits carry look ahead algorithm
//===================================================================

`include "cla_4bit.v"

module cla_24bit(
    a, b , cin, sum, cout
);

    input[23:0] a,b;
    input cin;

    output[23:0] sum;
    output cout;

    wire [4:0] c;

    cla_4bit cla1(a[3:0],b[3:0],cin,sum[3:0],c[0]);
    cla_4bit cla2(a[7:4],b[7:4],c[0],sum[7:4],c[1]);
    cla_4bit cla3(a[11:8],b[11:8],c[1],sum[11:8],c[2]);
    cla_4bit cla4(a[15:12],b[15:12],c[2],sum[15:12],c[3]);
    cla_4bit cla5(a[19:16],b[19:16],c[3],sum[19:16],c[4]);
    cla_4bit cla6(a[23:20],b[23:20],c[4],sum[23:20],cout);

endmodule