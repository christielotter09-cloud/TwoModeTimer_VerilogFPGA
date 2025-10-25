module ClockDivider (
input CLK_50MHz,        // 50MHz clock input
input rst_n,            // Active-LOW reset signal

output CLK_100Hz,       // 100Hz clock
output CLK_1Hz          // 1Hz clock
);

wire [24:0] counter_1Hz;
wire [24:0] next_counter_1Hz;

wire [17:0] next_counter_100Hz;
wire [17:0] counter_100Hz;
wire counter_1Hz_max;

wire counter_100Hz_max;

wire next_CLK_1Hz;

wire next_CLK_100Hz;

wire clk_1Hz_reg; //ff output, assigns moduke output
wire clk_100Hz_reg;

	// Outputs
	assign CLK_1Hz = clk_1Hz_reg;
	assign CLK_100Hz = clk_100Hz_reg;

	// Assign toggle values
	assign counter_1Hz_max = (counter_1Hz == 25'd24999999); // 24,999,999 for 1Hz
	assign counter_100Hz_max = (counter_100Hz == 18'd249999); // 249,999 for 100Hz
	assign next_counter_1Hz = counter_1Hz_max ? 25'd0 : counter_1Hz + 25'd1;
	assign next_counter_100Hz = counter_100Hz_max ? 18'd0 : counter_100Hz + 18'd1;

	counterReg #(25) counter_1Hz_reg (
		next_counter_1Hz,
		counter_1Hz,
		CLK_50MHz,
		rst_n,
		25'd0
	);
	counterReg #(18) counter_100Hz_reg (
		next_counter_100Hz,
		counter_100Hz,
		CLK_50MHz,
		rst_n,
		18'd0
	);
	
	// toggle logic
	assign next_CLK_1Hz = counter_1Hz_max ? ~clk_1Hz_reg : clk_1Hz_reg;
	assign next_CLK_100Hz = counter_100Hz_max ? ~clk_100Hz_reg : clk_100Hz_reg;

	DFlipFlop dff_1Hz (
		next_CLK_1Hz,
		clk_1Hz_reg,
		CLK_50MHz,
		rst_n
	);

	// 100Hz clock output flip-flop
	DFlipFlop dff_100Hz (
		next_CLK_100Hz,
		clk_100Hz_reg,
		CLK_50MHz,
		rst_n
	);

endmodule
