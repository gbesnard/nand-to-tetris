library ieee;
use ieee. std_logic_1164.all;
 
entity dff is
	-- D Flip Flop.
	-- out0(t) = in0(t-1)
	port (
		in0 : in std_logic;
		clk : in std_logic;
		out0 : out std_logic
	);
end dff;
 
architecture behavioral of dff is
	signal l_out : std_logic := '0';
begin
	process(clk)
	begin
	if rising_edge(clk) then
		l_out <= in0;
	end if;
	end process;

	out0 <= l_out;
end behavioral;
