library ieee;
use ieee.std_logic_1164.all;

entity mux16_gate_tb is
--  A testbench has no ports.
end mux16_gate_tb;

architecture behaviour of mux16_gate_tb is
	--  Declaration of the component that will be instantiated.
	component mux16_gate
		port (
			in0 : in std_logic_vector(0 to 15); 
			in1 : in std_logic_vector(0 to 15); 
			sel0 : in std_logic;
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for mux16_gate_0: mux16_gate use entity work.mux16_gate;
	signal in0, in1, out0 : std_logic_vector(0 to 15);
	signal sel0 : std_logic;

begin
	--  Component instantiation.
	mux16_gate_0: mux16_gate port map (
		in0 => in0, 
		in1 => in1, 
		sel0 => sel0, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the mux16_gate.
			in0 : std_logic_vector(0 to 15);
			in1 : std_logic_vector(0 to 15);
			sel0 : std_logic;
			--  The expected outputs of the adder.
			out0 : std_logic_vector(0 to 15);
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			("0000000000000000", "0000000000000000", '0', "0000000000000000"),
			("0000000000000000", "0000000000000000", '1', "0000000000000000"),

			("0000000000000000", "0001001000110100", '0', "0000000000000000"),
			("0000000000000000", "0001001000110100", '1', "0001001000110100"),

			("1001100001110110", "0000000000000000", '0', "1001100001110110"),
			("1001100001110110", "0000000000000000", '1', "0000000000000000"),

			("1010101010101010", "0101010101010101", '0', "1010101010101010"),
			("1010101010101010", "0101010101010101", '1', "0101010101010101")
		);

	begin
		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			in0 <= patterns(i).in0;
			in1 <= patterns(i).in1;
			sel0 <= patterns(i).sel0;
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
