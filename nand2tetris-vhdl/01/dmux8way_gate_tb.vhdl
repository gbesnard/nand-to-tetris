library ieee;
use ieee.std_logic_1164.all;

entity dmux8way_gate_tb is
--  A testbench has no ports.
end dmux8way_gate_tb;

architecture behaviour of dmux8way_gate_tb is
	--  Declaration of the component that will be instantiated.
	component dmux8way_gate
		port (
			in0 : in std_logic; 
			sel0 : in std_logic_vector(0 to 2);
			out0 : out std_logic;
			out1 : out std_logic;
			out2 : out std_logic;
			out3 : out std_logic;
			out4 : out std_logic;
			out5 : out std_logic;
			out6 : out std_logic;
			out7 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for dmux8way_gate_0: dmux8way_gate use entity work.dmux8way_gate;
	signal in0, out0, out1, out2, out3, out4, out5, out6, out7 : std_logic;
	signal sel0 : std_logic_vector(0 to 2);

begin
	--  Component instantiation.
	dmux8way_gate_0: dmux8way_gate port map (
		in0 => in0, 
		sel0 => sel0, 
		out0 => out0,
		out1 => out1,
		out2 => out2,
		out3 => out3,
		out4 => out4,
		out5 => out5,
		out6 => out6,
		out7 => out7
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the dmux8way_gate.
			in0 : std_logic;
			sel0 : std_logic_vector(0 to 2);
			--  The expected outputs of the adder.
			out0 : std_logic;
			out1 : std_logic;
			out2 : std_logic;
			out3 : std_logic;
			out4 : std_logic;
			out5 : std_logic;
			out6 : std_logic;
			out7 : std_logic;
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			('0', "000", '0', '0', '0', '0', '0', '0', '0', '0'),
			('0', "001", '0', '0', '0', '0', '0', '0', '0', '0'),
			('0', "010", '0', '0', '0', '0', '0', '0', '0', '0'),
			('0', "011", '0', '0', '0', '0', '0', '0', '0', '0'),
			('0', "100", '0', '0', '0', '0', '0', '0', '0', '0'),
			('0', "101", '0', '0', '0', '0', '0', '0', '0', '0'),
			('0', "110", '0', '0', '0', '0', '0', '0', '0', '0'),
			('0', "111", '0', '0', '0', '0', '0', '0', '0', '0'),
			('1', "000", '1', '0', '0', '0', '0', '0', '0', '0'),
			('1', "001", '0', '1', '0', '0', '0', '0', '0', '0'),
			('1', "010", '0', '0', '1', '0', '0', '0', '0', '0'),
			('1', "011", '0', '0', '0', '1', '0', '0', '0', '0'),
			('1', "100", '0', '0', '0', '0', '1', '0', '0', '0'),
			('1', "101", '0', '0', '0', '0', '0', '1', '0', '0'),
			('1', "110", '0', '0', '0', '0', '0', '0', '1', '0'),
			('1', "111", '0', '0', '0', '0', '0', '0', '0', '1')
		);

	begin
		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			in0 <= patterns(i).in0;
			sel0 <= patterns(i).sel0;
			--  Wait for the results.
			wait for 1 ns;
			--  Check the outputs.
			assert out0 = patterns(i).out0
			report "bad value" severity error;

			assert out1 = patterns(i).out1
			report "bad value" severity error;

			assert out2 = patterns(i).out2
			report "bad value" severity error;

			assert out3 = patterns(i).out3
			report "bad value" severity error;

			assert out4 = patterns(i).out4
			report "bad value" severity error;

			assert out5 = patterns(i).out5
			report "bad value" severity error;

			assert out6 = patterns(i).out6
			report "bad value" severity error;

			assert out6 = patterns(i).out6
			report "bad value" severity error;

		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
