library ieee;
use ieee.std_logic_1164.all;

entity dmux8way_gate is
	-- 8-way demultiplexor:
	-- {out0, out1, out2, out3, out4, out5, out6, out7} = {in0, 0, 0, 0, 0, 0, 0, 0} if sel0 == 000
	--                                                    {0, in0, 0, 0, 0, 0, 0, 0} if sel0 == 001
	--                                                    etc.
	--                                                    {0, 0, 0, 0, 0, 0, 0, in0} if sel0 == 111

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
end dmux8way_gate;

architecture rtl of dmux8way_gate is
	signal out_dmux_out0_out1_out2_out3 : std_logic;
	signal out_dmux_out4_out5_out6_out7 : std_logic;

	--  Declaration of the component that will be instantiated.
	component dmux_gate
        port (
            in0 : in std_logic;
            sel0 : in std_logic;
            out0 : out std_logic;
            out1 : out std_logic
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


	--  Specifies which entity is bound with the component.
	for dmux_gate_0 : dmux_gate use entity work.dmux_gate;
	for dmux4way_gate_0 : dmux4way_gate use entity work.dmux4way_gate;
	for dmux4way_gate_1 : dmux4way_gate use entity work.dmux4way_gate;

begin
	dmux_gate_0: dmux_gate port map (
		in0 => in0, 
		sel0 => sel0(0), 
		out0 => out_dmux_out0_out1_out2_out3, 
		out1 => out_dmux_out4_out5_out6_out7 
	);

	dmux4way_gate_0: dmux4way_gate port map (
		in0 => out_dmux_out0_out1_out2_out3, 
		sel0 => sel0(1 to 2), 
		out0 => out0, 
		out1 => out1,
		out2 => out2,
		out3 => out3
	);

	dmux4way_gate_1: dmux4way_gate port map (
		in0 => out_dmux_out4_out5_out6_out7, 
		sel0 => sel0(1 to 2), 
		out0 => out4, 
		out1 => out5,
		out2 => out6,
		out3 => out7
	);
end rtl;
