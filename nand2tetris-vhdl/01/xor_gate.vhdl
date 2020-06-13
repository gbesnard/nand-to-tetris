library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
	-- Xr gate:
	-- out = not (in0 == in1)

	port (
		in0 : in std_logic; 
		in1 : in std_logic; 
		out0 : out std_logic
	);
end xor_gate;

architecture rtl of xor_gate is
	signal out_or : std_logic;
	signal out_nand : std_logic;

	--  Declaration of components that will be instantiated.
	component or_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	component and_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
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
	for or_gate_0: or_gate use entity work.or_gate;
	for nand_gate_0: nand_gate use entity work.nand_gate;
	for and_gate_0: and_gate use entity work.and_gate;

begin
	or_gate_0: or_gate port map (
		in0 => in0,
		in1 => in1,
		out0 => out_or
    	);

	nand_gate_0: nand_gate port map (
		in0 => in0,
		in1 => in1,
		out0 => out_nand
    	);

	and_gate_0: and_gate port map (
		in0 => out_or,
		in1 => out_nand,
		out0 => out0
    	);
end rtl;
