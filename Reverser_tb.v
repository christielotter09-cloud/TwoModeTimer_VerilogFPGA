`timescale 1 ns / 100 ps    // Simulation timescale

module Reverser_tb;

	// Inputs
	reg [7:0] RevIn;
	reg ModeSel;
	reg [3:0] RevFromH;
	reg [3:0] RevFromL;

	// Output
	wire [7:0] RevOut;

	// Instantiate the Device Under Test (DUT)
	Reverser dut (
		RevIn,
		ModeSel,
		RevFromH,
		RevFromL,
		RevOut
	);


initial begin

	ModeSel = 0;
	RevFromH = 4'd2;
	RevFromL = 4'd9;
	RevIn = 8'h25;   // High = 2, Low = 5
	#10;
	RevIn = 8'h39;   // High = 3, Low = 9
	#10;


	ModeSel = 1;
	RevIn = 8'h25;   // Expect: (2 - 2, 9 - 5) = 00 04 = 0x04
	#10;
	RevIn = 8'h10;   // Expect: (2 - 1, 9 - 0) = 01 09 = 0x19
	#10;
	RevIn = 8'h00;   // Expect: (2 - 0, 9 - 0) = 02 09 = 0x29
	#10;
	RevIn = 8'h29;   // Expect: (2 - 2, 9 - 9) = 00 00 = 0x00
	#10;


$stop;
end

endmodule
