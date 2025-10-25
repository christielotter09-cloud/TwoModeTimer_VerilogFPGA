module MainCode (

	input CLK_50MHz,			//50MHz clock input
									//input CLK_100Hz, <--you can use this for your module ModeSim validation
									//input CLK_1Hz,	 <--you can use this for your module ModeSim validation
	input rst_n,				//An active-low sginal to reset the module
	input StartStop,			//A control signal to start (active) and stop (pause) the module
	input ModeSel,				//A control signal to swich between the two modes (10s stopwatch and 2 mins timer)				
	
	
	output [6:0] HexMSBH,	//The 7-Seg display Signal for higer-digit in MSB
	output [6:0] HexMSBL,	//The 7-Seg display Signal for lower-digit in MSB
	output [6:0] HexLSBH,	//The 7-Seg display Signal for higer-digit in LSB
	output [6:0] HexLSBL,	//The 7-Seg display Signal for lower-digit in LSB
	output DOT					//The flashing decimal signal at the lower-digit MSB	
);
wire CLK_100Hz, CLK_1Hz;
wire selected_clk;

wire [7:0] MSBbinaryout;
wire [7:0]LSBbinaryout;
ClockDivider divideClock(

	CLK_50MHz, 		//50MHz clock input
	rst_n, 			//Active-LOW reset signal
	
	CLK_100Hz,	 	//100Hz clock; You can tweak the output type accordingly.
	CLK_1Hz			//1Hz clock; You can tweak the output type accordingly.

);
Mux selectClock(
	ModeSel,
	CLK_100Hz,
	CLK_1Hz,
	
	selected_clk
	);

wire [7:0] msb_loadval, lsb_loadval, msb_end, lsb_end, msb_resetval, lsb_resetval;
wire msboverflow, lsboverflow;


assign msb_loadval = (ModeSel == 1'b0) ? 8'd0 : 8'd0;
assign lsb_loadval   = (ModeSel == 1'b0) ? 8'd0 : 8'd0;

assign msb_resetval  = (ModeSel == 1'b0) ? 8'd0 : 8'd0;
assign lsb_resetval  = (ModeSel == 1'b0) ? 8'd0 : 8'd0;

assign msb_end = (ModeSel == 1'b0) ? 8'd99 : 8'd1;
assign lsb_end = (ModeSel == 1'b0) ? 8'd99 : 8'd59;
assign lsboverflow   = (LSBbinaryout == lsb_end) ? 1'b1 : 1'b0;

//assign init_inc = (LSBbinaryout == 8'd1 && ModeSel == 1'b1 && MSBbinaryout ==8'd0) ? 1'b1 : 1'b0; 
TimerCoreLogic timerlog(
	msb_loadval,
	msb_resetval,
	lsb_loadval,
	lsb_resetval,
	msb_end,
	lsb_end,
	
	//init_inc,
	lsboverflow,
	selected_clk,				
	rst_n,			
	StartStop,		

	LSBbinaryout,	
	MSBbinaryout		
);
wire disp_end = (MSBbinaryout == msb_end) && (LSBbinaryout == lsb_end);
SevenSegEncoder encoder(
	
	LSBbinaryout,	//The LSB binary value input
	MSBbinaryout,	//The MSB bianry value input
	ModeSel,				//Control signal for the interal Reverser
	disp_end,
	HexMSBH,	
	HexMSBL,	
	HexLSBH,
	HexLSBL
	

);
reg DOT_reg = 0;
always @(posedge CLK_1Hz or negedge rst_n) begin
    if (!rst_n)
    DOT_reg <= 0;
    else if (!disp_end)
    DOT_reg <= ~DOT_reg;  // Toggle ever7 second
end
assign DOT = DOT_reg;
		

endmodule