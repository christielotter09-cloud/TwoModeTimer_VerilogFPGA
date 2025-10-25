module SevenSegEncoder (
	
	input [7:0] LSBBinary,	//The LSB binary value input
	input [7:0] MSBBinary,	//The MSB bianry value input
	input ModeSel,				//Control signal for the interal Reverser
	input disp_end,

	output [6:0] HexMSBH,	//The 7-Seg display Signal for higer-digit in MSB
	output [6:0] HexMSBL,	//The 7-Seg display Signal for lower-digit in MSB
	output [6:0] HexLSBH,	//The 7-Seg display Signal for higer-digit in LSB
	output [6:0] HexLSBL		//The 7-Seg display Signal for lower-digit in LSB


);
	
	wire[7:0] LSBrev, MSBrev;
	reg[3:0] MSBtens, MSBones, LSBtens, LSBones;
	always @ (*) begin 
	MSBtens = MSBBinary / 10; 
	MSBones = MSBBinary % 10; 
	
	LSBtens = LSBBinary /10; 
	LSBones = LSBBinary % 10; 
end
assign LSBrev = {LSBtens, LSBones};
assign MSBrev = {MSBtens, MSBones};

wire [7:0] MSBRevOut;
wire [7:0] LSBRevOut;

Reverser MSB(
	MSBrev,	
	ModeSel, 	
	4'd0, 
	4'd1, 
	MSBRevOut
);

Reverser LSB(
	LSBrev,	
	ModeSel, 	
	4'd5, //High rev from
	4'd9, //low rev from
	LSBRevOut
);
wire [3:0] MSBH = MSBRevOut[7:4];
wire [3:0] MSBL = MSBRevOut[3:0];
wire [3:0] LSBH = LSBRevOut[7:4];
wire [3:0] LSBL = LSBRevOut[3:0];

wire [6:0] reg_HexMSBH, reg_HexMSBL, reg_HexLSBH, reg_HexLSBL;

BCDtoSevenSeg disp_msbh (MSBH, reg_HexMSBH);
BCDtoSevenSeg disp_msbl (MSBL, reg_HexMSBL);
BCDtoSevenSeg disp_lsbh (LSBH, reg_HexLSBH);
BCDtoSevenSeg disp_lsbl (LSBL, reg_HexLSBL);


assign HexMSBH = (disp_end) ? 7'b0000110 : reg_HexMSBH; // E
assign HexMSBL = (disp_end) ? 7'b0101011 : reg_HexMSBL; // N
assign HexLSBH = (disp_end) ? 7'b0100001 : reg_HexLSBH; // D
assign HexLSBL = (disp_end) ? 7'b1111111 : reg_HexLSBL; 
	
	
	
	
endmodule