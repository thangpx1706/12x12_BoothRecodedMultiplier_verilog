//===================================================================
// File Name	:  cla_4bit.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement 4-bits carry look ahead algorithm
//===================================================================

module cla_4bit(x, y , cin, sum, cout);
	//Input
	input [3:0] x, y; 
	input cin;
	//Output
	output [3:0] sum;
	output cout;
	//Wire
	wire [4:0] s;
	wire [3:0] p;  /* Carry Propagate */
	wire [3:0] g;  /* Carry Generate */
	wire [4:0] c;  /* Intermediate Carry */
	//Compute p and g for each stage
	assign p[3:0] = x[3:0] ^ y[3:0];
	assign g[3:0] = x[3:0] & y[3:0];
	//Compute carry for each stage
	assign c[0] = cin;
	assign c[1] = g[0] | (p[0] & c[0]);
	assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
	assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0])| (p[2] & p[1] & p[0] & c[0]);
	assign c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1])| (p[3] & p[2] & p[1] & g[0])| (p[3] & p[2] & p[1] & p[0] & c[0]);
	//Compute sum
	assign s[4:0] = {1'b0, p[3:0]} ^ c[4:0];
	assign sum = s[3:0];
	//Assign output carry
	assign cout = c[4];
endmodule