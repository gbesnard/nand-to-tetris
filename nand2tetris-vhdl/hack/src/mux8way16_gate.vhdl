library ieee;
use ieee.std_logic_1164.all;

entity mux8way16_gate is
	-- 8-way 16-bit multiplexor:
	-- out0 = in0 if sel == 000
	--        in1 if sel == 001
	--        etc.
	--        in7 if sel == 111
	port (
		in0 : in std_logic_vector(0 to 15); 
		in1 : in std_logic_vector(0 to 15); 
		in2 : in std_logic_vector(0 to 15); 
		in3 : in std_logic_vector(0 to 15); 
		in4 : in std_logic_vector(0 to 15); 
		in5 : in std_logic_vector(0 to 15); 
		in6 :  std_logic_vector(0 to 15); 
		in7 :  std_logic_vector(0 to 15); 
		sel0 : in std_logic_vector(0 to 2); 
		out0 : out std_logic_vector(0 to 15)
	);
end mux8way16_gate;

architecture rtl of mux8way16_gate is
	signal out_mux_in0_in1_in2_in3 : std_logic_vector(0 to 15);
	signal out_mux_in4_in5_in6_in7 : std_logic_vector(0 to 15);

    	--  Declaration of the component that will be instantiated.
	component mux4way16_gate
    	port(
		in0 : in std_logic_vector(0 to 15); 
		in1 : in std_logic_vector(0 to 15); 
		in2 : in std_logic_vector(0 to 15); 
		in3 : in std_logic_vector(0 to 15); 
		sel0 : in std_logic_vector(0 to 1); 
		out0 : out std_logic_vector(0 to 15)
	);
	end component;

	component mux16_gate
    	port(
		in0 : in std_logic_vector(0 to 15);
		in1 : in std_logic_vector(0 to 15);
		sel0 : in std_logic;
		out0 : out std_logic_vector(0 to 15)
	);
	end component;

	--  Specifies which entity is bound with the component.
	for mux4way16_gate_0 : mux4way16_gate use entity work.mux4way16_gate;
	for mux4way16_gate_1 : mux4way16_gate use entity work.mux4way16_gate;
	for mux16_gate_0 : mux16_gate use entity work.mux16_gate;

begin
	mux4way16_gate_0: mux4way16_gate port map (
		in0 => in0, 
		in1 => in1, 
		in2 => in2, 
		in3 => in3, 
		sel0 => sel0(1 to 2), 
		out0 => out_mux_in0_in1_in2_in3
	);

	mux4way16_gate_1: mux4way16_gate port map (
		in0 => in4, 
		in1 => in5, 
		in2 => in6, 
		in3 => in7, 
		sel0 => sel0(1 to 2), 
		out0 => out_mux_in4_in5_in6_in7
	);

	mux16_gate_0: mux16_gate port map (
		in0 => out_mux_in0_in1_in2_in3, 
		in1 => out_mux_in4_in5_in6_in7, 
		sel0 => sel0(0), 
		out0 => out0
	);

end rtl;
