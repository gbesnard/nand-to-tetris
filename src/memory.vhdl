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
		dbg_keyboard_in : in std_logic_vector(0 to 15);
		out0 : out std_logic_vector(0 to 15);
		dbg_out_regs : out virtual_registers_array_t;
		dbg_out_screen : out screen_array_t;
		dbg_keyboard_out : out std_logic_vector(0 to 15)
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
		
	component not_gate
		port (
			in0 : in std_logic; 			
			out0 : out std_logic
		);
  	end component;		

	component and_gate
		port (
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
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

	component keyboard
		port (
			dbg_in0 : in std_logic_vector(0 to 15);
			dbg_load0 : in std_logic;		
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	signal is_screen_addr, is_keyboard_addr, is_ram_addr, is_not_keyboard_addr, is_not_screen_addr : std_logic;
	signal addr_bit_1, addr_bit_2, not_addr_bit_1, not_addr_bit_2 : std_logic;
	signal ram_out, screen_out, keyboard_out, keyboard_screen_out : std_logic_vector(0 to 15);
	signal ram_load, screen_load: std_logic;

begin	

	-- Check if accessing RAM, screen or keyboard memory.
	addr_bit_1 <= addr0(1);
	addr_bit_2 <= addr0(2);

	not_gate_0: not_gate port map (
        in0 => addr_bit_1,
        out0 => not_addr_bit_1
    );

	not_gate_1: not_gate port map (
        in0 => addr_bit_2,
        out0 => not_addr_bit_2
    );

	and_gate_0: and_gate port map (
		in0 => addr_bit_1, 
		in1 => addr_bit_2,
		out0 => is_keyboard_addr
	);

	and_gate_1: and_gate port map (
		in0 => addr_bit_1, 
		in1 => not_addr_bit_2,
		out0 => is_screen_addr
	);

	not_gate_2: not_gate port map (
        in0 => is_keyboard_addr,
        out0 => is_not_keyboard_addr
    );

	not_gate_3: not_gate port map (
        in0 => is_screen_addr,
        out0 => is_not_screen_addr
    );

	and_gate_2: and_gate port map (
		in0 => is_not_keyboard_addr, 
		in1 => is_not_screen_addr,
		out0 => is_ram_addr
	);

	-- Load choice depending on input addr.
	mux_gate_0: mux_gate port map (		
		in0 => '0',
		in1 => load0,
		sel0 => is_screen_addr, 
		out0 => screen_load
	);

	mux_gate_1: mux_gate port map (		
		in0 => '0',
		in1 => load0,
		sel0 => is_ram_addr, 
		out0 => ram_load
	);
	
	-- Out choice depending on input addr.
	mux16_gate_0: mux16_gate port map (		
		in0 => screen_out,
		in1 => keyboard_out,
		sel0 => is_keyboard_addr, 
		out0 => keyboard_screen_out
	);

	mux16_gate_1: mux16_gate port map (		
		in0 => keyboard_screen_out,
		in1 => ram_out,
		sel0 => is_ram_addr, 
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

	-- Keyboard memory.
	keyboard_0: keyboard port map (
		dbg_in0 => dbg_keyboard_in,		
		dbg_load0 => '1',		
		clk => clk,
		out0 => keyboard_out		
	);

	dbg_keyboard_out <= keyboard_out;

end rtl;
