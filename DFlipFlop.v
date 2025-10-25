module DFlipFlop(
	input D,
	output reg Q,
	input clk,
	input rst_n
);
always @(posedge clk or negedge rst_n) begin
	if (~rst_n)
	Q <= 1'b0;
	else
	Q <= D;
	end
endmodule