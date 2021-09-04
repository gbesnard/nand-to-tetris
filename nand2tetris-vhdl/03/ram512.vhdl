library ieee;
use ieee.std_logic_1164.all;

entity ram512 is
	-- Memory of 512 registers, each 16 bit-wide. Out holds the value
	-- stored at the memory location specified by address. If load==1, then 
	-- the in value is loaded into the memory location specified by address 
	-- (the loaded value will be emitted to out from the next time step onward).
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		addr0 : in std_logic_vector(0 to 8);
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15)
	);
end ram512;

architecture rtl of ram512 is	
	signal l_out0, l_out1, l_out2, l_out3 : std_logic_vector(0 to 15) := "0000000000000000";
	signal l_out4, l_out5, l_out6, l_out7 : std_logic_vector(0 to 15) := "0000000000000000";
	signal l_load0, l_load1, l_load2, l_load3 : std_logic;
	signal l_load4, l_load5, l_load6, l_load7 : std_logic;

	--  Declaration of components that will be instantiated.
	component ram64
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 5);
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component mux8way16_gate
		port (
			in0 : in std_logic_vector(0 to 15);
			in1 : in std_logic_vector(0 to 15);
			in2 : in std_logic_vector(0 to 15);
			in3 : in std_logic_vector(0 to 15);
			in4 : in std_logic_vector(0 to 15);
			in5 : in std_logic_vector(0 to 15);
			in6 : std_logic_vector(0 to 15);
			in7 : std_logic_vector(0 to 15); 
			sel0 : in std_logic_vector(0 to 2); 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component dmux8way_gate
		port (
			in0 : in std_logic; 
			sel0 : in std_logic_vector(0 to 2);
			out0 : out std_logic;
			out1 : out std_logic;
			out2 : out std_logic;
			out3 : out std_logic;
			out4 : out std_logic;
			out5 : out std_logic;
			out6 : out std_logic;
			out7 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for ram64_0: ram64 use entity work.ram64;
	for ram64_1: ram64 use entity work.ram64;
	for ram64_2: ram64 use entity work.ram64;
	for ram64_3: ram64 use entity work.ram64;
	for ram64_4: ram64 use entity work.ram64;
	for ram64_5: ram64 use entity work.ram64;
	for ram64_6: ram64 use entity work.ram64;
	for ram64_7: ram64 use entity work.ram64;
	for mux8way16_gate_0: mux8way16_gate use entity work.mux8way16_gate;	
	for dmux8way_gate_0: dmux8way_gate use entity work.dmux8way_gate;	

begin

	ram64_0: ram64 port map (
		in0 => in0, 
		load0 => l_load0,
		addr0 => addr0(3 to 8),
		clk => clk, 
		out0 => l_out0
	);

	ram64_1: ram64 port map (
		in0 => in0, 
		load0 => l_load1,
		addr0 => addr0(3 to 8),
		clk => clk, 
		out0 => l_out1
	);

	ram64_2: ram64 port map (
		in0 => in0, 
		load0 => l_load2,
		addr0 => addr0(3 to 8),
		clk => clk, 
		out0 => l_out2
	);

	ram64_3: ram64 port map (
		in0 => in0, 
		load0 => l_load3,
		addr0 => addr0(3 to 8),
		clk => clk, 
		out0 => l_out3
	);

	ram64_4: ram64 port map (
		in0 => in0, 
		load0 => l_load4,
		addr0 => addr0(3 to 8),
		clk => clk, 
		out0 => l_out4
	);

	ram64_5: ram64 port map (
		in0 => in0, 
		load0 => l_load5,
		addr0 => addr0(3 to 8),
		clk => clk, 
		out0 => l_out5
	);

	ram64_6: ram64 port map (
		in0 => in0, 
		load0 => l_load6,
		addr0 => addr0(3 to 8),
		clk => clk, 
		out0 => l_out6
	);

	ram64_7: ram64 port map (
		in0 => in0, 
		load0 => l_load7,
		addr0 => addr0(3 to 8),
		clk => clk, 
		out0 => l_out7
	);

	mux8way16_gate_0: mux8way16_gate port map (
		in0 => l_out0, 
		in1 => l_out1, 
		in2 => l_out2, 
		in3 => l_out3, 
		in4 => l_out4, 
		in5 => l_out5, 
		in6 => l_out6, 
		in7 => l_out7, 
		sel0 => addr0(0 to 2), 
		out0 => out0
	);

	dmux8way_gate_0: dmux8way_gate port map (
		in0 => load0, 
		sel0 => addr0(0 to 2), 
		out0 => l_load0,
		out1 => l_load1,
		out2 => l_load2,
		out3 => l_load3,
		out4 => l_load4,
		out5 => l_load5,
		out6 => l_load6,
		out7 => l_load7
	);

end rtl;
