`timescale 1 ns / 100 ps 		//modify the parameters accordingly

module TimerCoreLogic_tb;

	reg [7:0] msb_loadval;
	reg [7:0] msb_resetval;
	
	reg [7:0] lsb_loadval;
	reg [7:0] lsb_resetval;	
	reg [7:0] msb_end;
	reg [7:0] lsb_end;


	reg lsboverflow;
	reg clk;			//Clock Signal (100Hz or 1Hz)
	reg rst_n;			//Active-LOW reset signal
	reg StartStop;		//A control signal to start (active) and stop (pause) the module

	wire [7:0] LSBbinaryout;	//The Least Signaficant Bit (LSB) output signal in binary
	wire [7:0] MSBbinaryout;		//The Most Signaficant Bit (MSB) output signal in binary

always begin 
#5 clk<= ~clk;
 
end
always @(*) begin
    lsboverflow = (LSBbinaryout == 8'd59);
    
end
initial begin
msb_loadval <= 8'd0;
lsb_loadval <=8'd0;
msb_resetval <= 8'd0;
lsb_resetval <= 8'd0;
msb_end <= 8'd2;
lsb_end <= 8'd0;
clk <= 1'b0;

{rst_n, StartStop} = 2'b10;
#5
{rst_n, StartStop} = 2'b11;
#40;
{rst_n, StartStop} = 2'b01;
#10;
{rst_n, StartStop} = 2'b11;
#1000;
{rst_n, StartStop} = 2'b01;
#20;
{rst_n, StartStop} = 2'b11;
#20;
{rst_n, StartStop} = 2'b10;
#20;
{rst_n, StartStop} = 2'b11;
#5000;
{rst_n, StartStop} = 2'b00;
#25;
$stop;
end

TimerCoreLogic dut(
	msb_loadval,
	msb_resetval,
	

	lsb_loadval,
	lsb_resetval,
	msb_end,
	lsb_end,



	lsboverflow,
	clk,			//Clock Signal (100Hz or 1Hz)
	rst_n,			//Active-LOW reset signal
	StartStop,		//A control signal to start (active) and stop (pause) the module

	LSBbinaryout,	//The Least Signaficant Bit (LSB) output signal in binary
	MSBbinaryout		//The Most Signaficant Bit (MSB) output signal in binary
	
);	






endmodule