library ieee;
use ieee.std_logic_1164.all;
use work.virtual_registers_array_package.all;

entity memory is
	-- The complete address space of the Hack computer's memory,
	-- including RAM and memory-mapped I/O. 
	-- The chip facilitates read and write operations, as follows:
	--     Read:  out(t) = Memory[address(t)](t)
	--     Write: if load(t-1) then Memory[address(t-1)](t) = in(t-1)
	-- In words: the chip always outputs the value stored at the memory 
	-- location specified by address. If load==1, the in value is loaded 
	-- into the memory location specified by address. This value becomes 
	-- available through the out output from the next time step onward.
	-- Address space rules:
	-- Only the upper 16K+8K+1 words of the Memory chip are used. 
	-- Access to address>0x6000 is invalid. Access to any address in 
	-- the range 0x4000-0x44FF results in accessing the screen memory 
	-- map.  Access to address between 0x44FF and 0x6000 is invalid.
	-- Access to address 0x6000 results in accessing the keyboard 
	-- memory map. The behavior in these addresses is described in the 
	-- Screen and Keyboard chip specifications given in the book.
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		addr0 : in std_logic_vector(0 to 15);
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15);
		dbg_out_regs : out virtual_registers_array_t
	);
end memory;

architecture rtl of memory is	

	--  Declaration of components that will be instantiated.
	component ram16k_fast
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		addr0 : in std_logic_vector(0 to 13);
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15);
		dbg_out_regs : out virtual_registers_array_t
	);
	end component;

	--  Specifies which entity is bound with the components.
	for ram16k_fast_0: ram16k_fast use entity work.ram16k_fast;

begin	

	ram16k_fast_0: ram16k_fast port map (
		in0 => in0,
		load0 => load0,
		addr0 => addr0(2 to 15),
		clk => clk,
		out0 => out0,
		dbg_out_regs => dbg_out_regs
	);

end rtl;
