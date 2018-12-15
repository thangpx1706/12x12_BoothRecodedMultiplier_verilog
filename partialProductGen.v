//===================================================================
// File Name	:  partialProductGen.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement Partial Product Generator module
//===================================================================
module ppGenNBits #(
    parameter NUMBER_OF_BITS = 12
)(
    _boothEn, _xin, _pp, _corBits
);

    input[(NUMBER_OF_BITS/2)*3-1:0] _boothEn;
    input[NUMBER_OF_BITS-1:0] _xin;

    output[(NUMBER_OF_BITS/2)*(NUMBER_OF_BITS+2):0] _pp;
    output[NUMBER_OF_BITS/2-1:0] _corBits;

    wire[(NUMBER_OF_BITS/2)*(NUMBER_OF_BITS+1)-1:0] _ppBuff;

    genvar i;
    generate
        for(i=0;i<NUMBER_OF_BITS/2;i=i+1) begin
            ppLineGenNBits #(NUMBER_OF_BITS) ppLine(_boothEn[(i+1)*3-1:i*3],_xin,_ppBuff[(i+1)*(NUMBER_OF_BITS+1)-1:i*(NUMBER_OF_BITS+1)]);
            if(i==0) begin
                assign _pp[NUMBER_OF_BITS+2:0] = {~_ppBuff[NUMBER_OF_BITS],_ppBuff[NUMBER_OF_BITS],_ppBuff[NUMBER_OF_BITS:0]};
            end
            else begin
                assign _pp[(i+1)*(NUMBER_OF_BITS+2):i*(NUMBER_OF_BITS+2)+1] = {1'b1,~_ppBuff[(i+1)*(NUMBER_OF_BITS+1)-1],_ppBuff[(i+1)*(NUMBER_OF_BITS+1)-2:i*(NUMBER_OF_BITS+1)]};
            end
            assign _corBits[i] = _boothEn[i*3];
        end
    endgenerate
    
endmodule

// partial product line generator for N bits
module ppLineGenNBits #(
    parameter NUMBER_OF_BITS = 12
)(
    _boothEn, _xin, _pp
);
    input[2:0] _boothEn;
    input[NUMBER_OF_BITS-1:0] _xin;

    output[NUMBER_OF_BITS:0] _pp;

    genvar i;
    generate
        for (i=0;i<=NUMBER_OF_BITS;i=i+1) begin
            if(i==NUMBER_OF_BITS)
                ppGenerator ppGen({2{_xin[i-1]}},_boothEn,_pp[i]);
            else begin
                if(i==0)
                    ppGenerator ppGen({_xin[i],1'b0},_boothEn,_pp[i]);
                else
                    ppGenerator ppGen(_xin[i:i-1],_boothEn,_pp[i]);
            end
        end
    endgenerate
endmodule

// partial product generator component
module ppGenerator(
    _xin, _be, _pp
);

    input[1:0] _xin;
    input[2:0] _be;

    output _pp;

    assign temp1 = _be[2] & _xin[1];
    assign temp2 = _be[1] & _xin[0];
    assign temp = temp1 | temp2;
    assign _pp = temp ^ _be[0];
    
endmodule


