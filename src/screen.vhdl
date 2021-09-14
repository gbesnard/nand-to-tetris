library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.screen_array_package.all;

entity screen is
	-- The Screen (memory map) functions exactly like a 16-bit, 8K RAM:
	-- (1) out(t) = Screen[address(t)](t)
	-- (2) if load(t) then Screen[address(t)](t+1) = in(t)
	-- The chip implementation has the side effect of continuously refreshing a physical
	-- screen. The physical screen consists of 16 rows and 64 columns of black and white
	-- pixels (simulators of the Hack computer are expected to simulate this screen).
	-- Each pixels in the physical screen is represented by one 16-bit words.
	-- Huge waste of space compared to original implementation, but quicker to set up,
	-- and we have some free space because our screen is smaller.
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		addr0 : in std_logic_vector(0 to 9);
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15);
		dbg_out_screen : out screen_array_t
	);
end screen;

architecture behavioral of screen is	
	signal screen_port : screen_array_t := (0 to 1023 => "0000000000000000");

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if (load0 = '1') then -- write data to address addr0
				--convert 'addr0' type to integer from std_logic_vector
				screen_port(to_integer(unsigned(addr0))) <= in0;				
			end if;			
		end if;
	end process;

	-- read data from address 'addr0'
	-- convert 'addr0' type to integer from std_logic_vector
	out0 <= screen_port(to_integer(unsigned(addr0)));
	
	dbg_out_screen <= screen_port;

end behavioral;
