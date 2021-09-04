library ieee;
use ieee.std_logic_1164.all;

entity pc is
 	-- A 16-bit counter with load and reset control bits.
	-- if      (reset[t] == 1) out[t+1] = 0
 	-- else if (load[t] == 1)  out[t+1] = in[t]
	-- else if (inc[t] == 1)   out[t+1] = out[t] + 1  (integer addition)
 	-- else                    out[t+1] = out[t] 
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		inc0 : in std_logic;
		reset0 : in std_logic;		
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15)
	);
end pc;

architecture rtl of pc is		
	signal l_out_mux0, l_out_mux1, l_reg_in, l_curr_reg_val, l_inc : std_logic_vector(0 to 15);
	signal l_or, l_reg_load: std_logic;

	--  Declaration of components that will be instantiated.
	component reg
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic; 
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component or_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	component inc16
		port (
			in0 : in std_logic_vector(0 to 15); 
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;

	component mux16_gate
		port(
			in0 : in std_logic_vector(0 to 15);
			in1 : in std_logic_vector(0 to 15);
			sel0 : in std_logic;
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	--  Specifies which entity is bound with the components.
	for reg_0: reg use entity work.reg;
	for or_gate_0: or_gate use entity work.or_gate;
	for or_gate_1: or_gate use entity work.or_gate;
	for inc16_0: inc16 use entity work.inc16;
	for mux16_gate_0: mux16_gate use entity work.mux16_gate;

begin
	-- set the register load if load asked, or if reset asked, ...
	or_gate_0: or_gate port map (
        	in0 => load0,
        	in1 => reset0,
        	out0 => l_or
	);

	-- ... or if inc asked
	or_gate_1: or_gate port map (
        	in0 => l_or,
        	in1 => inc0,
        	out0 => l_reg_load
	);

	-- increment
	inc16_0: inc16 port map (
		in0 => l_curr_reg_val, 
		out0 => l_inc
	);

	-- check increment
	mux16_gate_0: mux16_gate port map (
		in0 => l_curr_reg_val, 
		in1 => l_inc, 
		sel0 => inc0, 
		out0 => l_out_mux0
	);

	-- if load asked, use the input bus value, else work on the current register value
	mux16_gate_1: mux16_gate port map (
		in0 => l_out_mux0, 
		in1 => in0, 
		sel0 => load0, 
		out0 => l_out_mux1
	);

	-- if reset
	mux16_gate_2: mux16_gate port map (
		in0 => l_out_mux1, 
		in1 => "0000000000000000", 
		sel0 => reset0, 
		out0 => l_reg_in
	);

	reg_0: reg port map (
		in0 => l_reg_in, 
		load0 => l_reg_load,
		clk => clk, 
		out0 => l_curr_reg_val
	);

	out0 <= l_curr_reg_val;

end rtl;
