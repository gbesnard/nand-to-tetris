library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- RAM using behavioral method for faster simulation, heavily inspired from
-- https://vhdlguide.readthedocs.io/en/latest/vhdl/dex.html#single-port-ram

entity ram16k_fast is
	-- Memory of 16K registers, each 16 bit-wide. Out holds the value
	-- stored at the memory location specified by address. If load==1, then 
	-- the in value is loaded into the memory location specified by address 
	-- (the loaded value will be emitted to out from the next time step onward).
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		addr0 : in std_logic_vector(0 to 13);
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15)
	);
end ram16k_fast;

architecture behavioral of ram16k_fast is	
	type ram_type is array (0 to 2**14) of std_logic_vector (0 to 15);
	signal ram_single_port : ram_type := (0 to 2**14 => "0000000000000000");

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if (load0 = '1') then -- write data to address addr0
				--convert 'addr0' type to integer from std_logic_vector
				ram_single_port(to_integer(unsigned(addr0))) <= in0;
			end if;
		end if;
	end process;

	-- read data from address 'addr0'
	-- convert 'addr0' type to integer from std_logic_vector
	out0 <= ram_single_port(to_integer(unsigned(addr0)));
end behavioral;
