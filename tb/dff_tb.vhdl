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
			--  The inputs.
			in0 : std_logic;
			--  The expected outputs.
			out0 : std_logic;
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(			
			('1', '0'),
			('1', '1'),
			('0', '1'),
			('0', '0'),
			('1', '0'),
			('1', '1'),
			('0', '1'),
			('0', '0')
		);
		
	begin
		-- Init
		in0 <= '0';
		wait for clk_period;

		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			in0 <= patterns(i).in0;			
			--  Check the outputs.			
			assert out0 = patterns(i).out0			
			report "bad value for i = " & integer'image(i)
					& " out0 " & std_logic'image(out0) & " instead of " & std_logic'image(patterns(i).out0)
			severity error;
			--  Wait a block period.
			wait for clk_period;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
