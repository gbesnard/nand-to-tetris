library ieee;
use ieee.std_logic_1164.all;

entity mux4way16_gate_tb is
--  A testbench has no ports.
end mux4way16_gate_tb;

architecture behaviour of mux4way16_gate_tb is
	--  Declaration of the component that will be instantiated.
	component mux4way16_gate
		port (
			in0 : in std_logic_vector(0 to 15);
			in1 : in std_logic_vector(0 to 15);
			in2 : in std_logic_vector(0 to 15);
			in3 : in std_logic_vector(0 to 15);
			sel0 : in std_logic_vector(0 to 1);
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for mux4way16_gate_0: mux4way16_gate use entity work.mux4way16_gate;
	signal in0, in1, in2, in3, out0 : std_logic_vector(0 to 15);
	signal sel0 : std_logic_vector(0 to 1);

begin
	--  Component instantiation.
	mux4way16_gate_0: mux4way16_gate port map (
		in0 => in0, 
		in1 => in1, 
		in2 => in2, 
		in3 => in3, 
		sel0 => sel0, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the mux4way16_gate.
			in0 : std_logic_vector(0 to 15);
			in1 : std_logic_vector(0 to 15);
			in2 : std_logic_vector(0 to 15);
			in3 : std_logic_vector(0 to 15);
			sel0 : std_logic_vector(0 to 1);
			--  The expected outputs of the adder.
			out0 : std_logic_vector(0 to 15);
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "00", "0000000000000000"),
			("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "01", "0000000000000000"),
			("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "10", "0000000000000000"),
			("0000000000000000", "0000000000000000", "0000000000000000", "0000000000000000", "11", "0000000000000000"),
			("0001001000110100", "1001100001110110", "1010101010101010", "0101010101010101", "00", "0001001000110100"),
			("0001001000110100", "1001100001110110", "1010101010101010", "0101010101010101", "01", "1010101010101010"),
			("0001001000110100", "1001100001110110", "1010101010101010", "0101010101010101", "10", "1001100001110110"),
			("0001001000110100", "1001100001110110", "1010101010101010", "0101010101010101", "11", "0101010101010101")
		);

	begin
		--  Check each pattern.
		for i in patterns'range loop

			--  Set the inputs.
			in0 <= patterns(i).in0;
			in1 <= patterns(i).in1;
			in2 <= patterns(i).in2;
			in3 <= patterns(i).in3;
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
