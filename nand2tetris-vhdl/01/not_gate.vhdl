library ieee;
use ieee.std_logic_1164.all;

entity not_gate is
	-- Not gate:
	-- out0 = not in0
	port (
		in0 : in std_logic; 
		out0 : out std_logic
	);
end not_gate;

architecture rtl of not_gate is
    	--  Declaration of the component that will be instantiated.
	component nand_gate
    	port(
		in0 : in std_logic;
		in1 : in std_logic;
		out0 : out std_logic
	);
	end component;

	--  Specifies which entity is bound with the component.
    	for nand_gate_0: nand_gate use entity work.nand_gate;

begin
	nand_gate_0: nand_gate port map (
		in0 => in0,
		in1 => in0,
		out0 => out0
    	);
end rtl;
