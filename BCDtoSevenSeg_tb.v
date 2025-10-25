`timescale 1 ns / 100 ps    // Timescale for simulation

module BCDtoSevenSeg_tb;


reg [3:0] bcd;
wire [6:0] seg;


BCDtoSevenSeg dut (
.bcd(bcd),
.seg(seg)
);

integer i;

	initial begin

	for (i = 0; i <= 9; i = i + 1) begin
	bcd = i[3:0];
	#10;
	end


	for (i = 10; i <= 15; i = i + 1) begin
	bcd = i[3:0];
	#10;
	end

	$stop;
end

endmodule
