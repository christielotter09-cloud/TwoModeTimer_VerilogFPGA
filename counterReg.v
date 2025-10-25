module counterReg #(parameter BIT_SIZE = 1) (
	input [BIT_SIZE-1:0] D,
	output reg [BIT_SIZE-1:0] Q,
	input clk,
	input rst_n,
	input [BIT_SIZE-1:0] rst_val
	);
always @(posedge clk or negedge rst_n) begin
	if (~rst_n)
	Q <= rst_val;
	else
	Q <= D;
end
endmodule