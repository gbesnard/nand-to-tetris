library ieee;
use ieee.std_logic_1164.all;

entity not16_gate is
	-- 16-bit Not:
 	-- for i=0..15: out0[i] = not in0[i]
	port (
		in0 : in std_logic_vector(0 to 15); 
		out0 : out std_logic_vector(0 to 15)
	);
end not16_gate;

architecture rtl of not16_gate is
    --  Declaration of the component that will be instantiated.
	component nand_gate
    port(
		in0 : in std_logic;
		in1 : in std_logic;
		out0 : out std_logic
	);
	end component;

	--  Specifies which entity is bound with the component.
    for nand_gate_0 : nand_gate use entity work.nand_gate;
    for nand_gate_1 : nand_gate use entity work.nand_gate;
    for nand_gate_2 : nand_gate use entity work.nand_gate;
    for nand_gate_3 : nand_gate use entity work.nand_gate;
    for nand_gate_4 : nand_gate use entity work.nand_gate;
    for nand_gate_5 : nand_gate use entity work.nand_gate;
    for nand_gate_6 : nand_gate use entity work.nand_gate;
    for nand_gate_7 : nand_gate use entity work.nand_gate;
    for nand_gate_8 : nand_gate use entity work.nand_gate;
    for nand_gate_9 : nand_gate use entity work.nand_gate;
    for nand_gate_10: nand_gate use entity work.nand_gate;
    for nand_gate_11: nand_gate use entity work.nand_gate;
    for nand_gate_12: nand_gate use entity work.nand_gate;
    for nand_gate_13: nand_gate use entity work.nand_gate;
    for nand_gate_14: nand_gate use entity work.nand_gate;
    for nand_gate_15: nand_gate use entity work.nand_gate;

begin
	nand_gate_0: nand_gate port map (
		in0 => in0(0), 
		in1 => in0(0), 
		out0 => out0(0)
	);

	nand_gate_1: nand_gate port map (
		in0 => in0(1), 
		in1 => in0(1), 
		out0 => out0(1)
	);

	nand_gate_2: nand_gate port map (
		in0 => in0(2), 
		in1 => in0(2), 
		out0 => out0(2)
	);

	nand_gate_3: nand_gate port map (
		in0 => in0(3), 
		in1 => in0(3), 
		out0 => out0(3)
	);

	nand_gate_4: nand_gate port map (
		in0 => in0(4), 
		in1 => in0(4), 
		out0 => out0(4)
	);

	nand_gate_5: nand_gate port map (
		in0 => in0(5), 
		in1 => in0(5), 
		out0 => out0(5)
	);

	nand_gate_6: nand_gate port map (
		in0 => in0(6), 
		in1 => in0(6), 
		out0 => out0(6)
	);

	nand_gate_7: nand_gate port map (
		in0 => in0(7), 
		in1 => in0(7), 
		out0 => out0(7)
	);

	nand_gate_8: nand_gate port map (
		in0 => in0(8), 
		in1 => in0(8), 
		out0 => out0(8)
	);

	nand_gate_9: nand_gate port map (
		in0 => in0(9), 
		in1 => in0(9), 
		out0 => out0(9)
	);

	nand_gate_10: nand_gate port map (
		in0 => in0(10), 
		in1 => in0(10), 
		out0 => out0(10)
	);

	nand_gate_11: nand_gate port map (
		in0 => in0(11), 
		in1 => in0(11), 
		out0 => out0(11)
	);

	nand_gate_12: nand_gate port map (
		in0 => in0(12), 
		in1 => in0(12), 
		out0 => out0(12)
	);

	nand_gate_13: nand_gate port map (
		in0 => in0(13), 
		in1 => in0(13), 
		out0 => out0(13)
	);

	nand_gate_14: nand_gate port map (
		in0 => in0(14), 
		in1 => in0(14), 
		out0 => out0(14)
	);

	nand_gate_15: nand_gate port map (
		in0 => in0(15), 
		in1 => in0(15), 
		out0 => out0(15)
	);

end rtl;
