library ieee;
use ieee.std_logic_1164.all;

library work;
use work.std_logic_vector_to_string_package.all;

entity ram8_tb is
--  A testbench has no ports.
end ram8_tb;

architecture behaviour of ram8_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component ram8
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 2);
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the component.
	for ram8_0: ram8 use entity work.ram8;
	signal load0, clk : std_logic;
	signal in0, out0 : std_logic_vector(0 to 15);
	signal addr0 : std_logic_vector(0 to 2);

begin
	--  Component instantiation.
	ram8_0: ram8 port map (
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
			addr0 : std_logic_vector(0 to 2);
			--  The expected outputs.
			out0 : std_logic_vector(0 to 15);
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  The patterns to apply.
		constant patterns : pattern_array :=
		(			
			('0', "0000000000000000", '0', "000", "0000000000000000"),
			('1', "0000000000000000", '0', "000", "0000000000000000"),
			('0', "0000000000000000", '1', "000", "0000000000000000"),
			('1', "0000000000000000", '1', "000", "0000000000000000"),
			('0', "0010101101100111", '0', "000", "0000000000000000"),
			('1', "0010101101100111", '0', "000", "0000000000000000"),
			('0', "0010101101100111", '1', "001", "0000000000000000"),
			('1', "0010101101100111", '1', "001", "0010101101100111"),
			('0', "0010101101100111", '0', "000", "0000000000000000"),
			('1', "0010101101100111", '0', "000", "0000000000000000"),
			('0', "0000110100000101", '0', "011", "0000000000000000"),
			('1', "0000110100000101", '0', "011", "0000000000000000"),
			('0', "0000110100000101", '1', "011", "0000000000000000"),
			('1', "0000110100000101", '1', "011", "0000110100000101"),
			('0', "0000110100000101", '0', "011", "0000110100000101"),
			('1', "0000110100000101", '0', "011", "0000110100000101"),
			('1', "0000110100000101", '0', "001", "0010101101100111"),
			('0', "0001111001100001", '0', "001", "0010101101100111"),
			('1', "0001111001100001", '0', "001", "0010101101100111"),
			('0', "0001111001100001", '1', "111", "0000000000000000"),
			('1', "0001111001100001", '1', "111", "0001111001100001"),
			('0', "0001111001100001", '0', "111", "0001111001100001"),
			('1', "0001111001100001", '0', "111", "0001111001100001"),
			('1', "0001111001100001", '0', "011", "0000110100000101"),
			('1', "0001111001100001", '0', "111", "0001111001100001"),
			('0', "0001111001100001", '0', "000", "0000000000000000"),
			('1', "0001111001100001", '0', "000", "0000000000000000"),
			('1', "0001111001100001", '0', "001", "0010101101100111"),
			('1', "0001111001100001", '0', "010", "0000000000000000"),
			('1', "0001111001100001", '0', "011", "0000110100000101"),
			('1', "0001111001100001", '0', "100", "0000000000000000"),
			('1', "0001111001100001", '0', "101", "0000000000000000"),
			('1', "0001111001100001", '0', "110", "0000000000000000"),
			('1', "0001111001100001", '0', "111", "0001111001100001"),
			('0', "0101010101010101", '1', "000", "0000000000000000"),
			('1', "0101010101010101", '1', "000", "0101010101010101"),
			('0', "0101010101010101", '1', "001", "0010101101100111"),
			('1', "0101010101010101", '1', "001", "0101010101010101"),
			('0', "0101010101010101", '1', "010", "0000000000000000"),
			('1', "0101010101010101", '1', "010", "0101010101010101"),
			('0', "0101010101010101", '1', "011", "0000110100000101"),
			('1', "0101010101010101", '1', "011", "0101010101010101"),
			('0', "0101010101010101", '1', "100", "0000000000000000"),
			('1', "0101010101010101", '1', "100", "0101010101010101"),
			('0', "0101010101010101", '1', "101", "0000000000000000"),
			('1', "0101010101010101", '1', "101", "0101010101010101"),
			('0', "0101010101010101", '1', "110", "0000000000000000"),
			('1', "0101010101010101", '1', "110", "0101010101010101"),
			('0', "0101010101010101", '1', "111", "0001111001100001"),
			('1', "0101010101010101", '1', "111", "0101010101010101"),
			('0', "0101010101010101", '0', "000", "0101010101010101"),
			('1', "0101010101010101", '0', "000", "0101010101010101"),
			('1', "0101010101010101", '0', "001", "0101010101010101"),
			('1', "0101010101010101", '0', "010", "0101010101010101"),
			('1', "0101010101010101", '0', "011", "0101010101010101"),
			('1', "0101010101010101", '0', "100", "0101010101010101"),
			('1', "0101010101010101", '0', "101", "0101010101010101"),
			('1', "0101010101010101", '0', "110", "0101010101010101"),
			('1', "0101010101010101", '0', "111", "0101010101010101"),
			('0', "1010101010101010", '1', "000", "0101010101010101"),
			('1', "1010101010101010", '1', "000", "1010101010101010"),
			('0', "1010101010101010", '0', "000", "1010101010101010"),
			('1', "1010101010101010", '0', "000", "1010101010101010"),
			('1', "1010101010101010", '0', "001", "0101010101010101"),
			('1', "1010101010101010", '0', "010", "0101010101010101"),
			('1', "1010101010101010", '0', "011", "0101010101010101"),
			('1', "1010101010101010", '0', "100", "0101010101010101"),
			('1', "1010101010101010", '0', "101", "0101010101010101"),
			('1', "1010101010101010", '0', "110", "0101010101010101"),
			('1', "1010101010101010", '0', "111", "0101010101010101"),
			('0', "0101010101010101", '1', "000", "1010101010101010"),
			('1', "0101010101010101", '1', "000", "0101010101010101"),
			('0', "1010101010101010", '1', "001", "0101010101010101"),
			('1', "1010101010101010", '1', "001", "1010101010101010"),
			('0', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "001", "1010101010101010"),
			('1', "1010101010101010", '0', "010", "0101010101010101"),
			('1', "1010101010101010", '0', "011", "0101010101010101"),
			('1', "1010101010101010", '0', "100", "0101010101010101"),
			('1', "1010101010101010", '0', "101", "0101010101010101"),
			('1', "1010101010101010", '0', "110", "0101010101010101"),
			('1', "1010101010101010", '0', "111", "0101010101010101"),
			('0', "0101010101010101", '1', "001", "1010101010101010"),
			('1', "0101010101010101", '1', "001", "0101010101010101"),
			('0', "1010101010101010", '1', "010", "0101010101010101"),
			('1', "1010101010101010", '1', "010", "1010101010101010"),
			('0', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "001", "0101010101010101"),
			('1', "1010101010101010", '0', "010", "1010101010101010"),
			('1', "1010101010101010", '0', "011", "0101010101010101"),
			('1', "1010101010101010", '0', "100", "0101010101010101"),
			('1', "1010101010101010", '0', "101", "0101010101010101"),
			('1', "1010101010101010", '0', "110", "0101010101010101"),
			('1', "1010101010101010", '0', "111", "0101010101010101"),
			('0', "0101010101010101", '1', "010", "1010101010101010"),
			('1', "0101010101010101", '1', "010", "0101010101010101"),
			('0', "1010101010101010", '1', "011", "0101010101010101"),
			('1', "1010101010101010", '1', "011", "1010101010101010"),
			('0', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "001", "0101010101010101"),
			('1', "1010101010101010", '0', "010", "0101010101010101"),
			('1', "1010101010101010", '0', "011", "1010101010101010"),
			('1', "1010101010101010", '0', "100", "0101010101010101"),
			('1', "1010101010101010", '0', "101", "0101010101010101"),
			('1', "1010101010101010", '0', "110", "0101010101010101"),
			('1', "1010101010101010", '0', "111", "0101010101010101"),
			('0', "0101010101010101", '1', "011", "1010101010101010"),
			('1', "0101010101010101", '1', "011", "0101010101010101"),
			('0', "1010101010101010", '1', "100", "0101010101010101"),
			('1', "1010101010101010", '1', "100", "1010101010101010"),
			('0', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "001", "0101010101010101"),
			('1', "1010101010101010", '0', "010", "0101010101010101"),
			('1', "1010101010101010", '0', "011", "0101010101010101"),
			('1', "1010101010101010", '0', "100", "1010101010101010"),
			('1', "1010101010101010", '0', "101", "0101010101010101"),
			('1', "1010101010101010", '0', "110", "0101010101010101"),
			('1', "1010101010101010", '0', "111", "0101010101010101"),
			('0', "0101010101010101", '1', "100", "1010101010101010"),
			('1', "0101010101010101", '1', "100", "0101010101010101"),
			('0', "1010101010101010", '1', "101", "0101010101010101"),
			('1', "1010101010101010", '1', "101", "1010101010101010"),
			('0', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "001", "0101010101010101"),
			('1', "1010101010101010", '0', "010", "0101010101010101"),
			('1', "1010101010101010", '0', "011", "0101010101010101"),
			('1', "1010101010101010", '0', "100", "0101010101010101"),
			('1', "1010101010101010", '0', "101", "1010101010101010"),
			('1', "1010101010101010", '0', "110", "0101010101010101"),
			('1', "1010101010101010", '0', "111", "0101010101010101"),
			('0', "0101010101010101", '1', "101", "1010101010101010"),
			('1', "0101010101010101", '1', "101", "0101010101010101"),
			('0', "1010101010101010", '1', "110", "0101010101010101"),
			('1', "1010101010101010", '1', "110", "1010101010101010"),
			('0', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "001", "0101010101010101"),
			('1', "1010101010101010", '0', "010", "0101010101010101"),
			('1', "1010101010101010", '0', "011", "0101010101010101"),
			('1', "1010101010101010", '0', "100", "0101010101010101"),
			('1', "1010101010101010", '0', "101", "0101010101010101"),
			('1', "1010101010101010", '0', "110", "1010101010101010"),
			('1', "1010101010101010", '0', "111", "0101010101010101"),
			('0', "0101010101010101", '1', "110", "1010101010101010"),
			('1', "0101010101010101", '1', "110", "0101010101010101"),
			('0', "1010101010101010", '1', "111", "0101010101010101"),
			('1', "1010101010101010", '1', "111", "1010101010101010"),
			('0', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "000", "0101010101010101"),
			('1', "1010101010101010", '0', "001", "0101010101010101"),
			('1', "1010101010101010", '0', "010", "0101010101010101"),
			('1', "1010101010101010", '0', "011", "0101010101010101"),
			('1', "1010101010101010", '0', "100", "0101010101010101"),
			('1', "1010101010101010", '0', "101", "0101010101010101"),
			('1', "1010101010101010", '0', "110", "0101010101010101"),
			('1', "1010101010101010", '0', "111", "1010101010101010"),
			('0', "0101010101010101", '1', "111", "1010101010101010"),
			('1', "0101010101010101", '1', "111", "0101010101010101"),
			('0', "0101010101010101", '0', "000", "0101010101010101"),
			('1', "0101010101010101", '0', "000", "0101010101010101"),
			('1', "0101010101010101", '0', "001", "0101010101010101"),
			('1', "0101010101010101", '0', "010", "0101010101010101"),
			('1', "0101010101010101", '0', "011", "0101010101010101"),
			('1', "0101010101010101", '0', "100", "0101010101010101"),
			('1', "0101010101010101", '0', "101", "0101010101010101"),
			('1', "0101010101010101", '0', "110", "0101010101010101"),
			('1', "0101010101010101", '0', "111", "0101010101010101")
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