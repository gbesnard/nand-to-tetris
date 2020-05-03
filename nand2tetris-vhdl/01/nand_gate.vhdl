library ieee;
use ieee.std_logic_1164.all;

entity nand_gate is
	-- Nand gate:
	-- out0 = not (in0 and in1)
	port (in0 : in std_logic; in1 : in std_logic; out0 : out std_logic);
end nand_gate;

architecture rtl of nand_gate is
begin
	--  Compute the nand.
	out0 <= not (in0 and in1);
end rtl;

