library ieee;
use ieee.std_logic_1164.all;

entity dmux_gate is
	-- Demultiplexor gate:
	-- {out0, out1} = {in0, 0} if sel0 == 0
	-- {0, in0} if sel0 == 1

	port (
		in0 : in std_logic; 
		sel0 : in std_logic; 
		out0 : out std_logic;
		out1 : out std_logic
	);
end dmux_gate;

architecture rtl of dmux_gate is
	signal not_sel0 : std_logic;

    --  Declaration of components that will be instantiated.
	component and_gate
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
	for and_gate_0: and_gate use entity work.and_gate;
	for not_gate_0: not_gate use entity work.not_gate;
	for and_gate_1: and_gate use entity work.and_gate;

begin
	and_gate_0: and_gate port map (
        	in0 => in0,
        	in1 => sel0,
        	out0 => out1
	);

	not_gate_0: not_gate port map (
        	in0 => sel0,
        	out0 => not_sel0
    	);

	and_gate_1: and_gate port map (
        	in0 => in0,
        	in1 => not_sel0,
        	out0 => out0
    	);
end rtl;
