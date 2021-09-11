library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
	port (
		in0 : in std_logic;	-- 1-bit input
		in1 : in std_logic;	-- 1-bit input
		sum0 : out std_logic;	-- Right bit of a + b
		carry0 : out std_logic	-- Left bit of a + b
	);
end half_adder;

architecture rtl of half_adder is

	--  Declaration of components that will be instantiated.
	component and_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	component xor_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for and_gate_0: and_gate use entity work.and_gate;
	for xor_gate_0: xor_gate use entity work.xor_gate;

begin
	xor_gate_0: xor_gate port map (
        	in0 => in0,
        	in1 => in1,
        	out0 => sum0
	);

	and_gate_0: and_gate port map (
		in0 => in0,
		in1 => in1,
		out0 => carry0
    	);

end rtl;
