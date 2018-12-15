//===================================================================
// File Name	:  ppCompressor.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement ppCompressor with Partial Product data
//===================================================================
`include "csa.v"

module ppCompressor_12(
    _PP, _Cor, _C, _S
);

    input[84:0] _PP;
    input[5:0] _Cor;
    output[23:0] _C, _S;
    
    wire[13:0] _C11, _S11, _C12, _S12;
    wire[11:0] _C21, _S21;
    wire[22:0] _C31;
    wire[23:0] _S31;

    wire[14:0] _pp0;
    wire[13:0] _pp1, _pp2, _pp3, _pp4, _pp5;

    assign _pp0 = _PP[14:0];
    assign _pp1 = _PP[28:15];
    assign _pp2 = _PP[42:29];
    assign _pp3 = _PP[56:43];
    assign _pp4 = _PP[70:57];
    assign _pp5 = _PP[84:71];

    // Stage 1
    CSA_fa #(12)   CSA_11({_pp0[14:4],_pp0[2]},{_pp1[12:2],_pp1[0]},{_pp2[10:0],_Cor[1]},{_S11[12:2],_S11[0]},{_C11[12:2],_C11[0]});
    CSA_ha #(2)    CSA_12({_pp1[13],_pp0[3]},{_pp2[11],_pp1[1]},{_S11[13],_S11[1]},{_C11[13],_C11[1]});

    CSA_fa #(11)   CSA_13({_pp3[13:4],_pp3[2]},{_pp4[11:2],_pp4[0]},{_pp5[9:0],_Cor[4]},{_S12[11:2],_S12[0]},{_C12[11:2],_C12[0]});
    CSA_ha #(3)    CSA_14({_pp4[13:12],_pp3[3]},{_pp5[11:10],_pp4[1]},{_S12[13:12],_S12[1]},{_C12[13:12],_C12[1]});

    // Stage 2
    CSA_fa #(12)   CSA_21({_pp2[13:12],_S11[13:4]},{_S12[9:0],_pp3[1:0]},{1'b0,_C11[13:4],_Cor[3]},_S21,_C21);

    // Stage 3
    CSA_ha #(12)   CSA_31({_pp5[12],_S12[13:10],_S21[11:5]},{_C12[13:10],_C21[11:4]},_S31[22:11],_C31[22:11]);
    CSA_ha #(5)    CSA_32({_S21[3:0],_S11[3]},{_C21[2:0],_C11[3:2]},_S31[9:5],_C31[9:5]);
    CSA_ha #(4)    CSA_33({_S11[1:0],_pp0[1:0]},{_C11[0],{2{1'b0}},_Cor[0]},_S31[3:0],_C31[3:0]);

    CSA_fa #(1)    CSA_34(_S21[4],_C21[3],_Cor[5],_S31[10],_C31[10]);
    CSA_fa #(1)    CSA_35(_S11[2],_C11[1],_Cor[2],_S31[4],_C31[4]);


    assign _S31[23] = _pp5[13];

    assign _C = {_C31,1'b0};
    assign _S = _S31;
endmodule