library ieee;
use ieee.std_logic_1164.all;

entity not_gate_tb is
--  A testbench has no ports.
end not_gate_tb;

architecture behaviour of not_gate_tb is
	--  Declaration of the component that will be instantiated.
	component not_gate
		port (
			in0 : in std_logic; 
			out0 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for not_gate_0: not_gate use entity work.not_gate;
	signal in0, out0 : std_logic;

begin
	--  Component instantiation.
	not_gate_0: not_gate port map (
		in0 => in0, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the not_gate.
			in0 : std_logic;
			--  The expected outputs of the adder.
			out0 : std_logic;
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			('0', '1'),
			('1', '0')
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
