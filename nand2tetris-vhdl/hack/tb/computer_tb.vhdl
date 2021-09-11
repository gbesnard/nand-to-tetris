library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc.

library work;
use work.std_logic_vector_to_string_package.all;
use work.virtual_registers_array_package.all;

use std.textio.all;

entity computer_tb is
--  A testbench has no ports.
end computer_tb;

architecture behaviour of computer_tb is
	constant clk_period : time := 10 ns;

	--  Declaration of the component that will be instantiated.
	component computer
		port (
			reset : in std_logic;
			clk : in std_logic;
			dbg_out_regs : out virtual_registers_array_t;
			dbg_out_pc : out std_logic_vector(0 to 15);
			dbg_out_d : out std_logic_vector(0 to 15);
			dbg_out_a : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for computer_0: computer use entity work.computer;
	signal reset, clk : std_logic;
	signal dbg_out_regs : virtual_registers_array_t;
	signal dbg_out_pc : std_logic_vector(0 to 15);
	signal dbg_out_d : std_logic_vector(0 to 15);
	signal dbg_out_a : std_logic_vector(0 to 15);

	--  Buffer for storing the text from input read-file.
    file input_buf : text;

begin
	--  Component instantiation.
	computer_0: computer port map (
		reset => reset,
		clk => clk,
		dbg_out_regs => dbg_out_regs,
		dbg_out_pc => dbg_out_pc,
		dbg_out_d => dbg_out_d,
		dbg_out_a => dbg_out_a
	);

	-- Clock process definition.
	clk_process: process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

	--  This process does the real job.
	process
	    variable read_col_from_input_buf : line; -- read lines one by one from input_buf.
    	variable val_col_r0 : std_logic_vector(0 to 15); -- to save expected R0 value of 16 bits.
    	variable val_col_r1 : std_logic_vector(0 to 15); -- to save expected R1 value of 16 bits.
    	variable val_col_r2 : std_logic_vector(0 to 15); -- to save expected R2 value of 16 bits.
	    variable val_space : character;  -- For spaces between data in file		
	begin
		-- Init.
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		wait for clk_period;

		-- Open test expected output file.
        file_open(input_buf, "tb/cmp/cmp.txt",  read_mode); 

		
		while not endfile(input_buf) loop
			readline(input_buf, read_col_from_input_buf);
			read(read_col_from_input_buf, val_col_r0);
			read(read_col_from_input_buf, val_space);           -- read in the space character
			read(read_col_from_input_buf, val_col_r1);
			read(read_col_from_input_buf, val_space);           -- read in the space character
			read(read_col_from_input_buf, val_col_r2);

			wait for 1500 ns;

			--  Check the outputs.
            assert dbg_out_regs(0) = val_col_r0
            report "bad value for r0 = " & to_string(dbg_out_regs(0)) & " instead of " & to_string(val_col_r0)
            severity error;

		end loop;

		file_close(input_buf);   

		assert false report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;

end behaviour;
