library ieee;
use ieee.std_logic_1164.all;

entity half_adder_tb is
--  A testbench has no ports.
end half_adder_tb;

architecture behaviour of half_adder_tb is
	--  Declaration of the component that will be instantiated.
	component half_adder
		port (
			in0 : in std_logic;
			in1 : in std_logic;
			sum0 : out std_logic;
			carry0 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for half_adder_0: half_adder use entity work.half_adder;
	signal in0, in1, sum0, carry0 : std_logic;

begin
	--  Component instantiation.
	half_adder_0: half_adder port map (
		in0 => in0, 
		in1 => in1, 
		sum0 => sum0,
		carry0 => carry0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the and_gate.
			in0, in1 : std_logic;
			--  The expected outputs of the adder.
			sum0, carry0 : std_logic;
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			('0', '0', '0', '0'),
			('0', '1', '1', '0'),
			('1', '0', '1', '0'),
			('1', '1', '0', '1')
		);
	begin
		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			in0 <= patterns(i).in0;
			in1 <= patterns(i).in1;
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
