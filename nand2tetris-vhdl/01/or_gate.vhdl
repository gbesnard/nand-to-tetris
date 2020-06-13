library ieee;
use ieee.std_logic_1164.all;

entity or_gate is
	-- Or gate:
	-- out = 1 if (in0 == 1 or in1 == 1)
	-- 0 otherwise

	port (
		in0 : in std_logic; 
		in1 : in std_logic; 
		out0 : out std_logic
	);
end or_gate;

architecture rtl of or_gate is
	signal not_a : std_logic;
	signal not_b : std_logic;

	--  Declaration of components that will be instantiated.
	component not_gate
		port(
			in0 : in std_logic;
			out0 : out std_logic
		);
	end component;


	component nand_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for not_gate_0: not_gate use entity work.not_gate;
	for not_gate_1: not_gate use entity work.not_gate;
	for nand_gate_0: nand_gate use entity work.nand_gate;

begin
	not_gate_0: not_gate port map (
        	in0 => in0,
        	out0 => not_a
	);

	not_gate_1: not_gate port map (
		in0 => in1,
		out0 => not_b
	);

	nand_gate_0: nand_gate port map (
		in0 => not_a,
		in1 => not_b,
		out0 => out0
	);
end rtl;
