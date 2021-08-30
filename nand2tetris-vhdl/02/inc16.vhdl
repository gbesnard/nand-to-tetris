library ieee;
use ieee.std_logic_1164.all;

entity inc16 is
	port (
		in0 : in std_logic_vector(0 to 15); 
		out0 : out std_logic_vector(0 to 15)
	);
end inc16;

architecture rtl of inc16 is
	signal carry0 : std_logic_vector(0 to 15);

	--  Declaration of components that will be instantiated.
	component full_adder
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			in2 : in std_logic;
			sum0 : out std_logic;
			carry0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for full_adder_0: full_adder use entity work.full_adder;
	for full_adder_1: full_adder use entity work.full_adder;
	for full_adder_2: full_adder use entity work.full_adder;
	for full_adder_3: full_adder use entity work.full_adder;
	for full_adder_4: full_adder use entity work.full_adder;
	for full_adder_5: full_adder use entity work.full_adder;
	for full_adder_6: full_adder use entity work.full_adder;
	for full_adder_7: full_adder use entity work.full_adder;
	for full_adder_8: full_adder use entity work.full_adder;
	for full_adder_9: full_adder use entity work.full_adder;
	for full_adder_10: full_adder use entity work.full_adder;
	for full_adder_11: full_adder use entity work.full_adder;
	for full_adder_12: full_adder use entity work.full_adder;
	for full_adder_13: full_adder use entity work.full_adder;
	for full_adder_14: full_adder use entity work.full_adder;
	for full_adder_15: full_adder use entity work.full_adder;

begin

	full_adder_0: full_adder port map (
        in0 => in0(15),
	 	in1 => '1',
	 	in2 => '0',
	 	sum0 => out0(15),
	 	carry0 => carry0(15)
	);

	full_adder_1: full_adder port map (
        in0 => in0(14),
		in1 => '0',
		in2 => carry0(15),
		sum0 => out0(14),
		carry0 => carry0(14)
	);

	full_adder_2: full_adder port map (
        in0 => in0(13),
		in1 => '0',
		in2 => carry0(14),
		sum0 => out0(13),
		carry0 => carry0(13)
	);

	full_adder_3: full_adder port map (
        in0 => in0(12),
		in1 => '0',
		in2 => carry0(13),
		sum0 => out0(12),
		carry0 => carry0(12)
	);

	full_adder_4: full_adder port map (
        in0 => in0(11),
		in1 => '0',
		in2 => carry0(12),
		sum0 => out0(11),
		carry0 => carry0(11)
	);

	full_adder_5: full_adder port map (
        in0 => in0(10),
		in1 => '0',
		in2 => carry0(11),
		sum0 => out0(10),
		carry0 => carry0(10)
	);

	full_adder_6: full_adder port map (
        in0 => in0(9),
		in1 => '0',
		in2 => carry0(10),
		sum0 => out0(9),
		carry0 => carry0(9)
	);

	full_adder_7: full_adder port map (
        in0 => in0(8),
		in1 => '0',
		in2 => carry0(9),
		sum0 => out0(8),
		carry0 => carry0(8)
	);

	full_adder_8: full_adder port map (
        in0 => in0(7),
		in1 => '0',
		in2 => carry0(8),
		sum0 => out0(7),
		carry0 => carry0(7)
	);

	full_adder_9: full_adder port map (
        in0 => in0(6),
		in1 => '0',
		in2 => carry0(7),
		sum0 => out0(6),
		carry0 => carry0(6)
	);

	full_adder_10: full_adder port map (
        in0 => in0(5),
		in1 => '0',
		in2 => carry0(6),
		sum0 => out0(5),
		carry0 => carry0(5)
	);

	full_adder_11: full_adder port map (
        in0 => in0(4),
		in1 => '0',
		in2 => carry0(5),
		sum0 => out0(4),
		carry0 => carry0(4)
	);

	full_adder_12: full_adder port map (
        in0 => in0(3),
		in1 => '0',
		in2 => carry0(4),
		sum0 => out0(3),
		carry0 => carry0(3)
	);

	full_adder_13: full_adder port map (
        in0 => in0(2),
		in1 => '0',
		in2 => carry0(3),
		sum0 => out0(2),
		carry0 => carry0(2)
	);

	full_adder_14: full_adder port map (
        in0 => in0(1),
		in1 => '0',
		in2 => carry0(2),
		sum0 => out0(1),
		carry0 => carry0(1)
	);

	full_adder_15: full_adder port map (
        in0 => in0(0),
		in1 => '0',
		in2 => carry0(1),
		sum0 => out0(0),
		carry0 => carry0(0)
	);

end rtl;
