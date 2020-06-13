library ieee;
use ieee.std_logic_1164.all;

entity or16_gate_tb is
--  A testbench has no ports.
end or16_gate_tb;

architecture behaviour of or16_gate_tb is
	--  Declaration of the component that will be instantiated.
	component or16_gate
		port (
			in0 : in std_logic_vector(0 to 15); 
			in1 : in std_logic_vector(0 to 15); 
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for or16_gate_0: or16_gate use entity work.or16_gate;
	signal in0, in1, out0 : std_logic_vector(0 to 15);

begin
	--  Component instantiation.
	or16_gate_0: or16_gate port map (
		in0 => in0, 
		in1 => in1, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the or16_gate.
			in0 : std_logic_vector(0 to 15);
			in1 : std_logic_vector(0 to 15);
			--  The expected outputs of the adder.
			out0 : std_logic_vector(0 to 15);
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			("0000000000000000", "0000000000000000", "0000000000000000"),
			("0000000000000000", "1111111111111111", "1111111111111111"),
			("1111111111111111", "1111111111111111", "1111111111111111"),
			("1010101010101010", "0101010101010101", "1111111111111111"),
			("0011110011000011", "0000111111110000", "0011111111110011"),
			("0001001000110100", "1001100001110110", "1001101001110110")
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
			assert out0 = patterns(i).out0
			report "bad value" severity error;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
