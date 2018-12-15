//===================================================================
// File Name	:  bin2comp.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement 2's complement
//===================================================================

module bin2comp #(
	parameter NUMBER_OF_BITS = 12
)(
	bin, inv_add
);
	//Input
	input [NUMBER_OF_BITS-1:0]bin;
	//Ouput
	output [NUMBER_OF_BITS-1:0]inv_add;
	
	assign	inv_add = bin[NUMBER_OF_BITS-1]?(~ bin +1'b1):bin;
	// assign	inv_add = (~ bin +1'b1);
endmodule
    