	component CPU is
		port (
			button_export : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			clk_clk       : in  std_logic                    := 'X';             -- clk
			led_export    : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n : in  std_logic                    := 'X'              -- reset_n
		);
	end component CPU;

	u0 : component CPU
		port map (
			button_export => CONNECTED_TO_button_export, -- button.export
			clk_clk       => CONNECTED_TO_clk_clk,       --    clk.clk
			led_export    => CONNECTED_TO_led_export,    --    led.export
			reset_reset_n => CONNECTED_TO_reset_reset_n  --  reset.reset_n
		);

