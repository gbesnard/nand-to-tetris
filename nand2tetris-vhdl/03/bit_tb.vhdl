library ieee;
use ieee.std_logic_1164.all;

entity bit_tb is
--  A testbench has no ports.
end bit_tb;

architecture behaviour of bit_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.	
	component bit
		port (
			in0 : in std_logic; 
			load0 : in std_logic; 
			clk : in std_logic; 
			out0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the component.
	for bit_0: bit use entity work.bit;
	signal in0, load0, clk, out0 : std_logic;

begin
	--  Component instantiation.
	bit_0: bit port map (
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
			in0 : std_logic;
			load0 : std_logic;
			--  The expected outputs.
			out0 : std_logic;
		end record;
		
		type pattern_array is array (natural range <>) of pattern_type;

		--  Init pattern to apply.
		constant init_patterns : pattern_array :=
		(	
			('1', '1', '1', 'U'),
			('0', '1', '1', 'U'),
			('1', '0', '1', 'U'),
			('0', '0', '1', 'U'),
			('1', '0', '0', 'U')
		);
		
		--  The patterns to apply.
		constant patterns : pattern_array :=
		(			
			('0', '0', '0', '0'),
			('1', '0', '0', '0'),
			('0', '0', '1', '0'),
			('1', '0', '1', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '1', '0'),
			('1', '1', '1', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '1', '0', '1'),
			('1', '1', '0', '1'),
			('0', '0', '1', '1'),
			('1', '0', '1', '0'),
			('0', '1', '1', '0'),
			('1', '1', '1', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '0', '1'),
			('1', '0', '0', '1'),
			('0', '0', '1', '1'),
			('1', '0', '1', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0'),
			('0', '1', '0', '0'),
			('1', '1', '0', '0')									
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
					& " out0 " & std_logic'image(out0) & " instead of " & std_logic'image(patterns(i).out0)
			severity error;
			--  Wait a block period.
			wait for clk_period/4;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
