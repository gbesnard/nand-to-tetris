library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.virtual_registers_array_package.all;

entity computer_cosim is
--  A testbench has no ports.
end computer_cosim;

architecture behaviour of computer_cosim is

	type int_array is array (0 to 15) of integer;

	constant clk_period : time := 10 ns;
	constant tick_period : time := 10 us;

	-- VHPIDIRECT interface.
	procedure set_regs (regs: int_array) is
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
	signal reset, clk, tick : std_logic;
	signal dbg_out_regs : virtual_registers_array_t;
	signal dbg_out_pc : std_logic_vector(0 to 15);
	signal dbg_out_d : std_logic_vector(0 to 15);
	signal dbg_out_a : std_logic_vector(0 to 15);

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
    	variable count: integer := 0;
		variable regs_int_array: int_array;
	begin
        if rising_edge(tick) then
			count := count + 1;

			-- Construct array of regs integer value.
			for i in regs_int_array' range loop
				regs_int_array(i) := to_integer(unsigned(dbg_out_regs(i)));
			end loop;

			-- Send registers to C interface.
			set_regs(regs_int_array);
			set_pc_reg(to_integer(unsigned(dbg_out_pc)));
			set_a_reg(to_integer(unsigned(dbg_out_a)));
			set_d_reg(to_integer(unsigned(dbg_out_d)));

		end if;
	end process;

end behaviour;
