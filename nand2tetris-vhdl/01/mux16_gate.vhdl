library ieee;
use ieee.std_logic_1164.all;

entity mux16_gate is
	-- 16-bit And:
 	-- for i=0..15: in0[i] if sel0 == 1
	--              in1[i] if sel0 == 1

	port (
		in0 : in std_logic_vector(0 to 15); 
		in1 : in std_logic_vector(0 to 15); 
		sel0 : in std_logic; 
		out0 : out std_logic_vector(0 to 15)
	);
end mux16_gate;

architecture rtl of mux16_gate is
    --  Declaration of the component that will be instantiated.
	component mux_gate
    	port(
		in0 : in std_logic;
		in1 : in std_logic;
		sel0 : in std_logic;
		out0 : out std_logic
	);
	end component;

	--  Specifies which entity is bound with the component.
	for mux_gate_0 : mux_gate use entity work.mux_gate;
	for mux_gate_1 : mux_gate use entity work.mux_gate;
	for mux_gate_2 : mux_gate use entity work.mux_gate;
	for mux_gate_3 : mux_gate use entity work.mux_gate;
	for mux_gate_4 : mux_gate use entity work.mux_gate;
	for mux_gate_5 : mux_gate use entity work.mux_gate;
	for mux_gate_6 : mux_gate use entity work.mux_gate;
	for mux_gate_7 : mux_gate use entity work.mux_gate;
	for mux_gate_8 : mux_gate use entity work.mux_gate;
	for mux_gate_9 : mux_gate use entity work.mux_gate;
	for mux_gate_10: mux_gate use entity work.mux_gate;
	for mux_gate_11: mux_gate use entity work.mux_gate;
	for mux_gate_12: mux_gate use entity work.mux_gate;
	for mux_gate_13: mux_gate use entity work.mux_gate;
	for mux_gate_14: mux_gate use entity work.mux_gate;
	for mux_gate_15: mux_gate use entity work.mux_gate;

begin
	mux_gate_0: mux_gate port map (
		in0 => in0(0), 
		in1 => in1(0), 
		sel0 => sel0, 
		out0 => out0(0)
	);

	mux_gate_1: mux_gate port map (
		in0 => in0(1), 
		in1 => in1(1), 
		sel0 => sel0, 
		out0 => out0(1)
	);

	mux_gate_2: mux_gate port map (
		in0 => in0(2), 
		in1 => in1(2), 
		sel0 => sel0, 
		out0 => out0(2)
	);

	mux_gate_3: mux_gate port map (
		in0 => in0(3), 
		in1 => in1(3), 
		sel0 => sel0, 
		out0 => out0(3)
	);

	mux_gate_4: mux_gate port map (
		in0 => in0(4), 
		in1 => in1(4), 
		sel0 => sel0, 
		out0 => out0(4)
	);

	mux_gate_5: mux_gate port map (
		in0 => in0(5), 
		in1 => in1(5), 
		sel0 => sel0, 
		out0 => out0(5)
	);

	mux_gate_6: mux_gate port map (
		in0 => in0(6), 
		in1 => in1(6), 
		sel0 => sel0, 
		out0 => out0(6)
	);

	mux_gate_7: mux_gate port map (
		in0 => in0(7), 
		in1 => in1(7), 
		sel0 => sel0, 
		out0 => out0(7)
	);

	mux_gate_8: mux_gate port map (
		in0 => in0(8), 
		in1 => in1(8), 
		sel0 => sel0, 
		out0 => out0(8)
	);

	mux_gate_9: mux_gate port map (
		in0 => in0(9), 
		in1 => in1(9), 
		sel0 => sel0, 
		out0 => out0(9)
	);

	mux_gate_10: mux_gate port map (
		in0 => in0(10), 
		in1 => in1(10), 
		sel0 => sel0, 
		out0 => out0(10)
	);

	mux_gate_11: mux_gate port map (
		in0 => in0(11), 
		in1 => in1(11), 
		sel0 => sel0, 
		out0 => out0(11)
	);

	mux_gate_12: mux_gate port map (
		in0 => in0(12), 
		in1 => in1(12), 
		sel0 => sel0, 
		out0 => out0(12)
	);

	mux_gate_13: mux_gate port map (
		in0 => in0(13), 
		in1 => in1(13), 
		sel0 => sel0, 
		out0 => out0(13)
	);

	mux_gate_14: mux_gate port map (
		in0 => in0(14), 
		in1 => in1(14), 
		sel0 => sel0, 
		out0 => out0(14)
	);

	mux_gate_15: mux_gate port map (
		in0 => in0(15), 
		in1 => in1(15), 
		sel0 => sel0, 
		out0 => out0(15)
	);

end rtl;
