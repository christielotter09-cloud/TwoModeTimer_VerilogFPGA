module Reverser (
	
	input [7:0] RevIn,	//The 8-bit BCD value input. Tips that is two 4-bit BCDs
	input ModeSel,			//Control signal to make the counting upwards RevIn to Counting downwards RevOut (HIGH) or pass the RevIn to the RevOut (LOW).
	input [3:0]RevFromH,
	input [3:0]RevFromL,

	output [7:0] RevOut	//the 8-bit BCD value out
	
);

wire [3:0] high_diff, low_diff;
assign high_diff = RevFromH - RevIn[7:4];
assign low_diff = RevFromL - RevIn[3:0];
assign RevOut = (!ModeSel) ? RevIn : {high_diff, low_diff};



endmodule