library ieee;
use ieee.std_logic_1164.all;

entity dff_tb is
--  A testbench has no ports.
end dff_tb;

architecture behaviour of dff_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.
	component dff
		port (
			in0 : in std_logic; 
			clk : in std_logic; 
			out0 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for dff_0: dff use entity work.dff;
	signal in0, clk, out0 : std_logic;

begin
	--  Component instantiation.
	dff_0: dff port map (
		in0 => in0, 
		clk => clk, 
		out0 => out0
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
		type pattern_type is record
			--  The inputs of the dff.
			in0 : std_logic;
			--  The expected outputs of the adder.
			out0 : std_logic;
		end record;

	begin
		in0 <= '1';
		wait for clk_period;
		--  Check the outputs.
		assert out0 = '1'
		report "bad value" severity error;
		wait for clk_period;

		in0 <= '0';
		--  Check the outputs.
		wait for clk_period;
		assert out0 = '0'
		report "bad value" severity error;

		in0 <= '1';
		wait for clk_period;
		--  Check the outputs.
		assert out0 = '1'
		report "bad value" severity error;
		wait for clk_period;

		in0 <= '0';
		--  Check the outputs.
		wait for clk_period;
		assert out0 = '0'
		report "bad value" severity error;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
