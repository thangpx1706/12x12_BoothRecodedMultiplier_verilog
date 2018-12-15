//===================================================================
// File Name	:  boothEn.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement booth Encoder module
//===================================================================

module boothEn (
    _y, _x, _2x, _neg
);
    input[2:0] _y;
    output _x, _2x, _neg;

    assign _x = _y[0] ^ _y[1];
    assign _2x = _y[2]?~(_y[1]|_y[0]):(_y[1]&_y[0]);
    assign _neg = _y[2];
    
endmodule


module boothEnNBits #(
    parameter NUMBER_OF_BITS = 12
)(
    _x, _y
);

    input [NUMBER_OF_BITS-1:0] _x;
    output [(NUMBER_OF_BITS/2)*3-1:0] _y;

    genvar i;
    generate 
        for(i=0;i<NUMBER_OF_BITS/2;i = i+1) begin
            if(i==0) 
                boothEn boothEncoder({_x[1:0],1'b0}, _y[2], _y[1], _y[0]);
            else 
                boothEn boothEncoder(_x[(i*2+1):(i*2-1)], _y[i*3+2], _y[i*3+1], _y[i*3]);
        end  
    endgenerate
    
endmodule
