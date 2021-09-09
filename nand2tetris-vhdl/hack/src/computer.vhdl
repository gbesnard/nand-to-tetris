library ieee;
use ieee.std_logic_1164.all;

entity computer is	
	-- The HACK computer, including CPU, ROM and RAM.
	-- When reset is 0, the program stored in the computer's ROM executes.
	-- When reset is 1, the execution of the program restarts. 
	-- Thus, to start a program's execution, reset must be pushed "up" (1)
	-- and "down" (0). From this point onward the user is at the mercy of 
	-- the software.
	port (
		reset : in std_logic;
		clk : in std_logic
	);
end computer;

architecture rtl of computer is	

	signal l_pc : std_logic_vector(0 to 15);
	signal l_instruction : std_logic_vector(0 to 15);
	signal l_in_mem : std_logic_vector(0 to 15);
	signal l_out_mem : std_logic_vector(0 to 15);
	signal l_addr_mem : std_logic_vector(0 to 15);
	signal l_out_dbg : std_logic_vector(0 to 15);
	signal l_write_mem : std_logic;

	--  Declaration of components that will be instantiated.
	component rom32k
		port (
			addr0 : in std_logic_vector(0 to 15);
			out0 : out std_logic_vector(0 to 15)
		);
	end component;
	
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

	component ram16k_fast
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 13);
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the components.
	for rom32k_0: rom32k use entity work.rom32k;
	for cpu_0: cpu use entity work.cpu;
	for ram16k_fast_0: ram16k_fast use entity work.ram16k_fast;

begin

	rom32k_0: rom32k port map (
		addr0 => l_pc,
		out0 => l_instruction
	);

	cpu_0: cpu port map (
		in_mem => l_in_mem,
		instruction => l_instruction,
		reset => reset,
		clk => clk,
		out_mem => l_out_mem,
		write_mem => l_write_mem,
		addr_mem => l_addr_mem,
		out_pc => l_pc,
		out_dbg => l_out_dbg
	);

	ram16k_fast_0: ram16k_fast port map (
		in0 => l_out_mem,
		load0 => l_write_mem,
		addr0 => l_addr_mem(2 to 15),
		clk => clk,
		out0 => l_in_mem
	);

end rtl;
