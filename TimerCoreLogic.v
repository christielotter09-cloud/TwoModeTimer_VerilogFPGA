module TimerCoreLogic (
	input [7:0] msb_loadval,
	input [7:0] msb_resetval,
	
	//input [7:0] lsb_loadval,
	input [7:0] lsb_loadval,
	input [7:0] lsb_resetval,
	input [7:0] msb_end,
	input [7:0] lsb_end,
	
	//input init_inc,
	input lsboverflow,
	input clk,				//Clock Signal (100Hz or 1Hz)
	input rst_n,			//Active-LOW reset signal
	input StartStop,		//A control signal to start (active) and stop (pause) the module

	output [7:0] LSBbinaryout,	//The Least Signaficant Bit (LSB) output signal in binary
	output [7:0] MSBbinaryout		//The Most Signaficant Bit (MSB) output signal in binary

);
					
reg load_once = 1;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        load_once <= 1;
    else if (StartStop)
        load_once <= 0; 
end



wire count_end = (MSBbinaryout == msb_end) && (LSBbinaryout == lsb_end);
wire IncStartStop = StartStop && rst_n && !count_end;  

wire msb_load = (load_once && StartStop && !count_end);  // only load at startup if not at end
wire lsb_load = (load_once && StartStop && !count_end) || (lsboverflow && !count_end);

wire msb_inc = IncStartStop && !msb_load && lsboverflow;
wire lsb_inc = IncStartStop && !msb_load ;
	
ProgramCounter LSB(
	clk,
	lsb_resetval,
	lsb_loadval,
	!rst_n,
	lsb_load,
	lsb_inc,
	
	LSBbinaryout
	
	

);

ProgramCounter MSB(
	clk,
	msb_resetval,
	msb_loadval,
	!rst_n,
	msb_load,
	msb_inc,
	
	MSBbinaryout

);
	

endmodule