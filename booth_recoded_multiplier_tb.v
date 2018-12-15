//===================================================================
// File Name	:  booth_recoded_multiplier_tb.v
// Project Name	:  12x12 bit Booth Recoded Multiplier 
// Create Date	:  2018/12/12
// Author		:  Pham Xuan Thang
// Description	:  Implement testbench for booth_recorded_multiplier module
//===================================================================

`timescale 1ns / 1ps
`include "booth_recoded_multiplier.v"

module booth_recoded_multiplier_tb();
	// Inputs
	reg clk;
	reg reset;
	reg [11:0] multiplicand;
	reg [11:0] multiplier;
	// Outputs
	wire [23:0] prod;
	// Instantiate the Unit Under Test (UUT)
	booth_recoded_multiplier uut (
		.clk(clk), 
		.reset(reset), 
		.multiplicand(multiplicand), 
		.multiplier(multiplier), 
		.prod(prod)
	);
	initial begin
		// Initialize Inputs
		clk = 0; 
		reset = 1;
		multiplicand = 0;  
		multiplier = 0;
		#5	reset = 0;
	end	
	
	initial begin
		//Case 1: multiplicand = 25;  multiplier = 15;
		#8 multiplicand = 25;  multiplier = 15;
		//Case 2: multiplicand = -30;  multiplier = -40;
		#8 multiplicand = -30;  multiplier = -40;					
		//Case 3: multiplicand = -25;  multiplier = 30;
		#8 multiplicand = -25;  multiplier = 30;	
		//Case 4: multiplicand = 30;  multiplier = -15;
		#8 multiplicand = 30;  multiplier = -15;					
		//Case 5: multiplicand = 100;  multiplier = 3;
		#8 multiplicand = 100;  multiplier = 3;
		//Case 6: multiplicand = 80;  multiplier = -56;
		#8 multiplicand = 80;  multiplier = -56;
		//finish
		#8 $finish;
	end

	always @(*) begin
		#4 clk = ~clk;
	end

   initial begin
     $monitor("time %3d: %12b %12b %24b",$time,multiplicand,multiplier,prod);
   end
endmodule

