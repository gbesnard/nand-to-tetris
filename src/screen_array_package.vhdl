library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package screen_array_package is
	type screen_array_t is array (0 to 1023) of std_logic_vector (0 to 15);
end package screen_array_package;
