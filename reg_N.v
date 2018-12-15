//===================================================================
// File Name	:  partialProductGen_tb.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement D-FF register with multiple inputs and outputs
//===================================================================

module reg_N #(
	parameter NUMBER_OF_BITS = 12
)(
	reset, clk, D, Q
);
	//Input
	input clk, reset;
	input [NUMBER_OF_BITS-1:0] D; 
	//Output
	output [NUMBER_OF_BITS-1:0] Q;
	//Register
	reg [NUMBER_OF_BITS-1:0] Q;
	
	always @ (posedge clk or posedge reset)
	if (reset==1)
	Q <= 0;
	else
	Q <= D;
endmodule 

