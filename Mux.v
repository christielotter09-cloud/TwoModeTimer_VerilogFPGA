module Mux(
	input select,
	input modeA100_clk,
	input modeB1_clk,
	
	output selected_clk
	);
	

assign selected_clk = (select) ? modeB1_clk : modeA100_clk;




endmodule