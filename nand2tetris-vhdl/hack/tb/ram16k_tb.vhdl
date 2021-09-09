library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.std_logic_vector_to_string_package.all;

entity ram16k_tb is
--  A testbench has no ports.
end ram16k_tb;

architecture behaviour of ram16k_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component ram16k
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 13);
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for ram16k_0: ram16k use entity work.ram16k;
	signal load0, clk : std_logic;
	signal in0 : std_logic_vector(0 to 15);
	signal out0 : std_logic_vector(0 to 15);
	signal addr0 : std_logic_vector(0 to 13);

begin
	--  Component instantiation.
	ram16k_0: ram16k port map (
		in0 => in0,
		load0 => load0,
		addr0 => addr0,
		clk => clk,
		out0 => out0
	);

	--  This process does the real job.
	process

		type pattern_type is record
			--  The inputs.
			clk : std_logic;
			in0 : std_logic_vector(0 to 15);
			load0 : std_logic;
			addr0 : std_logic_vector(0 to 13);
			--  The expected outputs.
			out0 : std_logic_vector(0 to 15);
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  The patterns to apply.
		constant patterns : pattern_array :=
		(			
			('0', "0000000000000000", '0', "00000000000000", "0000000000000000"),
			('1', "0000000000000000", '0', "00000000000000", "0000000000000000"),
			('0', "0000000000000000", '1', "00000000000000", "0000000000000000"),
			('1', "0000000000000000", '1', "00000000000000", "0000000000000000"),
			('0', "0001000011100001", '0', "00000000000000", "0000000000000000"),
			('1', "0001000011100001", '0', "00000000000000", "0000000000000000"),
			('0', "0001000011100001", '1', "01000011100001", "0000000000000000"),
			('1', "0001000011100001", '1', "01000011100001", "0001000011100001"),
			('0', "0001000011100001", '0', "00000000000000", "0000000000000000"),
			('1', "0001000011100001", '0', "00000000000000", "0000000000000000"),
			('0', "0011000000111001", '0', "11000000111001", "0000000000000000"),
			('1', "0011000000111001", '0', "11000000111001", "0000000000000000"),
			('0', "0011000000111001", '1', "11000000111001", "0000000000000000"),
			('1', "0011000000111001", '1', "11000000111001", "0011000000111001"),
			('0', "0011000000111001", '0', "11000000111001", "0011000000111001"),
			('1', "0011000000111001", '0', "11000000111001", "0011000000111001"),
			('1', "0011000000111001", '0', "01000011100001", "0001000011100001"),
			('0', "0011111111111111", '0', "01000011100001", "0001000011100001"),
			('1', "0011111111111111", '0', "01000011100001", "0001000011100001"),
			('0', "0011111111111111", '1', "11111111111111", "0000000000000000"),
			('1', "0011111111111111", '1', "11111111111111", "0011111111111111"),
			('0', "0011111111111111", '0', "11111111111111", "0011111111111111"),
			('1', "0011111111111111", '0', "11111111111111", "0011111111111111"),
			('1', "0011111111111111", '0', "11000000111001", "0011000000111001"),
			('1', "0011111111111111", '0', "11111111111111", "0011111111111111"),
			('0', "0011111111111111", '0', "10101010101000", "0000000000000000"),
			('1', "0011111111111111", '0', "10101010101000", "0000000000000000"),
			('1', "0011111111111111", '0', "10101010101001", "0000000000000000"),
			('1', "0011111111111111", '0', "10101010101010", "0000000000000000"),
			('1', "0011111111111111", '0', "10101010101011", "0000000000000000"),
			('1', "0011111111111111", '0', "10101010101100", "0000000000000000"),
			('1', "0011111111111111", '0', "10101010101101", "0000000000000000"),
			('1', "0011111111111111", '0', "10101010101110", "0000000000000000"),
			('1', "0011111111111111", '0', "10101010101111", "0000000000000000"),
			('0', "0101010101010101", '1', "10101010101000", "0000000000000000"),
			('1', "0101010101010101", '1', "10101010101000", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101001", "0000000000000000"),
			('1', "0101010101010101", '1', "10101010101001", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101010", "0000000000000000"),
			('1', "0101010101010101", '1', "10101010101010", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101011", "0000000000000000"),
			('1', "0101010101010101", '1', "10101010101011", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101100", "0000000000000000"),
			('1', "0101010101010101", '1', "10101010101100", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101101", "0000000000000000"),
			('1', "0101010101010101", '1', "10101010101101", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101110", "0000000000000000"),
			('1', "0101010101010101", '1', "10101010101110", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101111", "0000000000000000"),
			('1', "0101010101010101", '1', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "10101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101001", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101010", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101011", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101100", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101101", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101110", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101111", "0101010101010101"),
			('0', "1010101010101010", '1', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '1', "10101010101000", "1010101010101010"),
			('0', "1010101010101010", '0', "10101010101000", "1010101010101010"),
			('1', "1010101010101010", '0', "10101010101000", "1010101010101010"),
			('1', "1010101010101010", '0', "10101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101000", "1010101010101010"),
			('1', "0101010101010101", '1', "10101010101000", "0101010101010101"),
			('0', "1010101010101010", '1', "10101010101001", "0101010101010101"),
			('1', "1010101010101010", '1', "10101010101001", "1010101010101010"),
			('0', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101001", "1010101010101010"),
			('1', "1010101010101010", '0', "10101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101001", "1010101010101010"),
			('1', "0101010101010101", '1', "10101010101001", "0101010101010101"),
			('0', "1010101010101010", '1', "10101010101010", "0101010101010101"),
			('1', "1010101010101010", '1', "10101010101010", "1010101010101010"),
			('0', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101010", "1010101010101010"),
			('1', "1010101010101010", '0', "10101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101010", "1010101010101010"),
			('1', "0101010101010101", '1', "10101010101010", "0101010101010101"),
			('0', "1010101010101010", '1', "10101010101011", "0101010101010101"),
			('1', "1010101010101010", '1', "10101010101011", "1010101010101010"),
			('0', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101011", "1010101010101010"),
			('1', "1010101010101010", '0', "10101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101011", "1010101010101010"),
			('1', "0101010101010101", '1', "10101010101011", "0101010101010101"),
			('0', "1010101010101010", '1', "10101010101100", "0101010101010101"),
			('1', "1010101010101010", '1', "10101010101100", "1010101010101010"),
			('0', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101100", "1010101010101010"),
			('1', "1010101010101010", '0', "10101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101100", "1010101010101010"),
			('1', "0101010101010101", '1', "10101010101100", "0101010101010101"),
			('0', "1010101010101010", '1', "10101010101101", "0101010101010101"),
			('1', "1010101010101010", '1', "10101010101101", "1010101010101010"),
			('0', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101101", "1010101010101010"),
			('1', "1010101010101010", '0', "10101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101101", "1010101010101010"),
			('1', "0101010101010101", '1', "10101010101101", "0101010101010101"),
			('0', "1010101010101010", '1', "10101010101110", "0101010101010101"),
			('1', "1010101010101010", '1', "10101010101110", "1010101010101010"),
			('0', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101110", "1010101010101010"),
			('1', "1010101010101010", '0', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "10101010101110", "1010101010101010"),
			('1', "0101010101010101", '1', "10101010101110", "0101010101010101"),
			('0', "1010101010101010", '1', "10101010101111", "0101010101010101"),
			('1', "1010101010101010", '1', "10101010101111", "1010101010101010"),
			('0', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "10101010101111", "1010101010101010"),
			('0', "0101010101010101", '1', "10101010101111", "1010101010101010"),
			('1', "0101010101010101", '1', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "10101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101001", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101010", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101011", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101100", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101101", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101110", "0101010101010101"),
			('1', "0101010101010101", '0', "10101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "00010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "00010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "00110101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "01010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "01110101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "10010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "10110101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "11010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "11110101010101", "0000000000000000"),
			('0', "0101010101010101", '1', "00010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "00010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "00110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "00110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "01010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "01010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "01110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "01110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "10010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "10010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "10110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "10110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "11010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "11010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "11110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '0', "00010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "00010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "00110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "01010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "01110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "10010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "10110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "11010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "11110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "00010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "00010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "00010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "00110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "00010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "00010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "00110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "00110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00110101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "01010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "00110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "00110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "01010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "01010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "01110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "01010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "01010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "01110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "01110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01110101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "10010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "01110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "01110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "10010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "10010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "10110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "10010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "10010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "10110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "10110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10110101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "11010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "10110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "10110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "11010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "11010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "11010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "11010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "11110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "11110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "00110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "01110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "10110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "11110101010101", "1010101010101010"),
			('0', "0101010101010101", '1', "11110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "11110101010101", "0101010101010101"),
			('0', "0101010101010101", '0', "00010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "00010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "00110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "01010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "01110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "10010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "10110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "11010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "11110101010101", "0101010101010101")			
		);			
		
	begin

		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			clk <= patterns(i).clk;	
			in0 <= patterns(i).in0;					
			load0 <= patterns(i).load0;	
			addr0 <= patterns(i).addr0;
			--  Wait for the results.
			wait for clk_period/4;
			--  Check the outputs.			
			assert out0 = patterns(i).out0			
			report "bad value for i = " & integer'image(i)
					& " out0 " & to_string(out0) & " instead of " & to_string(patterns(i).out0)
			severity error;
			--  Wait a block period.
			wait for clk_period/4;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
