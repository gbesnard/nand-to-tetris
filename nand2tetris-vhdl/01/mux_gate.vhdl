library ieee;
use ieee.std_logic_1164.all;

entity mux_gate is
	-- Mux gate:
	-- out = in0 if sel0 == 0
	-- in1 otherwise
	port (
		in0 : in std_logic; 
		in1 : in std_logic; 
		sel0 : in std_logic; 
		out0 : out std_logic
	);
end mux_gate;

architecture rtl of mux_gate is
	signal not_sel0 : std_logic;
	signal out_and0 : std_logic;
	signal out_and1 : std_logic;

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

	component not_gate
		port(
			in0 : in std_logic;
			out0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for not_gate_0: not_gate use entity work.not_gate;
	for and_gate_0: and_gate use entity work.and_gate;
	for and_gate_1: and_gate use entity work.and_gate;
	for or_gate_0: or_gate use entity work.or_gate;

begin
	not_gate_0: not_gate port map (
        	in0 => sel0,
        	out0 => not_sel0
	);

	and_gate_0: and_gate port map (
		in0 => in0,
        	in1 => not_sel0,
        	out0 => out_and0
	);

	and_gate_1: and_gate port map (
        	in0 => sel0,
		in1 => in1,
        	out0 => out_and1
    	);

	or_gate_0: or_gate port map (
        	in0 => out_and0,
        	in1 => out_and1,
        	out0 => out0
	);
end rtl;
