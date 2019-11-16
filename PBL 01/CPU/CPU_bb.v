
module CPU (
	button_export,
	clk_clk,
	led_export,
	reset_reset_n);	

	input	[7:0]	button_export;
	input		clk_clk;
	output	[7:0]	led_export;
	input		reset_reset_n;
endmodule