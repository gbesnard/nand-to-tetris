library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.std_logic_vector_to_string_package.all;

entity rom32k_tb is
--  A testbench has no ports.
end rom32k_tb;

architecture behaviour of rom32k_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component rom32k
		port (
			addr0 : in std_logic_vector(0 to 14);
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for rom32k_0: rom32k use entity work.rom32k;
	signal addr0 : std_logic_vector(0 to 14) := "000000000000000";
	signal out0 : std_logic_vector(0 to 15);	

begin
	--  Component instantiation.
	rom32k_0: rom32k port map (
		addr0 => addr0,
		out0 => out0
	);

	--  This process does the real job.
	process

		type pattern_type is record
			--  The inputs.
			addr0 : std_logic_vector(0 to 14);
			--  The expected outputs.
			out0 : std_logic_vector(0 to 15);
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  The patterns to apply.
		constant patterns : pattern_array :=
		(			
			("000000000000000", "0000000000000000"),
			("000000000000001", "0000000000000001"),
			("000000000000010", "0000000000000010"),
			("000000000000011", "0000000000000100"),
			("111111111111111", "0000000000000000")
		);			
		
	begin

		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			addr0 <= patterns(i).addr0;
			--  Wait for the results.
			wait for clk_period/4;
			--  Check the outputs.			
			assert out0 = patterns(i).out0			
			report "bad value for i = " & integer'image(i)
					& " out0 " & to_string(out0) & " instead of " & to_string(patterns(i).out0)
			severity error;
			--  Wait a block period.
			wait for clk_period/4;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
