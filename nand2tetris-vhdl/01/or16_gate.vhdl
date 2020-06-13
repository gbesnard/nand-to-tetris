library ieee;
use ieee.std_logic_1164.all;

entity or16_gate is
	-- 16-bit Or:
 	-- for i=0..15: out0[i] = (in0[i] or in1[i])

	port (
		in0 : in std_logic_vector(0 to 15); 
		in1 : in std_logic_vector(0 to 15); 
		out0 : out std_logic_vector(0 to 15)
	);
end or16_gate;

architecture rtl of or16_gate is
    --  Declaration of the component that will be instantiated.
	component or_gate
    	port(
		in0 : in std_logic;
		in1 : in std_logic;
		out0 : out std_logic
	);
	end component;

	--  Specifies which entity is bound with the component.
	for or_gate_0 : or_gate use entity work.or_gate;
	for or_gate_1 : or_gate use entity work.or_gate;
	for or_gate_2 : or_gate use entity work.or_gate;
	for or_gate_3 : or_gate use entity work.or_gate;
	for or_gate_4 : or_gate use entity work.or_gate;
	for or_gate_5 : or_gate use entity work.or_gate;
	for or_gate_6 : or_gate use entity work.or_gate;
	for or_gate_7 : or_gate use entity work.or_gate;
	for or_gate_8 : or_gate use entity work.or_gate;
	for or_gate_9 : or_gate use entity work.or_gate;
	for or_gate_10: or_gate use entity work.or_gate;
	for or_gate_11: or_gate use entity work.or_gate;
	for or_gate_12: or_gate use entity work.or_gate;
	for or_gate_13: or_gate use entity work.or_gate;
	for or_gate_14: or_gate use entity work.or_gate;
	for or_gate_15: or_gate use entity work.or_gate;

begin
	or_gate_0: or_gate port map (
		in0 => in0(0), 
		in1 => in1(0), 
		out0 => out0(0)
	);

	or_gate_1: or_gate port map (
		in0 => in0(1), 
		in1 => in1(1), 
		out0 => out0(1)
	);

	or_gate_2: or_gate port map (
		in0 => in0(2), 
		in1 => in1(2), 
		out0 => out0(2)
	);

	or_gate_3: or_gate port map (
		in0 => in0(3), 
		in1 => in1(3), 
		out0 => out0(3)
	);

	or_gate_4: or_gate port map (
		in0 => in0(4), 
		in1 => in1(4), 
		out0 => out0(4)
	);

	or_gate_5: or_gate port map (
		in0 => in0(5), 
		in1 => in1(5), 
		out0 => out0(5)
	);

	or_gate_6: or_gate port map (
		in0 => in0(6), 
		in1 => in1(6), 
		out0 => out0(6)
	);

	or_gate_7: or_gate port map (
		in0 => in0(7), 
		in1 => in1(7), 
		out0 => out0(7)
	);

	or_gate_8: or_gate port map (
		in0 => in0(8), 
		in1 => in1(8), 
		out0 => out0(8)
	);

	or_gate_9: or_gate port map (
		in0 => in0(9), 
		in1 => in1(9), 
		out0 => out0(9)
	);

	or_gate_10: or_gate port map (
		in0 => in0(10), 
		in1 => in1(10), 
		out0 => out0(10)
	);

	or_gate_11: or_gate port map (
		in0 => in0(11), 
		in1 => in1(11), 
		out0 => out0(11)
	);

	or_gate_12: or_gate port map (
		in0 => in0(12), 
		in1 => in1(12), 
		out0 => out0(12)
	);

	or_gate_13: or_gate port map (
		in0 => in0(13), 
		in1 => in1(13), 
		out0 => out0(13)
	);

	or_gate_14: or_gate port map (
		in0 => in0(14), 
		in1 => in1(14), 
		out0 => out0(14)
	);

	or_gate_15: or_gate port map (
		in0 => in0(15), 
		in1 => in1(15), 
		out0 => out0(15)
	);

end rtl;
