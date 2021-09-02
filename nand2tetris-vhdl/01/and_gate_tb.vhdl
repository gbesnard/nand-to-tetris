library ieee;
use ieee.std_logic_1164.all;

entity and_gate_tb is
--  A testbench has no ports.
end and_gate_tb;

architecture behaviour of and_gate_tb is
	--  Declaration of the component that will be instantiated.
	component and_gate
		port (
			in0 : in std_logic; 
			in1 : in std_logic; 
			out0 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for and_gate_0: and_gate use entity work.and_gate;
	signal in0, in1, out0 : std_logic;

begin
	--  Component instantiation.
	and_gate_0: and_gate port map (
		in0 => in0, 
		in1 => in1, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the and_gate.
			in0, in1 : std_logic;
			--  The expected outputs of the adder.
			out0 : std_logic;
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			('0', '0', '0'),
			('0', '1', '0'),
			('1', '0', '0'),
			('1', '1', '1')
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
