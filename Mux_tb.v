`timescale 1 ns / 100 ps 		//modify the parameters accordingly

module Mux_tb;

	reg select;
	reg modeA100_clk;
	reg modeB1_clk;
	
	wire selected_clk;

Mux dut(

	select,
	modeA100_clk,
	modeB1_clk,
	
	selected_clk
	);


always begin 
#5 modeA100_clk<= ~modeA100_clk;
end
always begin
#50 modeB1_clk <= ~modeB1_clk;

end

initial begin
select <= 0;
modeA100_clk <= 0;
modeB1_clk <= 0;
#1000
select <= 1;
#1000
$stop;
end
endmodule