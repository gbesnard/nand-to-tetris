library ieee;
use ieee.std_logic_1164.all;

-- Package Declaration Section
package std_logic_vector_to_string_package is
       
	function to_string (a : in std_logic_vector) return string;
	 
end package std_logic_vector_to_string_package;
       
-- Package Body Section
package body std_logic_vector_to_string_package is

function to_string (a: in std_logic_vector) return string is

	variable b : string (1 to a'length) := (others => NUL);
	variable stri : integer := 1; 
	begin
		for i in a'range loop
		b(stri) := std_logic'image(a((i)))(2);
		stri := stri+1;
		end loop;
	return b;
	
end function;

end package body std_logic_vector_to_string_package;