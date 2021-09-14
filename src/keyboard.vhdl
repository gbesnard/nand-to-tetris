library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.screen_array_package.all;

entity keyboard is
	-- The Keyboard (memory map) is connected to a standard, physical
	-- keyboard. It is made to output the 16-bit scan-code associated with the
	-- key which is presently pressed on the physical keyboard, or 0 if no key is
	-- pressed.
	-- Simulators of the Hack computer are expected to implement the contract
	-- described above.
	port (
		dbg_in0 : in std_logic_vector(0 to 15);
		dbg_load0 : in std_logic;		
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15)
	);
end keyboard;

architecture rtl of keyboard is		
	--  Declaration of components that will be instantiated.
	component reg
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic; 
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the components.
	for reg_0: reg use entity work.reg;

begin	

	reg_0: reg port map (
		in0 => dbg_in0,
		load0 => dbg_load0,
		clk => clk, 
		out0 => out0
	);

end rtl;

