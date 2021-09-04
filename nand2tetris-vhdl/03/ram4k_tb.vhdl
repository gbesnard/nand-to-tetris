library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.std_logic_vector_to_string_package.all;

entity ram4k_tb is
--  A testbench has no ports.
end ram4k_tb;

architecture behaviour of ram4k_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component ram4k
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 11);
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for ram4k_0: ram4k use entity work.ram4k;
	signal load0, clk : std_logic;
	signal in0 : std_logic_vector(0 to 15);
	signal out0 : std_logic_vector(0 to 15);
	signal addr0 : std_logic_vector(0 to 11);

begin
	--  Component instantiation.
	ram4k_0: ram4k port map (
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
			addr0 : std_logic_vector(0 to 11);
			--  The expected outputs.
			out0 : std_logic_vector(0 to 15);
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  The patterns to apply.
		constant patterns : pattern_array :=
		(			
			('0', "0000000000000000", '1', "000000000000", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "000000000000", "0000000000000000"),
			('0', "0000000000000000", '1', "010001010111", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "010001010111", "0000000000000000"),
			('0', "0000000000000000", '1', "110110111001", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "110110111001", "0000000000000000"),
			('0', "0000000000000000", '1', "111111111111", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "111111111111", "0000000000000000"),
			('0', "0000000000000000", '1', "101010101000", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101010101000", "0000000000000000"),
			('0', "0000000000000000", '1', "101010101001", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101010101001", "0000000000000000"),
			('0', "0000000000000000", '1', "101010101010", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101010101010", "0000000000000000"),
			('0', "0000000000000000", '1', "101010101011", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101010101011", "0000000000000000"),
			('0', "0000000000000000", '1', "101010101100", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101010101100", "0000000000000000"),
			('0', "0000000000000000", '1', "101010101101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101010101101", "0000000000000000"),
			('0', "0000000000000000", '1', "101010101110", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101010101110", "0000000000000000"),
			('0', "0000000000000000", '1', "101010101111", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101010101111", "0000000000000000"),
			('0', "0000000000000000", '1', "000101010101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "000101010101", "0000000000000000"),
			('0', "0000000000000000", '1', "001101010101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "001101010101", "0000000000000000"),
			('0', "0000000000000000", '1', "010101010101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "010101010101", "0000000000000000"),
			('0', "0000000000000000", '1', "011101010101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "011101010101", "0000000000000000"),
			('0', "0000000000000000", '1', "100101010101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "100101010101", "0000000000000000"),
			('0', "0000000000000000", '1', "101101010101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "101101010101", "0000000000000000"),
			('0', "0000000000000000", '1', "110101010101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "110101010101", "0000000000000000"),
			('0', "0000000000000000", '1', "111101010101", "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "111101010101", "0000000000000000"),
			('0', "0000000000000000", '0', "000000000000", "0000000000000000"),
			('1', "0000000000000000", '0', "000000000000", "0000000000000000"),
			('0', "0000000000000000", '1', "000000000000", "0000000000000000"),
			('1', "0000000000000000", '1', "000000000000", "0000000000000000"),
			('0', "0000010001010111", '0', "000000000000", "0000000000000000"),
			('1', "0000010001010111", '0', "000000000000", "0000000000000000"),
			('0', "0000010001010111", '1', "010001010111", "0000000000000000"),
			('1', "0000010001010111", '1', "010001010111", "0000010001010111"),
			('0', "0000010001010111", '0', "000000000000", "0000000000000000"),
			('1', "0000010001010111", '0', "000000000000", "0000000000000000"),
			('0', "0000110110111001", '0', "110110111001", "0000000000000000"),
			('1', "0000110110111001", '0', "110110111001", "0000000000000000"),
			('0', "0000110110111001", '1', "110110111001", "0000000000000000"),
			('1', "0000110110111001", '1', "110110111001", "0000110110111001"),
			('0', "0000110110111001", '0', "110110111001", "0000110110111001"),
			('1', "0000110110111001", '0', "110110111001", "0000110110111001"),
			('1', "0000110110111001", '0', "010001010111", "0000010001010111"),
			('0', "0000111111111111", '0', "010001010111", "0000010001010111"),
			('1', "0000111111111111", '0', "010001010111", "0000010001010111"),
			('0', "0000111111111111", '1', "111111111111", "0000000000000000"),
			('1', "0000111111111111", '1', "111111111111", "0000111111111111"),
			('0', "0000111111111111", '0', "111111111111", "0000111111111111"),
			('1', "0000111111111111", '0', "111111111111", "0000111111111111"),
			('1', "0000111111111111", '0', "110110111001", "0000110110111001"),
			('1', "0000111111111111", '0', "111111111111", "0000111111111111"),
			('0', "0000111111111111", '0', "101010101000", "0000000000000000"),
			('1', "0000111111111111", '0', "101010101000", "0000000000000000"),
			('1', "0000111111111111", '0', "101010101001", "0000000000000000"),
			('1', "0000111111111111", '0', "101010101010", "0000000000000000"),
			('1', "0000111111111111", '0', "101010101011", "0000000000000000"),
			('1', "0000111111111111", '0', "101010101100", "0000000000000000"),
			('1', "0000111111111111", '0', "101010101101", "0000000000000000"),
			('1', "0000111111111111", '0', "101010101110", "0000000000000000"),
			('1', "0000111111111111", '0', "101010101111", "0000000000000000"),
			('0', "0101010101010101", '1', "101010101000", "0000000000000000"),
			('1', "0101010101010101", '1', "101010101000", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101001", "0000000000000000"),
			('1', "0101010101010101", '1', "101010101001", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101010", "0000000000000000"),
			('1', "0101010101010101", '1', "101010101010", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101011", "0000000000000000"),
			('1', "0101010101010101", '1', "101010101011", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101100", "0000000000000000"),
			('1', "0101010101010101", '1', "101010101100", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101101", "0000000000000000"),
			('1', "0101010101010101", '1', "101010101101", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101110", "0000000000000000"),
			('1', "0101010101010101", '1', "101010101110", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101111", "0000000000000000"),
			('1', "0101010101010101", '1', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101001", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101010", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101011", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101100", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101101", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101110", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101111", "0101010101010101"),
			('0', "1010101010101010", '1', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '1', "101010101000", "1010101010101010"),
			('0', "1010101010101010", '0', "101010101000", "1010101010101010"),
			('1', "1010101010101010", '0', "101010101000", "1010101010101010"),
			('1', "1010101010101010", '0', "101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101000", "1010101010101010"),
			('1', "0101010101010101", '1', "101010101000", "0101010101010101"),
			('0', "1010101010101010", '1', "101010101001", "0101010101010101"),
			('1', "1010101010101010", '1', "101010101001", "1010101010101010"),
			('0', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101001", "1010101010101010"),
			('1', "1010101010101010", '0', "101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101001", "1010101010101010"),
			('1', "0101010101010101", '1', "101010101001", "0101010101010101"),
			('0', "1010101010101010", '1', "101010101010", "0101010101010101"),
			('1', "1010101010101010", '1', "101010101010", "1010101010101010"),
			('0', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101010", "1010101010101010"),
			('1', "1010101010101010", '0', "101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101010", "1010101010101010"),
			('1', "0101010101010101", '1', "101010101010", "0101010101010101"),
			('0', "1010101010101010", '1', "101010101011", "0101010101010101"),
			('1', "1010101010101010", '1', "101010101011", "1010101010101010"),
			('0', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101011", "1010101010101010"),
			('1', "1010101010101010", '0', "101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101011", "1010101010101010"),
			('1', "0101010101010101", '1', "101010101011", "0101010101010101"),
			('0', "1010101010101010", '1', "101010101100", "0101010101010101"),
			('1', "1010101010101010", '1', "101010101100", "1010101010101010"),
			('0', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101100", "1010101010101010"),
			('1', "1010101010101010", '0', "101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101100", "1010101010101010"),
			('1', "0101010101010101", '1', "101010101100", "0101010101010101"),
			('0', "1010101010101010", '1', "101010101101", "0101010101010101"),
			('1', "1010101010101010", '1', "101010101101", "1010101010101010"),
			('0', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101101", "1010101010101010"),
			('1', "1010101010101010", '0', "101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101101", "1010101010101010"),
			('1', "0101010101010101", '1', "101010101101", "0101010101010101"),
			('0', "1010101010101010", '1', "101010101110", "0101010101010101"),
			('1', "1010101010101010", '1', "101010101110", "1010101010101010"),
			('0', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101110", "1010101010101010"),
			('1', "1010101010101010", '0', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "101010101110", "1010101010101010"),
			('1', "0101010101010101", '1', "101010101110", "0101010101010101"),
			('0', "1010101010101010", '1', "101010101111", "0101010101010101"),
			('1', "1010101010101010", '1', "101010101111", "1010101010101010"),
			('0', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "101010101111", "1010101010101010"),
			('0', "0101010101010101", '1', "101010101111", "1010101010101010"),
			('1', "0101010101010101", '1', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101001", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101010", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101011", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101100", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101101", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101110", "0101010101010101"),
			('1', "0101010101010101", '0', "101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "000101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "000101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "001101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "011101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "100101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "101101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "110101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "111101010101", "0000000000000000"),
			('0', "0101010101010101", '1', "000101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "000101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "001101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "001101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "011101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "011101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "100101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "100101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "101101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "101101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "111101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '0', "000101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "000101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "001101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "011101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "100101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "101101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "111101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "000101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "000101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "000101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "001101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "011101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "100101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "101101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "000101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "000101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "001101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "001101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "001101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "011101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "100101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "101101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "001101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "001101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "001101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "011101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "100101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "101101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "011101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "011101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "001101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "011101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "100101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "101101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "011101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "011101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "100101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "100101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "001101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "011101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "100101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "101101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "100101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "100101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "101101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "101101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "001101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "011101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "100101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "101101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "101101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "101101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "001101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "011101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "100101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "101101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "110101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "111101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "111101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "000101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "001101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "011101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "100101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "101101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "111101010101", "1010101010101010"),
			('0', "0101010101010101", '1', "111101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "111101010101", "0101010101010101"),
			('0', "0101010101010101", '0', "000101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "000101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "001101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "011101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "100101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "101101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "111101010101", "0101010101010101")
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
