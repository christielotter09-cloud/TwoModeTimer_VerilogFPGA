`timescale 1 ns / 100 ps    // Simulation timescale

module DFlipFlop_tb;
reg D;
wire Q;
reg clk;
reg rst_n;



	DFlipFlop dut (
	D,
	Q,
	clk,
	rst_n

	);

	always begin
	#10 clk = ~clk;
	end

	initial begin
	clk = 0;
	rst_n = 0;
	D = 0;

	#15 rst_n = 1;     
	#10 D = 1;
	#20 D = 0;
	#20 D = 1;
	#10 rst_n = 0;     
	#10 rst_n = 1;   
	#20 D = 0;
	#20 D = 1;
	#30;

	$stop;
end

endmodule