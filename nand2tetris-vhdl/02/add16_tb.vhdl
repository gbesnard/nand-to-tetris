library ieee;
use ieee.std_logic_1164.all;

entity add16_tb is
--  A testbench has no ports.
end add16_tb;

architecture behaviour of add16_tb is
	--  Declaration of the component that will be instantiated.
	component add16
		port (
			in0 : in std_logic_vector(0 to 15); 
			in1 : in std_logic_vector(0 to 15); 
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for add16_0: add16 use entity work.add16;
	signal in0, in1, out0 : std_logic_vector(0 to 15);

	function to_string ( a: std_logic_vector) return string is
		variable b : string (1 to a'length) := (others => NUL);
		variable stri : integer := 1; 
		begin
		    for i in a'range loop
			b(stri) := std_logic'image(a((i)))(2);
		    stri := stri+1;
		    end loop;
		return b;
	end function;

begin
	--  Component instantiation.
	add16_0: add16 port map (
		in0 => in0, 
		in1 => in1, 
		out0 => out0
	);

	--  This process does the real job.
	process
		type pattern_type is record
			--  The inputs of the add16_tb.
			in0 : std_logic_vector(0 to 15);
			in1 : std_logic_vector(0 to 15);
			--  The expected outputs of the adder.
			out0 : std_logic_vector(0 to 15);
		end record;

		--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
		(
			("0000000000000000", "0000000000000000", "0000000000000000"),
			("0000000000000000", "1111111111111111", "1111111111111111"),
			("1111111111111111", "1111111111111111", "0111111111111111"),
			("1010101010101010", "0101010101010101", "1111111111111111"),
			("1100001100111100", "0000111111110000", "1100110100110010"),
			("0010110001001000", "0110111000011001", "0101010101010101")
		);

	begin
		--  Check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			in0 <= patterns(i).in0;
			in1 <= patterns(i).in1;
			--  Wait for the results.
			wait for 1 ns;
			--  Check the outputs.
			assert out0 = patterns(i).out0
			report "bad value for i = " & integer'image(i) & 
			" for input in0 = " & to_string(in0) & 
			" and inb = " & to_string(in1) &
			" and out0 = " & to_string(out0) &
			" instead of " & to_string(patterns(i).out0)

			severity error;
		end loop;

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
