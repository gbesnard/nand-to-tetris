library ieee;
use ieee.std_logic_1164.all;
use work.virtual_registers_array_package.all;

entity computer_tb is
--  A testbench has no ports.
end computer_tb;

architecture behaviour of computer_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.
	component computer
		port (
			reset : in std_logic;
			clk : in std_logic;
			dbg_out_regs : out virtual_registers_array_t;
			dbg_out_pc : out std_logic_vector(0 to 15);
			dbg_out_d : out std_logic_vector(0 to 15);
			dbg_out_a : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for computer_0: computer use entity work.computer;
	signal reset, clk : std_logic;
	signal dbg_out_regs : virtual_registers_array_t;
	signal dbg_out_pc : std_logic_vector(0 to 15);
	signal dbg_out_d : std_logic_vector(0 to 15);
	signal dbg_out_a : std_logic_vector(0 to 15);

begin
	--  Component instantiation.
	computer_0: computer port map (
		reset => reset,
		clk => clk,
		dbg_out_regs => dbg_out_regs,
		dbg_out_pc => dbg_out_pc,
		dbg_out_d => dbg_out_d,
		dbg_out_a => dbg_out_a
	);

	-- Clock process definition.
	clk_process: process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

	--  This process does the real job.
	process
		
	begin
		-- Init
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		wait for clk_period;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
