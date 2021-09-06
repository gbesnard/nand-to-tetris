library ieee;
use ieee.std_logic_1164.all;

library work;
use work.std_logic_vector_to_string_package.all;

entity pc_tb is
--  A testbench has no ports.
end pc_tb;

architecture behaviour of pc_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component pc
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			inc0 : in std_logic;
			reset0 : in std_logic;		
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for pc_0: pc use entity work.pc;
	signal load0, clk, inc0, reset0 : std_logic;
	signal in0 : std_logic_vector(0 to 15);
	signal out0 : std_logic_vector(0 to 15);	

begin
	--  Component instantiation.
	pc_0: pc port map (
		in0 => in0,
		load0 => load0,
		inc0 => inc0,
		reset0 => reset0,
		clk => clk,
		out0 => out0
	);

	--  This process does the real job.
	process

		type pattern_type is record
			--  The inputs.
			clk : std_logic;
			in0 : std_logic_vector(0 to 15);
			reset0 : std_logic;			
			load0 : std_logic;
			inc0 : std_logic;			
			--  The expected outputs.
			out0 : std_logic_vector(0 to 15);
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  The patterns to apply.
		constant patterns : pattern_array :=
		(	
			('0', "0000000000000000", '1', '0', '0', "UUUUUUUUUUUUUUUU"),		
			('1', "0000000000000000", '1', '0', '0', "0000000000000000"),		
			('0', "0000000000000000", '0', '0', '0', "0000000000000000"),
			('1', "0000000000000000", '0', '0', '0', "0000000000000000"),
			('0', "0000000000000000", '0', '0', '1', "0000000000000000"),
			('1', "0000000000000000", '0', '0', '1', "0000000000000001"),
			('0', "1000001010000101", '0', '0', '1', "0000000000000001"),
			('1', "1000001010000101", '0', '0', '1', "0000000000000010"),
			('0', "1000001010000101", '0', '1', '1', "0000000000000010"),
			('1', "1000001010000101", '0', '1', '1', "1000001010000101"),
			('0', "1000001010000101", '0', '0', '1', "1000001010000101"),
			('1', "1000001010000101", '0', '0', '1', "1000001010000110"),
			('0', "1000001010000101", '0', '0', '1', "1000001010000110"),
			('1', "1000001010000101", '0', '0', '1', "1000001010000111"),
			('0', "0011000000111001", '0', '1', '0', "1000001010000111"),
			('1', "0011000000111001", '0', '1', '0', "0011000000111001"),
			('0', "0011000000111001", '1', '1', '0', "0011000000111001"),
			('1', "0011000000111001", '1', '1', '0', "0000000000000000"),
			('0', "0011000000111001", '0', '1', '1', "0000000000000000"),
			('1', "0011000000111001", '0', '1', '1', "0011000000111001"),
			('0', "0011000000111001", '1', '1', '1', "0011000000111001"),
			('1', "0011000000111001", '1', '1', '1', "0000000000000000"),
			('0', "0011000000111001", '0', '0', '1', "0000000000000000"),
			('1', "0011000000111001", '0', '0', '1', "0000000000000001"),
			('0', "0011000000111001", '1', '0', '1', "0000000000000001"),
			('1', "0011000000111001", '1', '0', '1', "0000000000000000"),
			('0', "0000000000000000", '0', '1', '1', "0000000000000000"),
			('1', "0000000000000000", '0', '1', '1', "0000000000000000"),
			('0', "0000000000000000", '0', '0', '1', "0000000000000000"),
			('1', "0000000000000000", '0', '0', '1', "0000000000000001"),
			('0', "0101011011001110", '1', '0', '0', "0000000000000001"),
			('1', "0101011011001110", '1', '0', '0', "0000000000000000")						
		);			
		
	begin

		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			clk <= patterns(i).clk;	
			in0 <= patterns(i).in0;	
			reset0 <= patterns(i).reset0;				
			load0 <= patterns(i).load0;	
			inc0 <= patterns(i).inc0;
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
