library ieee;
use ieee.std_logic_1164.all;

entity and_gate is
	-- And gate:
	-- out0 = 1 if (in0 == 1 and in1 == 1)
	-- 0 otherwise

	port (
		in0 : in std_logic; 
		in1 : in std_logic; 
		out0 : out std_logic
	);
end and_gate;

architecture rtl of and_gate is
	signal out_nand_0 : std_logic;

    --  Declaration of components that will be instantiated.
	component nand_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	component not_gate
		port(
			in0 : in std_logic;
			out0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
    for not_gate_0: not_gate use entity work.not_gate;
    for nand_gate_0: nand_gate use entity work.nand_gate;

begin
	nand_gate_0: nand_gate port map (
        in0 => in0,
        in1 => in1,
        out0 => out_nand_0
    );

	not_gate_0: not_gate port map (
        in0 => out_nand_0,
        out0 => out0
    );

end rtl;
