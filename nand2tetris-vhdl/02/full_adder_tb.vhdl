library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
--  A testbench has no ports.
end full_adder_tb;

architecture behaviour of full_adder_tb is
	--  Declaration of the component that will be instantiated.
	component full_adder
		port (
			in0 : in std_logic;
			in1 : in std_logic;
			in2 : in std_logic;
			sum0 : out std_logic;
			carry0 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for full_adder_0: full_adder use entity work.full_adder;
	signal in0, in1, in2, sum0, carry0 : std_logic;

begin
	--  Component instantiation.
	full_adder_0: full_adder port map (
		in0 => in0, 
		in1 => in1, 
		in2 => in2, 
		sum0 => sum0,
		carry0 => carry0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs.
			in0, in1, in2 : std_logic;
			--  The expected outputs.
			sum0, carry0 : std_logic;
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			('0', '0', '0', '0', '0'),
			('0', '0', '1', '1', '0'),
			('0', '1', '1', '0', '1'),
			('0', '1', '1', '0', '1'),
			('1', '0', '0', '1', '0'),
			('1', '0', '1', '0', '1'),
			('1', '1', '0', '0', '1'),
			('1', '1', '1', '1', '1')
		);
	begin
		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			in0 <= patterns(i).in0;
			in1 <= patterns(i).in1;
			in2 <= patterns(i).in2;
			--  Wait for the results.
			wait for 1 ns;
			--  Check the outputs.
			assert sum0 = patterns(i).sum0
			report "bad value" severity error;

			assert carry0 = patterns(i).carry0
			report "bad value" severity error;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
