`timescale 1 ns / 100 ps 		//modify the parameters accordingly

module ProgramCounter_tb;

	reg clk;					
	reg [7:0] ResetVal;	
	reg [7:0] LoadVal;		
	reg reset;					
	reg load;					
	reg inc;					
	
	wire [7:0] PCoutput;	
	
always begin #10
 clk<= ~clk;
 
end

initial begin
ResetVal <= 8'd0;
LoadVal <= 8'd200;
clk <= 1'b0;

{reset,load, inc} = 3'b000; //No output value
#27;
{reset,load, inc} = 3'b010; //Load to 200
#20;
{reset,load, inc} = 3'b111; //Reset to 0 
#50;
{reset,load, inc} = 3'b010; //Load to 200
#20;
{reset,load, inc} = 3'b001; //Increment
#50;
{reset,load, inc}= 3'b011; //Back to 200
#5;
{reset,load, inc} = 3'b000;//Remain at 200
#27;
{reset,load, inc} = 3'b100;//Reset to 0
#33;

$stop;
end


ProgramCounter dut(
	clk,				
	ResetVal,	
	LoadVal,	
	reset,					
	load,					
	inc,					
	
	PCoutput
);	


endmodule