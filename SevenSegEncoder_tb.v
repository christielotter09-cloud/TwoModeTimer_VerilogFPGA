`timescale 1 ns / 100 ps 		//modify the parameters accordingly


module SevenSegEncoder_tb;

    reg [7:0] LSBBinary;
    reg [7:0] MSBBinary;
    reg ModeSel;
	 reg disp_end;
    wire [6:0] HexMSBH, HexMSBL, HexLSBH, HexLSBL;


    SevenSegEncoder dut (
        LSBBinary,
        MSBBinary,
        ModeSel,
		  disp_end,
      
        
        HexMSBH,
        HexMSBL,
        HexLSBH,
        HexLSBL
		
    );

    integer i;

    initial begin
        ModeSel = 0;
       disp_end = 0;
        
        for (i = 0; i <= 15; i = i + 1) begin
            LSBBinary = i;
            MSBBinary = 8'd0;  // Hold MSB constant for now
            #10;
        end

        // ModeSel = 1 (reverser on)
				ModeSel = 1;

        for (i = 0; i <= 15; i = i + 1) begin
            LSBBinary = i;
            MSBBinary = 8'd2;
            #10;
        end
		//End display
        ModeSel = 1;
			disp_end = 1;
        for (i = 0; i <= 15; i = i + 1) begin
            LSBBinary = i;
            MSBBinary = 8'd2;
            #10;
        end

        $stop;
    end

endmodule
