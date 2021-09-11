library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package virtual_registers_array_package is
    type virtual_registers_array_t is array(0 to 15) of std_logic_vector(0 to 15);
end package virtual_registers_array_package;
