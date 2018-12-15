//===================================================================
// File Name	:  adder.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement full and half adder modules 
//===================================================================

module full_adder(a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;
    wire cout, sum;
    
    assign {cout, sum} = a + b + cin;
endmodule

module half_adder(a, b, c, s);

    input a, b;
    output c, s;
    wire c, s;
	
    assign {c, s} = a + b;
endmodule