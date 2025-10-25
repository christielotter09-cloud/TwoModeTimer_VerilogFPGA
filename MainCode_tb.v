`timescale 1 ns / 100 ps 		

module MainCode_tb;



	reg CLK_50MHz;		
									
									
	reg rst_n;				
	reg StartStop;			
	reg ModeSel;								
	
	
	wire [6:0] HexMSBH;	
	wire [6:0] HexMSBL;	
	wire [6:0] HexLSBH;	
	wire [6:0] HexLSBL;	
	wire DOT;					
	
MainCode dut(


	CLK_50MHz,			
									
									
	rst_n,				
	StartStop,			
	ModeSel,								
	

	HexMSBH,	
	HexMSBL,	
	HexLSBH,	
	HexLSBL,	
	DOT								
	

);
always begin
	#10;
	CLK_50MHz <= ~CLK_50MHz;
end


initial begin
CLK_50MHz = 0;
ModeSel = 0;
rst_n = 0;
StartStop = 0;

#20 rst_n = 1; StartStop = 1;
#100000000;

StartStop = 0;
#20000000;
StartStop = 1;
#20000000;
rst_n = 0;
#5000;
rst_n = 1;
#50000000;

ModeSel = 1;
rst_n = 0; StartStop = 0; #10;
rst_n = 1; StartStop = 1;
#240000000;

StartStop = 0;
#20000000;
StartStop = 1;
#20000000;
rst_n = 0;
#10000;
rst_n = 1;

#50000000;
$stop;
end
endmodule