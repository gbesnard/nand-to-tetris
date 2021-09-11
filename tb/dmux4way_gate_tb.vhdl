library ieee;
use ieee.std_logic_1164.all;

entity dmux4way_gate_tb is
--  A testbench has no ports.
end dmux4way_gate_tb;

architecture behaviour of dmux4way_gate_tb is
	--  Declaration of the component that will be instantiated.
	component dmux4way_gate
		port (
			in0 : in std_logic;
			sel0 : in std_logic_vector(0 to 1);
			out0 : out std_logic;
			out1 : out std_logic;
			out2 : out std_logic;
			out3 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for dmux4way_gate_0: dmux4way_gate use entity work.dmux4way_gate;
	signal in0, out0, out1, out2, out3 : std_logic;
	signal sel0 : std_logic_vector(0 to 1);

begin
	--  Component instantiation.
	dmux4way_gate_0: dmux4way_gate port map (
		in0 => in0, 
		sel0 => sel0, 
		out0 => out0,
		out1 => out1,
		out2 => out2,
		out3 => out3
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the dmux4way_gate.
			in0 : std_logic;
			sel0 : std_logic_vector(0 to 1);
			--  The expected outputs of the adder.
			out0 : std_logic;
			out1 : std_logic;
			out2 : std_logic;
			out3 : std_logic;
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			('0', "00", '0', '0', '0', '0'),
			('0', "01", '0', '0', '0', '0'),
			('0', "10", '0', '0', '0', '0'),
			('0', "11", '0', '0', '0', '0'),
			('1', "00", '1', '0', '0', '0'),
			('1', "01", '0', '1', '0', '0'),
			('1', "10", '0', '0', '1', '0'),
			('1', "11", '0', '0', '0', '1')
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

		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
