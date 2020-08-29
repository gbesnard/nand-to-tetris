library ieee;
use ieee.std_logic_1164.all;

library work;
use work.std_logic_vector_to_string_package.all;

entity inc16_tb is
--  A testbench has no ports.
end inc16_tb;

architecture behaviour of inc16_tb is
	--  Declaration of the component that will be instantiated.
	component inc16
		port (
			in0 : in std_logic_vector(0 to 15); 
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for inc16_0: inc16 use entity work.inc16;
	signal in0, out0 : std_logic_vector(0 to 15);

begin
	--  Component instantiation.
	inc16_0: inc16 port map (
		in0 => in0, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs.
			in0 : std_logic_vector(0 to 15);
			--  The expected outputs.
			out0 : std_logic_vector(0 to 15);
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			("0000000000000000", "1000000000000000"),
			("1111111111111111", "0000000000000000"),
			("1010000000000000", "0110000000000000"),
			("1101111111111111", "0011111111111111")
		);

	begin
		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			in0 <= patterns(i).in0;
			--  Wait for the results.
			wait for 1 ns;
			--  Check the outputs.
			assert out0 = patterns(i).out0
			report "bad value for i = " & integer'image(i) & 
			" for input in0 = " & to_string(in0) & 
			" and out0 = " & to_string(out0) &
			" instead of " & to_string(patterns(i).out0)

			severity error;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
