library ieee;
use ieee.std_logic_1164.all;

entity or8way_gate is
	-- 8-way Or:
	-- out0 = (in0[0] or in0[1] or ... or in0[7])
	port (
		in0 : in std_logic_vector(0 to 7); 
		out0 : out std_logic
	);
end or8way_gate;

architecture rtl of or8way_gate is
    	signal or1, or2, or3, or4, or5, or6 : std_logic;

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

begin
	or_gate_0: or_gate port map (
		in0 => in0(0), 
		in1 => in0(1), 
		out0 => or1
	);

	or_gate_1: or_gate port map (
		in0 => or1, 
		in1 => in0(2), 
		out0 => or2
	);

	or_gate_2: or_gate port map (
		in0 => or2, 
		in1 => in0(3), 
		out0 => or3
	);

	or_gate_3: or_gate port map (
		in0 => or3, 
		in1 => in0(4), 
		out0 => or4
	);

	or_gate_4: or_gate port map (
		in0 => or4, 
		in1 => in0(5), 
		out0 => or5
	);

	or_gate_5: or_gate port map (
		in0 => or5, 
		in1 => in0(6), 
		out0 => or6
	);

	or_gate_6: or_gate port map (
		in0 => or6, 
		in1 => in0(7), 
		out0 => out0
	);

end rtl;
