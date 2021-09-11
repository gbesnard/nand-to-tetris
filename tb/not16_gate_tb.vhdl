library ieee;
use ieee.std_logic_1164.all;

entity not16_gate_tb is
--  A testbench has no ports.
end not16_gate_tb;

architecture behaviour of not16_gate_tb is
	--  Declaration of the component that will be instantiated.
	component not16_gate
		port (
			in0 : in std_logic_vector(0 to 15); 
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for not16_gate_0: not16_gate use entity work.not16_gate;
	signal in0, out0 : std_logic_vector(0 to 15);

begin
	--  Component instantiation.
	not16_gate_0: not16_gate port map (
		in0 => in0, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the not16_gate.
			in0 : std_logic_vector(0 to 15);
			--  The expected outputs of the adder.
			out0 : std_logic_vector(0 to 15);
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			("0000000000000000", "1111111111111111"),
			("1111111111111111", "0000000000000000"),
			("1010101010101010", "0101010101010101"),
			("0011110011000011", "1100001100111100"),
			("0001001000110100", "1110110111001011")
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
