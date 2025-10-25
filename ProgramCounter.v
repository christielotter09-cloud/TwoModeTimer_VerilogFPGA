module ProgramCounter (
	
	input clk,					//Clock Signal (100Hz or 1Hz)
	input [7:0] ResetVal,	//input value to update the PC wehn load is active
	input [7:0] LoadVal,		//input value to update the PC when reset is active
	input reset,					//An active-high singal to rest the PC (exectute without clk)
	input load,					//An active-high signal to load value in PC (function activated with clk)
	input inc,					//An active-high singal to start the counting
	
	output reg [7:0] PCoutput	//PC output signal in binary

);


always @(posedge clk or posedge reset) begin
	if (reset) begin
		PCoutput <= ResetVal;
	end else if (load) begin
		PCoutput <= LoadVal;
	end else if (inc) begin
		PCoutput <= PCoutput + 1;
	end 
end
	
	
endmodule