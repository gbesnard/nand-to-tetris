library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.virtual_registers_array_package.all;

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
		out0 : out std_logic_vector(0 to 15);
		dbg_out_regs : out virtual_registers_array_t
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
	dbg_out_regs(0) <= ram_single_port(0);
	dbg_out_regs(1) <= ram_single_port(1);
	dbg_out_regs(2) <= ram_single_port(2);
	dbg_out_regs(3) <= ram_single_port(3);
	dbg_out_regs(4) <= ram_single_port(4);
	dbg_out_regs(5) <= ram_single_port(5);
	dbg_out_regs(6) <= ram_single_port(6);
	dbg_out_regs(7) <= ram_single_port(7);
	dbg_out_regs(8) <= ram_single_port(8);
	dbg_out_regs(9) <= ram_single_port(9);
	dbg_out_regs(10) <= ram_single_port(10);
	dbg_out_regs(11) <= ram_single_port(11);
	dbg_out_regs(12) <= ram_single_port(12);
	dbg_out_regs(13) <= ram_single_port(13);
	dbg_out_regs(14) <= ram_single_port(14);
	dbg_out_regs(15) <= ram_single_port(15);
end behavioral;
