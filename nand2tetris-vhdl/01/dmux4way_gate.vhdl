library ieee;
use ieee.std_logic_1164.all;

entity dmux4way_gate is
	-- 4-way demultiplexor:
	-- {out0, out1, out2, out3} = {in0, 0, 0, 0} if sel0 == 00
	--                            {0, in0, 0, 0} if sel0 == 01
	--                            {0, 0, in0, 0} if sel0 == 10
	--                            {0, 0, 0, in0} if sel0 == 11

	port (
		in0 : in std_logic; 
		sel0 : in std_logic_vector(0 to 1); 
		out0 : out std_logic;
		out1 : out std_logic;
		out2 : out std_logic;
		out3 : out std_logic
	);
end dmux4way_gate;

architecture rtl of dmux4way_gate is
	signal out_dmux_out0_out1 : std_logic;
	signal out_dmux_out2_out3 : std_logic;
	
	--  Declaration of the component that will be instantiated.
	component dmux_gate
        port (
            in0 : in std_logic;
            sel0 : in std_logic;
            out0 : out std_logic;
            out1 : out std_logic
        );
	end component;


	--  Specifies which entity is bound with the component.
	for dmux_gate_0 : dmux_gate use entity work.dmux_gate;
	for dmux_gate_1 : dmux_gate use entity work.dmux_gate;
	for dmux_gate_2 : dmux_gate use entity work.dmux_gate;

begin
	dmux_gate_0: dmux_gate port map (
		in0 => in0, 
		sel0 => sel0(1), 
		out0 => out_dmux_out0_out1, 
		out1 => out_dmux_out2_out3 
	);

	dmux_gate_1: dmux_gate port map (
		in0 => out_dmux_out0_out1, 
		sel0 => sel0(0), 
		out0 => out0, 
		out1 => out1 
	);

	dmux_gate_2: dmux_gate port map (
		in0 => out_dmux_out2_out3, 
		sel0 => sel0(0), 
		out0 => out2, 
		out1 => out3 
	);

end rtl;
