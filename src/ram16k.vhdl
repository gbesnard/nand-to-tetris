library ieee;
use ieee.std_logic_1164.all;

entity ram16k is
	-- Memory of 16K registers, each 16 bit-wide. Out holds the value
	-- stored at the memory location specified by address. If load==1, then 
	-- the in value is loaded into the memory location specified by address 
	-- (the loaded value will be emitted to out from the next time step onward).
	port (
		in0 : in std_logic_vector(0 to 15);
		load0 : in std_logic;
		addr0 : in std_logic_vector(0 to 13);
		clk : in std_logic; 
		out0 : out std_logic_vector(0 to 15)
	);
end ram16k;

architecture rtl of ram16k is	
	signal l_out0, l_out1, l_out2, l_out3 : std_logic_vector(0 to 15) := "0000000000000000";	
	signal l_load0, l_load1, l_load2, l_load3 : std_logic;

	--  Declaration of components that will be instantiated.
	component ram4k
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			addr0 : in std_logic_vector(0 to 11);
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component mux4way16_gate
		port (
			in0 : in std_logic_vector(0 to 15);
			in1 : in std_logic_vector(0 to 15);
			in2 : in std_logic_vector(0 to 15);
			in3 : in std_logic_vector(0 to 15);
			sel0 : in std_logic_vector(0 to 1); 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component dmux4way_gate
		port (
			in0 : in std_logic; 
			sel0 : in std_logic_vector(0 to 1);
			out0 : out std_logic;
			out1 : out std_logic;
			out2 : out std_logic;
			out3 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for ram4k_0: ram4k use entity work.ram4k;
	for ram4k_1: ram4k use entity work.ram4k;
	for ram4k_2: ram4k use entity work.ram4k;
	for ram4k_3: ram4k use entity work.ram4k;
	for mux4way16_gate_0: mux4way16_gate use entity work.mux4way16_gate;	
	for dmux4way_gate_0: dmux4way_gate use entity work.dmux4way_gate;	

begin

	ram4k_0: ram4k port map (
		in0 => in0, 
		load0 => l_load0,
		addr0 => addr0(2 to 13),
		clk => clk, 
		out0 => l_out0
	);

	ram4k_1: ram4k port map (
		in0 => in0, 
		load0 => l_load1,
		addr0 => addr0(2 to 13),
		clk => clk, 
		out0 => l_out1
	);

	ram4k_2: ram4k port map (
		in0 => in0, 
		load0 => l_load2,
		addr0 => addr0(2 to 13),
		clk => clk, 
		out0 => l_out2
	);

	ram4k_3: ram4k port map (
		in0 => in0, 
		load0 => l_load3,
		addr0 => addr0(2 to 13),
		clk => clk, 
		out0 => l_out3
	);

	mux4way16_gate_0: mux4way16_gate port map (
		in0 => l_out0, 
		in1 => l_out1, 
		in2 => l_out2, 
		in3 => l_out3,
		sel0 => addr0(0 to 1), 
		out0 => out0
	);

	dmux4way_gate_0: dmux4way_gate port map (
		in0 => load0, 
		sel0 => addr0(0 to 1), 
		out0 => l_load0,
		out1 => l_load1,
		out2 => l_load2,
		out3 => l_load3
	);

end rtl;
