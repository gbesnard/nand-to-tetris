library ieee;
use ieee.std_logic_1164.all;

entity mux4way16_gate is
	-- 4-way 16-bit multiplexor:
	-- out0 = in0 if sel == 00
	--        in1 if sel == 01
	--        in2 if sel == 10
	--        in3 if sel == 11

	port (
		in0 : in std_logic_vector(0 to 15); 
		in1 : in std_logic_vector(0 to 15); 
		in2 : in std_logic_vector(0 to 15); 
		in3 : in std_logic_vector(0 to 15); 
		sel0 : in std_logic_vector(0 to 1); 
		out0 : out std_logic_vector(0 to 15)
	);
end mux4way16_gate;

architecture rtl of mux4way16_gate is
	signal out_mux_in0_in1 : std_logic_vector(0 to 15);
	signal out_mux_in2_in3 : std_logic_vector(0 to 15);

	--  Declaration of the component that will be instantiated.
	component mux16_gate
	port(
		in0 : in std_logic_vector(0 to 15);
		in1 : in std_logic_vector(0 to 15);
		sel0 : in std_logic;
		out0 : out std_logic_vector(0 to 15)
	);
	end component;

	--  Specifies which entity is bound with the component.
	for mux16_gate_0 : mux16_gate use entity work.mux16_gate;
	for mux16_gate_1 : mux16_gate use entity work.mux16_gate;
	for mux16_gate_2 : mux16_gate use entity work.mux16_gate;

begin
	mux16_gate_0: mux16_gate port map (
		in0 => in0, 
		in1 => in1, 
		sel0 => sel0(0), 
		out0 => out_mux_in0_in1
	);

	mux16_gate_1: mux16_gate port map (
		in0 => in2, 
		in1 => in3, 
		sel0 => sel0(0), 
		out0 => out_mux_in2_in3
	);

	mux16_gate_2: mux16_gate port map (
		in0 => out_mux_in0_in1, 
		in1 => out_mux_in2_in3, 
		sel0 => sel0(1), 
		out0 => out0
	);

end rtl;
