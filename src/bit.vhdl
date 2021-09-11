library ieee;
use ieee.std_logic_1164.all;

entity bit is	
	-- 1-bit register:
	-- If load[t] == 1 then out[t+1] = in[t]
	--                 else out does not change (out[t+1] = out[t])
	port (
		in0 : in std_logic; 
		load0 : in std_logic; 
		clk : in std_logic; 
		out0 : out std_logic
	);
end bit;

architecture rtl of bit is	
	signal mem, muxout, dffout : std_logic;

	--  Declaration of components that will be instantiated.
	component mux_gate
		port (
			in0 : in std_logic; 
			in1 : in std_logic; 
			sel0 : in std_logic; 
			out0 : out std_logic
		);
  	end component;

	component dff
		port (
			in0 : in std_logic; 
			clk : in std_logic; 
			out0 : out std_logic
		);
  	end component;

	--  Specifies which entity is bound with the components.
	for mux_gate_0: mux_gate use entity work.mux_gate;
	for dff_0: dff use entity work.dff;

begin

	mux_gate_0: mux_gate port map (		
		in0 => mem,
		in1 => in0,
		sel0 => load0, 
		out0 => muxout
	);

	dff_0: dff port map (
        in0 => muxout,
	 	clk => clk,
	 	out0 => dffout
	);

	mem <= dffout;
	out0 <= dffout;

end rtl;
