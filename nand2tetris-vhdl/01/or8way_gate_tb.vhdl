library ieee;
use ieee.std_logic_1164.all;

entity or8way_gate_tb is
--  A testbench has no ports.
end or8way_gate_tb;

architecture behaviour of or8way_gate_tb is
	--  Declaration of the component that will be instantiated.
	component or8way_gate
		port (
			in0 : in std_logic_vector(0 to 7);
        	out0 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for or8way_gate_0: or8way_gate use entity work.or8way_gate;
	signal in0 : std_logic_vector(0 to 7);
	signal out0 : std_logic;

begin
	--  Component instantiation.
	or8way_gate_0: or8way_gate port map (
		in0 => in0, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the or8way_gate.
			in0 : std_logic_vector(0 to 7);
			--  The expected outputs of the adder.
			out0 : std_logic;
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			("00000000", '0'),
			("11111111", '1'),
			("00010000", '1'),
			("00000001", '1'),
			("00100110", '1')
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
			report "bad value" severity error;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
