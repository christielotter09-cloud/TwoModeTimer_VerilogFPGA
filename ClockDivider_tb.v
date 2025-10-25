`timescale 1 ns / 100 ps 		

module ClockDivider_tb;

	reg CLK_50MHz;		
	reg rst_n;			
	wire CLK_100Hz;	 	
	wire CLK_1Hz;	
	
always begin
	#10;
	CLK_50MHz <= ~CLK_50MHz;
end

initial begin
	CLK_50MHz <= 0;
	rst_n <= 0;
	#50000;
	rst_n <= 1;
	#50000;
	rst_n <= 0;
	#50000;
	$stop;
end

ClockDivider dut(
	CLK_50MHz, 		
	rst_n, 			
	CLK_100Hz,	 	
	CLK_1Hz	
);

	
	
	
endmodule