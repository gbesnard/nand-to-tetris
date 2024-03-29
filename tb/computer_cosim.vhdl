library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.virtual_registers_array_package.all;
use work.screen_array_package.all;

entity computer_cosim is
--  A testbench has no ports.
end computer_cosim;

architecture behaviour of computer_cosim is

	type regs_array_t is array (0 to 15) of integer;
	type pixels_array_t is array (0 to 1023) of integer;

	constant clk_period : time := 1000 ns;
	constant tick_period : time := 10 us;

	-- VHPIDIRECT interface.
	procedure set_regs (regs: regs_array_t) is
    begin report "VHPIDIRECT set_regs" severity failure; end;
    attribute foreign of set_regs : procedure is "VHPIDIRECT set_regs";

	procedure set_pc_reg (reg: integer) is
    begin report "VHPIDIRECT set_pc_reg" severity failure; end;
    attribute foreign of set_pc_reg : procedure is "VHPIDIRECT set_pc_reg";

	procedure set_a_reg (reg: integer) is
    begin report "VHPIDIRECT set_a_reg" severity failure; end;
    attribute foreign of set_a_reg : procedure is "VHPIDIRECT set_a_reg";

	procedure set_d_reg (reg: integer) is
    begin report "VHPIDIRECT set_d_reg" severity failure; end;
    attribute foreign of set_d_reg : procedure is "VHPIDIRECT set_d_reg";

	procedure set_screen (pixels: pixels_array_t) is
	begin report "VHPIDIRECT set_screen" severity failure; end;
	attribute foreign of set_screen : procedure is "VHPIDIRECT set_screen";

	procedure set_keyboard (reg: integer) is
	begin report "VHPIDIRECT set_screen" severity failure; end;
	attribute foreign of set_keyboard : procedure is "VHPIDIRECT set_keyboard";

	function get_keyboard return integer is
	begin report "VHPIDIRECT custom_function" severity failure; end;
	attribute foreign of get_keyboard : function is "VHPIDIRECT get_keyboard";

	--  Declaration of the component that will be instantiated.
	component computer
		port (
			reset : in std_logic;
			clk : in std_logic;
			dbg_keyboard_in : in std_logic_vector(0 to 15);
			dbg_out_regs : out virtual_registers_array_t;
			dbg_out_pc : out std_logic_vector(0 to 15);
			dbg_out_d : out std_logic_vector(0 to 15);
			dbg_out_a : out std_logic_vector(0 to 15);
			dbg_out_screen : out screen_array_t;			
			dbg_keyboard_out : out std_logic_vector(0 to 15)
		);
  	end component;

	--  Specifies which entity is bound with the component.
	for computer_0: computer use entity work.computer;
	signal reset, clk, tick : std_logic;
	signal dbg_out_regs : virtual_registers_array_t;
	signal dbg_out_pc : std_logic_vector(0 to 15);
	signal dbg_out_d : std_logic_vector(0 to 15);
	signal dbg_out_a : std_logic_vector(0 to 15);
	signal dbg_out_screen : screen_array_t;
	signal dbg_keyboard_in : std_logic_vector(0 to 15) := "0000000000000000";
	signal dbg_keyboard_out : std_logic_vector(0 to 15);	

begin
	--  Component instantiation.
	computer_0: computer port map (
		reset => reset,
		clk => clk,
		dbg_keyboard_in => dbg_keyboard_in,
		dbg_out_regs => dbg_out_regs,
		dbg_out_pc => dbg_out_pc,
		dbg_out_d => dbg_out_d,
		dbg_out_a => dbg_out_a,
		dbg_out_screen => dbg_out_screen,		
		dbg_keyboard_out => dbg_keyboard_out
	);

	-- Clock process definition.
	clk_process: process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;

	tick_process: process
    begin
        tick <= '0';
        wait for tick_period/2;
        tick <= '1';
        wait for tick_period/2;
    end process;

	-- Init process definition.
	init_process: process
	begin
        -- Init
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait;
    end process;

	-- VHPIDIRECT process.
	vhpi_process: process(clk)
		variable regs_int_array: regs_array_t;
		variable pixels_int_array: pixels_array_t;
		variable current_key: integer := 0;
		variable current_key_vector: std_logic_vector(0 to 15) := "0000000000000000";
	begin
        if rising_edge(tick) then
			-- Construct array of regs integer value.
			for i in regs_int_array' range loop
				regs_int_array(i) := to_integer(unsigned(dbg_out_regs(i)));
			end loop;

			-- Construct array of pixels.
			for i in pixels_array_t' range loop
				pixels_int_array(i) := to_integer(unsigned(dbg_out_screen(i)));
			end loop;

			-- Send registers to C interface.
			set_regs(regs_int_array);
			set_pc_reg(to_integer(unsigned(dbg_out_pc)));
			set_a_reg(to_integer(unsigned(dbg_out_a)));
			set_d_reg(to_integer(unsigned(dbg_out_d)));
			set_screen(pixels_int_array);
			set_keyboard(to_integer(unsigned(dbg_keyboard_out)));

			-- Retrieve current key from C interface.
			current_key := get_keyboard;
			current_key_vector := std_logic_vector(to_unsigned(current_key, current_key_vector'length));
			dbg_keyboard_in <= current_key_vector;
		end if;
	end process;

end behaviour;
