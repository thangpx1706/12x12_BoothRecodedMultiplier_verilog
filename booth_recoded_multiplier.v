//===================================================================
// File Name	:  booth_recoded_multiplier.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement multiply 2 12-bits numbers
//===================================================================

`include "reg_N.v"
`include "bin2comp.v"
`include "boothEn.v"
`include "ppCompressor.v"
`include "partialProductGen.v"
`include "cla_24bit.v"

module booth_recoded_multiplier(
    clk, reset, multiplicand, multiplier, prod
);
	//Input
    input clk;      // Clock
    input reset;    // Reset
	input [11:0] multiplicand, multiplier;
	//Output
	output [23:0] prod;
	//Wire	
	wire [11:0] A, B, A_2comp, B_2comp;
	wire [17:0] enc_op;
	wire [5:0] cor_bit;
	wire [84:0] pp;
	wire [23:0] out_x, out_y, sum,sumBuf;
	wire cout;
	//DFF	
	reg_N #(12) reg12_00(reset, clk, multiplicand, A);
	reg_N #(12) reg12_01(reset, clk, multiplier, B);
	//Binary to 2's complement conversion
	bin2comp #(12) bin00 (A, A_2comp);
	bin2comp #(12) bin01 (B, B_2comp);
    bin2comp #(24) bin02 ({multiplicand[11]^multiplier[11],sumBuf[22:0]}, sum);
	//Booth Encoder for Multiplier	
    boothEnNBits #(12) booth_enc00(B_2comp, enc_op);
	//Partial Product Generator
    ppGenNBits #(12) pp_gen00( enc_op, A_2comp, pp, cor_bit);
	//Wallace Tree - Summation of Partial Product
    ppCompressor_12 pp_comp( pp, cor_bit, out_x, out_y);
	//Carry Look-ahead Adder
	cla_24bit cla00(out_x, out_y , 1'b0, sumBuf, cout);
	//DFF
	reg_N #(24) reg24_00(reset, clk, {multiplicand[11]^multiplier[11],sum[22:0]}, prod);
endmodule