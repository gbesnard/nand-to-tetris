library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.std_logic_vector_to_string_package.all;
use work.virtual_registers_array_package.all;
use work.screen_array_package.all;

entity memory_tb is
--  A testbench has no ports.
end memory_tb;

architecture behaviour of memory_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component memory
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 15);
			clk : in std_logic; 
			dbg_keyboard_in : in std_logic_vector(0 to 15);
			out0 : out std_logic_vector(0 to 15);
			dbg_out_regs : out virtual_registers_array_t;
			dbg_out_screen : out screen_array_t;
			dbg_keyboard_out : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for memory_0: memory use entity work.memory;
	signal load0, clk : std_logic;
	signal in0 : std_logic_vector(0 to 15);
	signal dbg_keyboard_in : std_logic_vector(0 to 15);
	signal out0 : std_logic_vector(0 to 15);	
	signal addr0 : std_logic_vector(0 to 15) := "0000000000000000";
	signal dbg_out_regs : virtual_registers_array_t;
	signal dbg_out_screen : screen_array_t;
	signal dbg_keyboard_out : std_logic_vector(0 to 15);

begin
	--  Component instantiation.
	memory_0: memory port map (
		in0 => in0,
		load0 => load0,
		addr0 => addr0,
		clk => clk,
		dbg_keyboard_in => dbg_keyboard_in,
		out0 => out0,
		dbg_out_regs => dbg_out_regs,
		dbg_out_screen => dbg_out_screen,
		dbg_keyboard_out => dbg_keyboard_out
	);

	--  This process does the real job.
	process

		type pattern_type is record
			--  The inputs.
			clk : std_logic;
			in0 : std_logic_vector(0 to 15);
			load0 : std_logic;
			addr0 : std_logic_vector(0 to 15);
			--  The expected outputs.
			out0 : std_logic_vector(0 to 15);
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  The patterns to apply.
		constant patterns : pattern_array :=
		(			
			-- Test RAM
			('0', "0000000000000000", '0', "0000000000000000", "0000000000000000"),
			('1', "0000000000000000", '0', "0000000000000000", "0000000000000000"),
			('0', "0000000000000000", '1', "0000000000000000", "0000000000000000"),
			('1', "0000000000000000", '1', "0000000000000000", "0000000000000000"),
			('0', "0001000011100001", '0', "0000000000000000", "0000000000000000"),
			('1', "0001000011100001", '0', "0000000000000000", "0000000000000000"),
			('0', "0001000011100001", '1', "0001000011100001", "0000000000000000"),
			('1', "0001000011100001", '1', "0001000011100001", "0001000011100001"),
			('0', "0001000011100001", '0', "0000000000000000", "0000000000000000"),
			('1', "0001000011100001", '0', "0000000000000000", "0000000000000000"),
			('0', "0011000000111001", '0', "0011000000111001", "0000000000000000"),
			('1', "0011000000111001", '0', "0011000000111001", "0000000000000000"),
			('0', "0011000000111001", '1', "0011000000111001", "0000000000000000"),
			('1', "0011000000111001", '1', "0011000000111001", "0011000000111001"),
			('0', "0011000000111001", '0', "0011000000111001", "0011000000111001"),
			('1', "0011000000111001", '0', "0011000000111001", "0011000000111001"),
			('1', "0011000000111001", '0', "0001000011100001", "0001000011100001"),
			('0', "0011111111111111", '0', "0001000011100001", "0001000011100001"),
			('1', "0011111111111111", '0', "0001000011100001", "0001000011100001"),
			('0', "0011111111111111", '1', "0011111111111111", "0000000000000000"),
			('1', "0011111111111111", '1', "0011111111111111", "0011111111111111"),
			('0', "0011111111111111", '0', "0011111111111111", "0011111111111111"),
			('1', "0011111111111111", '0', "0011111111111111", "0011111111111111"),
			('1', "0011111111111111", '0', "0011000000111001", "0011000000111001"),
			('1', "0011111111111111", '0', "0011111111111111", "0011111111111111"),
			('0', "0011111111111111", '0', "0010101010101000", "0000000000000000"),
			('1', "0011111111111111", '0', "0010101010101000", "0000000000000000"),
			('1', "0011111111111111", '0', "0010101010101001", "0000000000000000"),
			('1', "0011111111111111", '0', "0010101010101010", "0000000000000000"),
			('1', "0011111111111111", '0', "0010101010101011", "0000000000000000"),
			('1', "0011111111111111", '0', "0010101010101100", "0000000000000000"),
			('1', "0011111111111111", '0', "0010101010101101", "0000000000000000"),
			('1', "0011111111111111", '0', "0010101010101110", "0000000000000000"),
			('1', "0011111111111111", '0', "0010101010101111", "0000000000000000"),
			('0', "0101010101010101", '1', "0010101010101000", "0000000000000000"),
			('1', "0101010101010101", '1', "0010101010101000", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101001", "0000000000000000"),
			('1', "0101010101010101", '1', "0010101010101001", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101010", "0000000000000000"),
			('1', "0101010101010101", '1', "0010101010101010", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101011", "0000000000000000"),
			('1', "0101010101010101", '1', "0010101010101011", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101100", "0000000000000000"),
			('1', "0101010101010101", '1', "0010101010101100", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101101", "0000000000000000"),
			('1', "0101010101010101", '1', "0010101010101101", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101110", "0000000000000000"),
			('1', "0101010101010101", '1', "0010101010101110", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101111", "0000000000000000"),
			('1', "0101010101010101", '1', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "0010101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101001", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101010", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101011", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101100", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101101", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101110", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101111", "0101010101010101"),
			('0', "1010101010101010", '1', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '1', "0010101010101000", "1010101010101010"),
			('0', "1010101010101010", '0', "0010101010101000", "1010101010101010"),
			('1', "1010101010101010", '0', "0010101010101000", "1010101010101010"),
			('1', "1010101010101010", '0', "0010101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101000", "1010101010101010"),
			('1', "0101010101010101", '1', "0010101010101000", "0101010101010101"),
			('0', "1010101010101010", '1', "0010101010101001", "0101010101010101"),
			('1', "1010101010101010", '1', "0010101010101001", "1010101010101010"),
			('0', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101001", "1010101010101010"),
			('1', "1010101010101010", '0', "0010101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101001", "1010101010101010"),
			('1', "0101010101010101", '1', "0010101010101001", "0101010101010101"),
			('0', "1010101010101010", '1', "0010101010101010", "0101010101010101"),
			('1', "1010101010101010", '1', "0010101010101010", "1010101010101010"),
			('0', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101010", "1010101010101010"),
			('1', "1010101010101010", '0', "0010101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101010", "1010101010101010"),
			('1', "0101010101010101", '1', "0010101010101010", "0101010101010101"),
			('0', "1010101010101010", '1', "0010101010101011", "0101010101010101"),
			('1', "1010101010101010", '1', "0010101010101011", "1010101010101010"),
			('0', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101011", "1010101010101010"),
			('1', "1010101010101010", '0', "0010101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101011", "1010101010101010"),
			('1', "0101010101010101", '1', "0010101010101011", "0101010101010101"),
			('0', "1010101010101010", '1', "0010101010101100", "0101010101010101"),
			('1', "1010101010101010", '1', "0010101010101100", "1010101010101010"),
			('0', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101100", "1010101010101010"),
			('1', "1010101010101010", '0', "0010101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101100", "1010101010101010"),
			('1', "0101010101010101", '1', "0010101010101100", "0101010101010101"),
			('0', "1010101010101010", '1', "0010101010101101", "0101010101010101"),
			('1', "1010101010101010", '1', "0010101010101101", "1010101010101010"),
			('0', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101101", "1010101010101010"),
			('1', "1010101010101010", '0', "0010101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101101", "1010101010101010"),
			('1', "0101010101010101", '1', "0010101010101101", "0101010101010101"),
			('0', "1010101010101010", '1', "0010101010101110", "0101010101010101"),
			('1', "1010101010101010", '1', "0010101010101110", "1010101010101010"),
			('0', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101110", "1010101010101010"),
			('1', "1010101010101010", '0', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '1', "0010101010101110", "1010101010101010"),
			('1', "0101010101010101", '1', "0010101010101110", "0101010101010101"),
			('0', "1010101010101010", '1', "0010101010101111", "0101010101010101"),
			('1', "1010101010101010", '1', "0010101010101111", "1010101010101010"),
			('0', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101000", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101001", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101010", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101011", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101100", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101110", "0101010101010101"),
			('1', "1010101010101010", '0', "0010101010101111", "1010101010101010"),
			('0', "0101010101010101", '1', "0010101010101111", "1010101010101010"),
			('1', "0101010101010101", '1', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "0010101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101000", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101001", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101010", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101011", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101100", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101101", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101110", "0101010101010101"),
			('1', "0101010101010101", '0', "0010101010101111", "0101010101010101"),
			('0', "0101010101010101", '0', "0000010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "0000010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "0000110101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "0001010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "0001110101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "0010010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "0010110101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "0011010101010101", "0000000000000000"),
			('1', "0101010101010101", '0', "0011110101010101", "0000000000000000"),
			('0', "0101010101010101", '1', "0000010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "0000010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0000110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "0000110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0001010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "0001010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0001110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "0001110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0010010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "0010010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0010110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "0010110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0011010101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "0011010101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0011110101010101", "0000000000000000"),
			('1', "0101010101010101", '1', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '0', "0000010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0000010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0000110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0001010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0001110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0010010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0010110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0011010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0011110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "0000010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "0000010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "0000010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "0000110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0000010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "0000010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "0000110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "0000110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000110101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "0001010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0000110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "0000110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "0001010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "0001010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "0001110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0001010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "0001010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "0001110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "0001110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001110101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "0010010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0001110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "0001110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "0010010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "0010010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "0010110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0010010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "0010010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "0010110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "0010110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010110101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "0011010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0010110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "0010110101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "0011010101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "0011010101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011010101010101", "1010101010101010"),
			('1', "1010101010101010", '0', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '1', "0011010101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "0011010101010101", "0101010101010101"),
			('0', "1010101010101010", '1', "0011110101010101", "0101010101010101"),
			('1', "1010101010101010", '1', "0011110101010101", "1010101010101010"),
			('0', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0000110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0001110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0010110101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011010101010101", "0101010101010101"),
			('1', "1010101010101010", '0', "0011110101010101", "1010101010101010"),
			('0', "0101010101010101", '1', "0011110101010101", "1010101010101010"),
			('1', "0101010101010101", '1', "0011110101010101", "0101010101010101"),
			('0', "0101010101010101", '0', "0000010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0000010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0000110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0001010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0001110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0010010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0010110101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0011010101010101", "0101010101010101"),
			('1', "0101010101010101", '0', "0011110101010101", "0101010101010101"),
			
			-- Test Screen
			('0', "0000000000000001", '1', "0100000000000000", "0000000000000000"),
			('1', "0000000000000001", '1', "0100000000000000", "0000000000000001"),
			('0', "0000000000000000", '0', "0100000000000000", "0000000000000001"),
			('1', "0000000000000000", '0', "0100000000000000", "0000000000000001"),
			('0', "0000000000000001", '0', "0100001111111111", "0000000000000000"),
			('1', "0000000000000001", '0', "0100001111111111", "0000000000000000"),
			('0', "0000000000000001", '1', "0100001111111111", "0000000000000000"),
			('1', "0000000000000001", '1', "0100001111111111", "0000000000000001"),
			('0', "0000000000000000", '0', "0100001111111111", "0000000000000001"),
			('1', "0000000000000000", '0', "0100001111111111", "0000000000000001")
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