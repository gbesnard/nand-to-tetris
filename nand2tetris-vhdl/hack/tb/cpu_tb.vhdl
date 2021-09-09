library ieee;
use ieee.std_logic_1164.all;

library work;
use work.std_logic_vector_to_string_package.all;

entity cpu_tb is
--  A testbench has no ports.
end cpu_tb;

architecture behaviour of cpu_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component cpu
		port (
			in_mem : in std_logic_vector(0 to 15);
			instruction : in std_logic_vector(0 to 15);
			reset : in std_logic;
			clk : in std_logic; 
			out_mem : out std_logic_vector(0 to 15);
			write_mem : out std_logic;
			addr_mem : out std_logic_vector(0 to 15);
			out_pc : out std_logic_vector(0 to 15);
			out_dbg : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for cpu_0: cpu use entity work.cpu;
	signal in_mem : std_logic_vector(0 to 15);
	signal instruction : std_logic_vector(0 to 15);
	signal reset : std_logic;
	signal clk : std_logic; 
	signal out_mem : std_logic_vector(0 to 15);
	signal write_mem : std_logic;
	signal addr_mem : std_logic_vector(0 to 15);
	signal out_pc : std_logic_vector(0 to 15);
	signal out_dbg : std_logic_vector(0 to 15);

begin
	--  Component instantiation.
	cpu_0: cpu port map (
		in_mem => in_mem,
		instruction => instruction,
		reset => reset,
		clk => clk,
		out_mem => out_mem,
		write_mem => write_mem,
		addr_mem => addr_mem,
		out_pc => out_pc,
		out_dbg => out_dbg
	);

	--  This process does the real job.
	process

		type pattern_type is record
			--  The inputs.
			clk : std_logic; 
			in_mem : std_logic_vector(0 to 15);
			instruction : std_logic_vector(0 to 15);
			reset : std_logic;
			--  The expected outputs.
			out_mem : std_logic_vector(0 to 15);
			write_mem : std_logic;
			addr_mem : std_logic_vector(0 to 15);
			out_pc : std_logic_vector(0 to 15);
			out_dbg : std_logic_vector(0 to 15);
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  The patterns to apply.
		constant patterns : pattern_array :=
		(	
		--  clk , in_mem            , instruction       , rst, out_mem           , wr_m, addr_mem          , out_pc  		  , out_dbg (D register)						
			('0', "0000000000000000", "0000000000000000", '1', "0000000000000000", '0', "0000000000000000", "0000000000000000", "0000000000000000"),
			('1', "0000000000000000", "0000000000000000", '1', "0000000000000000", '0', "0000000000000000", "0000000000000000", "0000000000000000"),						
			('0', "0000000000000000", "0011000000111001", '0', "0000000000000000", '0', "0000000000000000", "0000000000000000", "0000000000000000"),
			('1', "0000000000000000", "0011000000111001", '0', "0000000000000000", '0', "0011000000111001", "0000000000000001", "0000000000000000"),
			('0', "0000000000000000", "1110110000010000", '0', "0000000000000000", '0', "0011000000111001", "0000000000000001", "0000000000000000"),
			('1', "0000000000000000", "1110110000010000", '0', "0000000000000000", '0', "0011000000111001", "0000000000000010", "0011000000111001"),
			('0', "0000000000000000", "0101101110100000", '0', "0000000000000000", '0', "0011000000111001", "0000000000000010", "0011000000111001"),
			('1', "0000000000000000", "0101101110100000", '0', "0000000000000000", '0', "0101101110100000", "0000000000000011", "0011000000111001"),
			('0', "0000000000000000", "1110000111010000", '0', "0000000000000000", '0', "0101101110100000", "0000000000000011", "0011000000111001"),
			('1', "0000000000000000", "1110000111010000", '0', "0000000000000000", '0', "0101101110100000", "0000000000000100", "0010101101100111"),
			('0', "0000000000000000", "0000001111101000", '0', "0000000000000000", '0', "0101101110100000", "0000000000000100", "0010101101100111"),
			('1', "0000000000000000", "0000001111101000", '0', "0000000000000000", '0', "0000001111101000", "0000000000000101", "0010101101100111"),
			('0', "0000000000000000", "1110001100001000", '0', "0010101101100111", '1', "0000001111101000", "0000000000000101", "0010101101100111"),
			('1', "0000000000000000", "1110001100001000", '0', "0010101101100111", '1', "0000001111101000", "0000000000000110", "0010101101100111"),
			('0', "0000000000000000", "0000001111101001", '0', "0000000000000000", '0', "0000001111101000", "0000000000000110", "0010101101100111"),
			('1', "0000000000000000", "0000001111101001", '0', "0000000000000000", '0', "0000001111101001", "0000000000000111", "0010101101100111"),
			('0', "0000000000000000", "1110001110011000", '0', "0010101101100110", '1', "0000001111101001", "0000000000000111", "0010101101100111"),
			('1', "0000000000000000", "1110001110011000", '0', "0010101101100101", '1', "0000001111101001", "0000000000001000", "0010101101100110"),
			('0', "0000000000000000", "0000001111101000", '0', "0000000000000000", '0', "0000001111101001", "0000000000001000", "0010101101100110"),
			('1', "0000000000000000", "0000001111101000", '0', "0000000000000000", '0', "0000001111101000", "0000000000001001", "0010101101100110"),
			('0', "0010101101100111", "1111010011010000", '0', "0000000000000000", '0', "0000001111101000", "0000000000001001", "0010101101100110"),
			('1', "0010101101100111", "1111010011010000", '0', "0000000000000000", '0', "0000001111101000", "0000000000001010", "1111111111111111"),
			('0', "0010101101100111", "0000000000001110", '0', "0000000000000000", '0', "0000001111101000", "0000000000001010", "1111111111111111"),
			('1', "0010101101100111", "0000000000001110", '0', "0000000000000000", '0', "0000000000001110", "0000000000001011", "1111111111111111"),
			('0', "0010101101100111", "1110001100000100", '0', "0000000000000000", '0', "0000000000001110", "0000000000001011", "1111111111111111"),
			('1', "0010101101100111", "1110001100000100", '0', "0000000000000000", '0', "0000000000001110", "0000000000001110", "1111111111111111"),
			('0', "0010101101100111", "0000001111100111", '0', "0000000000000000", '0', "0000000000001110", "0000000000001110", "1111111111111111"),
			('1', "0010101101100111", "0000001111100111", '0', "0000000000000000", '0', "0000001111100111", "0000000000001111", "1111111111111111"),
			('0', "0010101101100111", "1110110111100000", '0', "0000000000000000", '0', "0000001111100111", "0000000000001111", "1111111111111111"),
			('1', "0010101101100111", "1110110111100000", '0', "0000000000000000", '0', "0000001111101000", "0000000000010000", "1111111111111111"),
			('0', "0010101101100111", "1110001100001000", '0', "1111111111111111", '1', "0000001111101000", "0000000000010000", "1111111111111111"),
			('1', "0010101101100111", "1110001100001000", '0', "1111111111111111", '1', "0000001111101000", "0000000000010001", "1111111111111111"),
			('0', "0010101101100111", "0000000000010101", '0', "0000000000000000", '0', "0000001111101000", "0000000000010001", "1111111111111111"),
			('1', "0010101101100111", "0000000000010101", '0', "0000000000000000", '0', "0000000000010101", "0000000000010010", "1111111111111111"),
			('0', "0010101101100111", "1110011111000010", '0', "0000000000000000", '0', "0000000000010101", "0000000000010010", "1111111111111111"),
			('1', "0010101101100111", "1110011111000010", '0', "0000000000000000", '0', "0000000000010101", "0000000000010101", "1111111111111111"),
			('0', "0010101101100111", "0000000000000010", '0', "0000000000000000", '0', "0000000000010101", "0000000000010101", "1111111111111111"),
			('1', "0010101101100111", "0000000000000010", '0', "0000000000000000", '0', "0000000000000010", "0000000000010110", "1111111111111111"),
			('0', "0010101101100111", "1110000010010000", '0', "0000000000000000", '0', "0000000000000010", "0000000000010110", "1111111111111111"),
			('1', "0010101101100111", "1110000010010000", '0', "0000000000000000", '0', "0000000000000010", "0000000000010111", "0000000000000001"),
			('0', "0010101101100111", "0000001111101000", '0', "0000000000000000", '0', "0000000000000010", "0000000000010111", "0000000000000001"),
			('1', "0010101101100111", "0000001111101000", '0', "0000000000000000", '0', "0000001111101000", "0000000000011000", "0000000000000001"),
			('0', "0010101101100111", "1110111010010000", '0', "0000000000000000", '0', "0000001111101000", "0000000000011000", "0000000000000001"),
			('1', "0010101101100111", "1110111010010000", '0', "0000000000000000", '0', "0000001111101000", "0000000000011001", "1111111111111111"),
			('0', "0010101101100111", "1110001100000001", '0', "0000000000000000", '0', "0000001111101000", "0000000000011001", "1111111111111111"),
			('1', "0010101101100111", "1110001100000001", '0', "0000000000000000", '0', "0000001111101000", "0000000000011010", "1111111111111111"),
			('0', "0010101101100111", "1110001100000010", '0', "0000000000000000", '0', "0000001111101000", "0000000000011010", "1111111111111111"),
			('1', "0010101101100111", "1110001100000010", '0', "0000000000000000", '0', "0000001111101000", "0000000000011011", "1111111111111111"),
			('0', "0010101101100111", "1110001100000011", '0', "0000000000000000", '0', "0000001111101000", "0000000000011011", "1111111111111111"),
			('1', "0010101101100111", "1110001100000011", '0', "0000000000000000", '0', "0000001111101000", "0000000000011100", "1111111111111111"),
			('0', "0010101101100111", "1110001100000100", '0', "0000000000000000", '0', "0000001111101000", "0000000000011100", "1111111111111111"),
			('1', "0010101101100111", "1110001100000100", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "1111111111111111"),
			('0', "0010101101100111", "1110001100000101", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "1111111111111111"),
			('1', "0010101101100111", "1110001100000101", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "1111111111111111"),
			('0', "0010101101100111", "1110001100000110", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "1111111111111111"),
			('1', "0010101101100111", "1110001100000110", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "1111111111111111"),
			('0', "0010101101100111", "1110001100000111", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "1111111111111111"),
			('1', "0010101101100111", "1110001100000111", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "1111111111111111"),
			('0', "0010101101100111", "1110101010010000", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "1111111111111111"),
			('1', "0010101101100111", "1110101010010000", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000000"),
			('0', "0010101101100111", "1110001100000001", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000000"),
			('1', "0010101101100111", "1110001100000001", '0', "0000000000000000", '0', "0000001111101000", "0000001111101010", "0000000000000000"),			
			('0', "0010101101100111", "1110001100000010", '0', "0000000000000000", '0', "0000001111101000", "0000001111101010", "0000000000000000"),
			('1', "0010101101100111", "1110001100000010", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000000"),
			('0', "0010101101100111", "1110001100000011", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000000"),
			('1', "0010101101100111", "1110001100000011", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000000"),
			('0', "0010101101100111", "1110001100000100", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000000"),
			('1', "0010101101100111", "1110001100000100", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000000"),
			('0', "0010101101100111", "1110001100000101", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000000"),
			('1', "0010101101100111", "1110001100000101", '0', "0000000000000000", '0', "0000001111101000", "0000001111101010", "0000000000000000"),
			('0', "0010101101100111", "1110001100000110", '0', "0000000000000000", '0', "0000001111101000", "0000001111101010", "0000000000000000"),
			('1', "0010101101100111", "1110001100000110", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000000"),
			('0', "0010101101100111", "1110001100000111", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000000"),
			('1', "0010101101100111", "1110001100000111", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000000"),			
			('0', "0010101101100111", "1110111111010000", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000000"),
			('1', "0010101101100111", "1110111111010000", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000001"),
			('0', "0010101101100111", "1110001100000001", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000001"),
			('1', "0010101101100111", "1110001100000001", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000001"),
			('0', "0010101101100111", "1110001100000010", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000001"),
			('1', "0010101101100111", "1110001100000010", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000001"),
			('0', "0010101101100111", "1110001100000011", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000001"),
			('1', "0010101101100111", "1110001100000011", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000001"),
			('0', "0010101101100111", "1110001100000100", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000001"),
			('1', "0010101101100111", "1110001100000100", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000001"),
			('0', "0010101101100111", "1110001100000101", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000001"),
			('1', "0010101101100111", "1110001100000101", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000001"),
			('0', "0010101101100111", "1110001100000110", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000001"),
			('1', "0010101101100111", "1110001100000110", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000001"),
			('0', "0010101101100111", "1110001100000111", '0', "0000000000000000", '0', "0000001111101000", "0000001111101001", "0000000000000001"),
			('1', "0010101101100111", "1110001100000111", '0', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000001"),
			('0', "0010101101100111", "1110001100000111", '1', "0000000000000000", '0', "0000001111101000", "0000001111101000", "0000000000000001"),
			('1', "0010101101100111", "1110001100000111", '1', "0000000000000000", '0', "0000001111101000", "0000000000000000", "0000000000000001"),
			('0', "0010101101100111", "0111111111111111", '0', "0000000000000000", '0', "0000001111101000", "0000000000000000", "0000000000000001"),
			('1', "0010101101100111", "0111111111111111", '0', "0000000000000000", '0', "0111111111111111", "0000000000000001", "0000000000000001")
		);			
		
	begin
	
		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			clk <= patterns(i).clk;	
			in_mem <= patterns(i).in_mem;
			instruction <= patterns(i).instruction;
			reset <= patterns(i).reset;				
			
			--  Wait for the results.
			wait for clk_period/4;

			--  Check the outputs.			
			assert out_pc = patterns(i).out_pc			
			report "bad value for i = " & integer'image(i)
					& " pc " & to_string(out_pc) & " instead of " & to_string(patterns(i).out_pc)
			severity error;

			-- When out_mem = 0, we don't care about output
			assert out_mem = patterns(i).out_mem or patterns(i).out_mem = "0000000000000000"
			report "bad value for i = " & integer'image(i)
					& " out_mem " & to_string(out_mem) & " instead of " & to_string(patterns(i).out_mem)
			severity error;

			assert addr_mem = patterns(i).addr_mem			
			report "bad value for i = " & integer'image(i)
					& " addr_mem " & to_string(addr_mem) & " instead of " & to_string(patterns(i).addr_mem)
			severity error;
			
			assert out_dbg = patterns(i).out_dbg			
			report "bad value for i = " & integer'image(i)
			 		& " out_dbg " & to_string(out_dbg) & " instead of " & to_string(patterns(i).out_dbg)
			severity error;

			assert write_mem = patterns(i).write_mem			
			report "bad value for i = " & integer'image(i)
					& " write_mem " & std_logic'image(write_mem) & " instead of " & std_logic'image(patterns(i).write_mem)
			severity error;

			--  Wait a block period.
			wait for clk_period/4;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
