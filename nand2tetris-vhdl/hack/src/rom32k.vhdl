library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_textio.ALL;
use std.textio.all;

-- ROM using behavioral method for faster simulation, heavily inspired from
-- https://vhdlguide.readthedocs.io/en/latest/vhdl/dex.html#rom-implementation-using-ram-block-rom

entity rom32k is
	-- Read Only Memory of 32K registers, each 16 bit-wide.
	-- Access at addresses > 7FFF is forbidden.
	-- Init using init-rom.txt.
	port (
		addr0 : in std_logic_vector(0 to 15);
		out0 : out std_logic_vector(0 to 15)
	);
end rom32k;

architecture behavioral of rom32k is	
	type rom_type is array (0 to 2**15) of std_logic_vector (0 to 15);

	impure function init_ram_bin return rom_type is
		file text_file : text open read_mode is "init-rom.hack";
		variable text_line : line;
		variable rom_content : rom_type;

	  	begin
		for i in rom_type'range loop
			readline(text_file, text_line);
			read(text_line, rom_content(i));
		end loop;
	   
		return rom_content;
	end function;

	signal block_rom : rom_type := init_ram_bin;

begin
	-- read data from address 'addr0'
	-- convert 'addr0' type to integer from std_logic_vector
	out0 <= block_rom(to_integer(unsigned(addr0)));
end behavioral;
