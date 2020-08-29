library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port (
		in0 : in std_logic;	-- 1-bit input
		in1 : in std_logic;	-- 1-bit input
		in2 : in std_logic;	-- 1-bit input
		sum0 : out std_logic;	-- Right bit of a + b
		carry0 : out std_logic	-- Left bit of a + b
	);
end full_adder;

architecture rtl of full_adder is
	signal half_sum0, half_carry0, half_carry1 : std_logic;

	--  Declaration of components that will be instantiated.
	component half_adder
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			sum0 : out std_logic;
			carry0 : out std_logic
		);
	end component;

	component or_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for half_adder_0: half_adder use entity work.half_adder;
	for half_adder_1: half_adder use entity work.half_adder;
	for or_gate_0: or_gate use entity work.or_gate;

begin
	half_adder_0: half_adder port map (
        	in0 => in0,
        	in1 => in1,
		sum0 => half_sum0,
		carry0 => half_carry0
	);

	half_adder_1: half_adder port map (
        	in0 => half_sum0,
        	in1 => in2,
		sum0 => sum0,
		carry0 => half_carry1
	);

	or_gate_0: or_gate port map (
		in0 => half_carry0,
		in1 => half_carry1,
		out0 => carry0
    	);

end rtl;
