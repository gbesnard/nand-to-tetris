library ieee;
use ieee.std_logic_1164.all;

entity reg is
	-- 1-bit register:
	-- If load[t] == 1 then out[t+1] = in[t]
	-- else out does not change (out[t+1] = out[t])
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic; 
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15)
	);
end reg;

architecture rtl of reg is	

	--  Declaration of components that will be instantiated.
	component bit
		port (
			in0 : in std_logic; 
			load0 : in std_logic; 
			clk : in std_logic; 
			out0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for bit_0: bit use entity work.bit;
	for bit_1: bit use entity work.bit;
	for bit_2: bit use entity work.bit;
	for bit_3: bit use entity work.bit;
	for bit_4: bit use entity work.bit;
	for bit_5: bit use entity work.bit;
	for bit_6: bit use entity work.bit;
	for bit_7: bit use entity work.bit;
	for bit_8: bit use entity work.bit;
	for bit_9: bit use entity work.bit;
	for bit_10: bit use entity work.bit;
	for bit_11: bit use entity work.bit;
	for bit_12: bit use entity work.bit;
	for bit_13: bit use entity work.bit;
	for bit_14: bit use entity work.bit;
	for bit_15: bit use entity work.bit;	

begin

	bit_0: bit port map (
		in0 => in0(0), 
		load0 => load0,
		clk => clk, 
		out0 => out0(0)
	);

	bit_1: bit port map (
		in0 => in0(1), 
		load0 => load0,
		clk => clk, 
		out0 => out0(1)
	);

	bit_2: bit port map (
		in0 => in0(2), 
		load0 => load0,
		clk => clk, 
		out0 => out0(2)
	);

	bit_3: bit port map (
		in0 => in0(3), 
		load0 => load0,
		clk => clk, 
		out0 => out0(3)
	);

	bit_4: bit port map (
		in0 => in0(4), 
		load0 => load0,
		clk => clk, 
		out0 => out0(4)
	);

	bit_5: bit port map (
		in0 => in0(5), 
		load0 => load0,
		clk => clk, 
		out0 => out0(5)
	);

	bit_6: bit port map (
		in0 => in0(6), 
		load0 => load0,
		clk => clk, 
		out0 => out0(6)
	);

	bit_7: bit port map (
		in0 => in0(7), 
		load0 => load0,
		clk => clk, 
		out0 => out0(7)
	);

	bit_8: bit port map (
		in0 => in0(8), 
		load0 => load0,
		clk => clk, 
		out0 => out0(8)
	);

	bit_9: bit port map (
		in0 => in0(9), 
		load0 => load0,
		clk => clk, 
		out0 => out0(9)
	);

	bit_10: bit port map (
		in0 => in0(10), 
		load0 => load0,
		clk => clk, 
		out0 => out0(10)
	);

	bit_11: bit port map (
		in0 => in0(11), 
		load0 => load0,
		clk => clk, 
		out0 => out0(11)
	);

	bit_12: bit port map (
		in0 => in0(12), 
		load0 => load0,
		clk => clk, 
		out0 => out0(12)
	);

	bit_13: bit port map (
		in0 => in0(13), 
		load0 => load0,
		clk => clk, 
		out0 => out0(13)
	);

	bit_14: bit port map (
		in0 => in0(14), 
		load0 => load0,
		clk => clk, 
		out0 => out0(14)
	);

	bit_15: bit port map (
		in0 => in0(15), 
		load0 => load0,
		clk => clk, 
		out0 => out0(15)
	);

end rtl;
