library ieee;
use ieee.std_logic_1164.all;

library work;
use work.std_logic_vector_to_string_package.all;

entity reg_tb is
--  A testbench has no ports.
end reg_tb;

architecture behaviour of reg_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component reg
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic; 
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for reg_0: reg use entity work.reg;
	signal load0, clk : std_logic;
	signal in0, out0 : std_logic_vector(0 to 15);

begin
	--  Component instantiation.
	reg_0: reg port map (
		in0 => in0, 
		load0 => load0,
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
			--  The expected outputs.
			out0 : std_logic_vector(0 to 15);
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  Init pattern to apply.
		constant init_patterns : pattern_array :=
		(	
			('1', "1111111111111111", '1', "UUUUUUUUUUUUUUUU"),
			('0', "1111111111111111", '1', "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '1', "UUUUUUUUUUUUUUUU"),
			('0', "0000000000000000", '1', "UUUUUUUUUUUUUUUU"),
			('1', "0000000000000000", '0', "UUUUUUUUUUUUUUUU")
		);

		--  The patterns to apply.
		constant patterns : pattern_array :=
		(			
			('0', "0000000000000000", '0', "0000000000000000"),
			('1', "0000000000000000", '0', "0000000000000000"),
			('0', "0000000000000000", '1', "0000000000000000"),
			('1', "0000000000000000", '1', "0000000000000000"),
			('0', "1000001010000101", '0', "0000000000000000"),
			('1', "1000001010000101", '0', "0000000000000000"),
			('0', "0010101101100111", '0', "0000000000000000"),
			('1', "0010101101100111", '0', "0000000000000000"),
			('0', "1000001010000101", '1', "0000000000000000"),
			('1', "1000001010000101", '1', "1000001010000101"),
			('0', "1000001010000101", '1', "1000001010000101"),
			('1', "1000001010000101", '1', "1000001010000101"),
			('0', "1000001010000101", '0', "1000001010000101"),
			('1', "1000001010000101", '0', "1000001010000101"),
			('0', "0011000000111001", '1', "1000001010000101"),
			('1', "0011000000111001", '1', "0011000000111001"),
			('0', "0000000000000000", '0', "0011000000111001"),
			('1', "0000000000000000", '0', "0011000000111001"),
			('0', "0000000000000000", '1', "0011000000111001"),
			('1', "0000000000000000", '1', "0000000000000000"),
			('0', "0000000000000001", '0', "0000000000000000"),
			('1', "0000000000000001", '0', "0000000000000000"),
			('0', "0000000000000001", '1', "0000000000000000"),
			('1', "0000000000000001", '1', "0000000000000001"),
			('0', "0000000000000010", '0', "0000000000000001"),
			('1', "0000000000000010", '0', "0000000000000001"),
			('0', "0000000000000010", '1', "0000000000000001"),
			('1', "0000000000000010", '1', "0000000000000010"),
			('0', "0000000000000100", '0', "0000000000000010"),
			('1', "0000000000000100", '0', "0000000000000010"),
			('0', "0000000000000100", '1', "0000000000000010"),
			('1', "0000000000000100", '1', "0000000000000100"),
			('0', "0000000000001000", '0', "0000000000000100"),
			('1', "0000000000001000", '0', "0000000000000100"),
			('0', "0000000000001000", '1', "0000000000000100"),
			('1', "0000000000001000", '1', "0000000000001000"),
			('0', "0000000000010000", '0', "0000000000001000"),
			('1', "0000000000010000", '0', "0000000000001000"),
			('0', "0000000000010000", '1', "0000000000001000"),
			('1', "0000000000010000", '1', "0000000000010000"),
			('0', "0000000000100000", '0', "0000000000010000"),
			('1', "0000000000100000", '0', "0000000000010000"),
			('0', "0000000000100000", '1', "0000000000010000"),
			('1', "0000000000100000", '1', "0000000000100000"),
			('0', "0000000001000000", '0', "0000000000100000"),
			('1', "0000000001000000", '0', "0000000000100000"),
			('0', "0000000001000000", '1', "0000000000100000"),
			('1', "0000000001000000", '1', "0000000001000000"),
			('0', "0000000010000000", '0', "0000000001000000"),
			('1', "0000000010000000", '0', "0000000001000000"),
			('0', "0000000010000000", '1', "0000000001000000"),
			('1', "0000000010000000", '1', "0000000010000000"),
			('0', "0000000100000000", '0', "0000000010000000"),
			('1', "0000000100000000", '0', "0000000010000000"),
			('0', "0000000100000000", '1', "0000000010000000"),
			('1', "0000000100000000", '1', "0000000100000000"),
			('0', "0000001000000000", '0', "0000000100000000"),
			('1', "0000001000000000", '0', "0000000100000000"),
			('0', "0000001000000000", '1', "0000000100000000"),
			('1', "0000001000000000", '1', "0000001000000000"),
			('0', "0000010000000000", '0', "0000001000000000"),
			('1', "0000010000000000", '0', "0000001000000000"),
			('0', "0000010000000000", '1', "0000001000000000"),
			('1', "0000010000000000", '1', "0000010000000000"),
			('0', "0000100000000000", '0', "0000010000000000"),
			('1', "0000100000000000", '0', "0000010000000000"),
			('0', "0000100000000000", '1', "0000010000000000"),
			('1', "0000100000000000", '1', "0000100000000000"),
			('0', "0001000000000000", '0', "0000100000000000"),
			('1', "0001000000000000", '0', "0000100000000000"),
			('0', "0001000000000000", '1', "0000100000000000"),
			('1', "0001000000000000", '1', "0001000000000000"),
			('0', "0010000000000000", '0', "0001000000000000"),
			('1', "0010000000000000", '0', "0001000000000000"),
			('0', "0010000000000000", '1', "0001000000000000"),
			('1', "0010000000000000", '1', "0010000000000000"),
			('0', "0100000000000000", '0', "0010000000000000"),
			('1', "0100000000000000", '0', "0010000000000000"),
			('0', "0100000000000000", '1', "0010000000000000"),
			('1', "0100000000000000", '1', "0100000000000000"),
			('0', "1000000000000000", '0', "0100000000000000"),
			('1', "1000000000000000", '0', "0100000000000000"),
			('0', "1000000000000000", '1', "0100000000000000"),
			('1', "1000000000000000", '1', "1000000000000000"),
			('0', "1111111111111110", '0', "1000000000000000"),
			('1', "1111111111111110", '0', "1000000000000000"),
			('0', "1111111111111110", '1', "1000000000000000"),
			('1', "1111111111111110", '1', "1111111111111110"),
			('0', "1111111111111101", '0', "1111111111111110"),
			('1', "1111111111111101", '0', "1111111111111110"),
			('0', "1111111111111101", '1', "1111111111111110"),
			('1', "1111111111111101", '1', "1111111111111101"),
			('0', "1111111111111011", '0', "1111111111111101"),
			('1', "1111111111111011", '0', "1111111111111101"),
			('0', "1111111111111011", '1', "1111111111111101"),
			('1', "1111111111111011", '1', "1111111111111011"),
			('0', "1111111111110111", '0', "1111111111111011"),
			('1', "1111111111110111", '0', "1111111111111011"),
			('0', "1111111111110111", '1', "1111111111111011"),
			('1', "1111111111110111", '1', "1111111111110111"),
			('0', "1111111111101111", '0', "1111111111110111"),
			('1', "1111111111101111", '0', "1111111111110111"),
			('0', "1111111111101111", '1', "1111111111110111"),
			('1', "1111111111101111", '1', "1111111111101111"),
			('0', "1111111111011111", '0', "1111111111101111"),
			('1', "1111111111011111", '0', "1111111111101111"),
			('0', "1111111111011111", '1', "1111111111101111"),
			('1', "1111111111011111", '1', "1111111111011111"),
			('0', "1111111110111111", '0', "1111111111011111"),
			('1', "1111111110111111", '0', "1111111111011111"),
			('0', "1111111110111111", '1', "1111111111011111"),
			('1', "1111111110111111", '1', "1111111110111111"),
			('0', "1111111101111111", '0', "1111111110111111"),
			('1', "1111111101111111", '0', "1111111110111111"),
			('0', "1111111101111111", '1', "1111111110111111"),
			('1', "1111111101111111", '1', "1111111101111111"),
			('0', "1111111011111111", '0', "1111111101111111"),
			('1', "1111111011111111", '0', "1111111101111111"),
			('0', "1111111011111111", '1', "1111111101111111"),
			('1', "1111111011111111", '1', "1111111011111111"),
			('0', "1111110111111111", '0', "1111111011111111"),
			('1', "1111110111111111", '0', "1111111011111111"),
			('0', "1111110111111111", '1', "1111111011111111"),
			('1', "1111110111111111", '1', "1111110111111111"),
			('0', "1111101111111111", '0', "1111110111111111"),
			('1', "1111101111111111", '0', "1111110111111111"),
			('0', "1111101111111111", '1', "1111110111111111"),
			('1', "1111101111111111", '1', "1111101111111111"),
			('0', "1111011111111111", '0', "1111101111111111"),
			('1', "1111011111111111", '0', "1111101111111111"),
			('0', "1111011111111111", '1', "1111101111111111"),
			('1', "1111011111111111", '1', "1111011111111111"),
			('0', "1110111111111111", '0', "1111011111111111"),
			('1', "1110111111111111", '0', "1111011111111111"),
			('0', "1110111111111111", '1', "1111011111111111"),
			('1', "1110111111111111", '1', "1110111111111111"),
			('0', "1101111111111111", '0', "1110111111111111"),
			('1', "1101111111111111", '0', "1110111111111111"),
			('0', "1101111111111111", '1', "1110111111111111"),
			('1', "1101111111111111", '1', "1101111111111111"),
			('0', "1011111111111111", '0', "1101111111111111"),
			('1', "1011111111111111", '0', "1101111111111111"),
			('0', "1011111111111111", '1', "1101111111111111"),
			('1', "1011111111111111", '1', "1011111111111111"),
			('0', "0111111111111111", '0', "1011111111111111"),
			('1', "0111111111111111", '0', "1011111111111111"),
			('0', "0111111111111111", '1', "1011111111111111"),
			('1', "0111111111111111", '1', "0111111111111111")			
		);
		
	begin
		--  Init pattern before test.
		for i in init_patterns'range loop
			--  Set the inputs.
			clk <= init_patterns(i).clk;	
			in0 <= init_patterns(i).in0;					
			load0 <= init_patterns(i).load0;	
			wait for clk_period/2;
		end loop;

		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			clk <= patterns(i).clk;	
			in0 <= patterns(i).in0;					
			load0 <= patterns(i).load0;							
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