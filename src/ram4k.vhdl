library ieee;
use ieee.std_logic_1164.all;

entity ram4k is
	-- Memory of 4K registers, each 16 bit-wide. Out holds the value
	-- stored at the memory location specified by address. If load==1, then 
	-- the in value is loaded into the memory location specified by address 
	-- (the loaded value will be emitted to out from the next time step onward).
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		addr0 : in std_logic_vector(0 to 11);
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15)
	);
end ram4k;

architecture rtl of ram4k is	
	signal l_out0, l_out1, l_out2, l_out3 : std_logic_vector(0 to 15) := "0000000000000000";
	signal l_out4, l_out5, l_out6, l_out7 : std_logic_vector(0 to 15) := "0000000000000000";
	signal l_load0, l_load1, l_load2, l_load3 : std_logic;
	signal l_load4, l_load5, l_load6, l_load7 : std_logic;

	--  Declaration of components that will be instantiated.
	component ram512
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 8);
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
	for ram512_0: ram512 use entity work.ram512;
	for ram512_1: ram512 use entity work.ram512;
	for ram512_2: ram512 use entity work.ram512;
	for ram512_3: ram512 use entity work.ram512;
	for ram512_4: ram512 use entity work.ram512;
	for ram512_5: ram512 use entity work.ram512;
	for ram512_6: ram512 use entity work.ram512;
	for ram512_7: ram512 use entity work.ram512;
	for mux8way16_gate_0: mux8way16_gate use entity work.mux8way16_gate;	
	for dmux8way_gate_0: dmux8way_gate use entity work.dmux8way_gate;	

begin

	ram512_0: ram512 port map (
		in0 => in0, 
		load0 => l_load0,
		addr0 => addr0(3 to 11),
		clk => clk, 
		out0 => l_out0
	);

	ram512_1: ram512 port map (
		in0 => in0, 
		load0 => l_load1,
		addr0 => addr0(3 to 11),
		clk => clk, 
		out0 => l_out1
	);

	ram512_2: ram512 port map (
		in0 => in0, 
		load0 => l_load2,
		addr0 => addr0(3 to 11),
		clk => clk, 
		out0 => l_out2
	);

	ram512_3: ram512 port map (
		in0 => in0, 
		load0 => l_load3,
		addr0 => addr0(3 to 11),
		clk => clk, 
		out0 => l_out3
	);

	ram512_4: ram512 port map (
		in0 => in0, 
		load0 => l_load4,
		addr0 => addr0(3 to 11),
		clk => clk, 
		out0 => l_out4
	);

	ram512_5: ram512 port map (
		in0 => in0, 
		load0 => l_load5,
		addr0 => addr0(3 to 11),
		clk => clk, 
		out0 => l_out5
	);

	ram512_6: ram512 port map (
		in0 => in0, 
		load0 => l_load6,
		addr0 => addr0(3 to 11),
		clk => clk, 
		out0 => l_out6
	);

	ram512_7: ram512 port map (
		in0 => in0, 
		load0 => l_load7,
		addr0 => addr0(3 to 11),
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
