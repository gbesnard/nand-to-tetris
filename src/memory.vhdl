library ieee;
use ieee.std_logic_1164.all;
use work.virtual_registers_array_package.all;
use work.screen_array_package.all;

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
	-- Access to address>0x6000 is invalid. Access to any address in 
	-- the range 0x4000-0x43FF results in accessing the screen memory 
	-- map. Access to address between 0x43FF and 0x6000 is invalid.
	-- Access to address 0x6000 results in accessing the keyboard 
	-- memory map. The behavior in these addresses is described in the 
	-- Screen and Keyboard chip specifications given in the book.
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		addr0 : in std_logic_vector(0 to 15);
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15);
		dbg_out_regs : out virtual_registers_array_t;
		dbg_out_screen : out screen_array_t
	);
end memory;

architecture rtl of memory is	

	--  Declaration of components that will be instantiated.
	component mux_gate
		port (
			in0 : in std_logic; 
			in1 : in std_logic; 
			sel0 : in std_logic; 
			out0 : out std_logic
		);
  	end component;

	component mux16_gate
		port (
			in0 : in std_logic_vector(0 to 15); 
			in1 : in std_logic_vector(0 to 15); 
			sel0 : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;

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

	component screen
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 9);
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15);
			dbg_out_screen : out screen_array_t
		);
	end component;

	--  Specifies which entity is bound with the components.
	for ram16k_fast_0: ram16k_fast use entity work.ram16k_fast;
	for screen_0: screen use entity work.screen;
	-- for mux_gate_0: mux_gate use entity work.mux_gate;
	for mux_gate_1: mux_gate use entity work.mux_gate;
	for mux16_gate_0: mux16_gate use entity work.mux16_gate;

	signal ram_out, screen_out, mux_out_out : std_logic_vector(0 to 15);
	signal ram_load, screen_load, mux_out_load : std_logic;
	signal sel_screen : std_logic;

begin	

	sel_screen <= addr0(1);

	-- Load choice depending on input addr.
	mux_gate_0: mux_gate port map (		
		in0 => '0',
		in1 => load0,
		sel0 => sel_screen, 
		out0 => screen_load
	);

	mux_gate_1: mux_gate port map (		
		in0 => load0,
		in1 => '0',
		sel0 => sel_screen, 
		out0 => ram_load
	);
	
	-- Out choice depending on input addr.
	mux16_gate_0: mux16_gate port map (		
		in0 => ram_out,
		in1 => screen_out,
		sel0 => sel_screen, 
		out0 => out0
	);

	-- RAM memory.
	ram16k_fast_0: ram16k_fast port map (
		in0 => in0,
		load0 => ram_load,
		addr0 => addr0(2 to 15),
		clk => clk,
		out0 => ram_out,
		dbg_out_regs => dbg_out_regs
	);

	-- Screen memory.
	screen_0: screen port map (
		in0 => in0,
		load0 => screen_load,
		addr0 => addr0(6 to 15),
		clk => clk,
		out0 => screen_out,
		dbg_out_screen => dbg_out_screen
	);

end rtl;
