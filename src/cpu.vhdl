library ieee;
use ieee.std_logic_1164.all;

entity cpu is
	-- The Hack CPU (Central Processing unit), consisting of an ALU,
	-- two registers named A and D, and a program counter named PC.
	-- The CPU is designed to fetch and execute instructions written in 
	-- the Hack machine language. In particular, functions as follows:
	-- Executes the inputted instruction according to the Hack machine 
	-- language specification. The D and A in the language specification
	-- refer to CPU-resident registers, while M refers to the external
	-- memory location addressed by A, i.e. to Memory[A]. The inM input 
	-- holds the value of this location. If the current instruction needs 
	-- to write a value to M, the value is placed in outM, the address 
	-- of the target location is placed in the addressM output, and the 
	-- writeM control bit is asserted. (When writeM==0, any value may 
	-- appear in outM). The outM and writeM outputs are combinational: 
	-- they are affected instantaneously by the execution of the current 
	-- instruction. The addressM and pc outputs are clocked: although they 
	-- are affected by the execution of the current instruction, they commit 
	-- to their new values only in the next time step. If reset==1 then the 
	-- CPU jumps to address 0 (i.e. pc is set to 0 in next time step) rather 
	-- than to the address resulting from executing the current instruction. 
	port (
		in_mem : in std_logic_vector(0 to 15);
		instruction : in std_logic_vector(0 to 15);
		reset : in std_logic;
		clk : in std_logic; 
		out_mem : out std_logic_vector(0 to 15);
		write_mem : out std_logic;
		addr_mem : out std_logic_vector(0 to 15);
		out_pc : out std_logic_vector(0 to 15);
		out_d : out std_logic_vector(0 to 15);
		out_a : out std_logic_vector(0 to 15)
	);
end cpu;

architecture rtl of cpu is	

	signal l_alu_out : std_logic_vector(0 to 15);
	signal l_alu_out_ng, l_alu_out_zr : std_logic;
	signal l_out_reg_A, l_out_reg_D : std_logic_vector(0 to 15);
	signal l_j_inferior, l_j_equal, l_j_superior : std_logic;
	signal l_instruction_A, l_instruction_C : std_logic;
	signal l_a_bit : std_logic;
	signal l_c1_bit, l_c2_bit, l_c3_bit : std_logic; 
	signal l_c4_bit, l_c5_bit, l_c6_bit : std_logic;
	signal l_dest_bit_A, l_dest_bit_D, l_dest_bit_M : std_logic;
	signal l_out_mux_0, l_out_mux_1 : std_logic_vector(0 to 15);
	signal l_out_and_1, l_out_and_2, l_out_and_3 : std_logic;
	signal l_out_and_4, l_out_and_5, l_out_and_6 : std_logic;
	signal l_out_and_7, l_out_and_8, l_out_and_10 : std_logic;
	signal l_out_or_0, l_out_or_1, l_out_or_2 : std_logic;
	signal l_out_not_1, l_out_not_2 : std_logic;
	signal l_load_reg_A : std_logic;

	--  Declaration of components that will be instantiated.
	component alu
		port (
			x  : in std_logic_vector(0 to 15);
			y  : in std_logic_vector(0 to 15);
			zx : in std_logic;                  
			nx : in std_logic;
			zy : in std_logic;
			ny : in std_logic;
			f  : in std_logic;
			no : in std_logic;
			out0 : out std_logic_vector(0 to 15);
			zr : out std_logic;
			ng : out std_logic
		);
  	end component;

	component reg
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic; 
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component pc
		port (
			in0 : in std_logic_vector(0 to 15);
			load0 : in std_logic;
			inc0 : in std_logic;
			reset0 : in std_logic;		
			clk : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component mux16_gate is
		port (
			in0 : in std_logic_vector(0 to 15); 
			in1 : in std_logic_vector(0 to 15); 
			sel0 : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component or_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	component and_gate
		port(
			in0 : in std_logic;
			in1 : in std_logic;
			out0 : out std_logic
		);
	end component;

	component not_gate
		port(
			in0 : in std_logic;
			out0 : out std_logic
		);
	end component;

	--  Specifies which entity is bound with the components.
	for alu_0 : alu use entity work.alu;
	for reg_A : reg use entity work.reg;
	for reg_D : reg use entity work.reg;
	for pc_0: pc use entity work.pc;	
	for mux16_gate_0: mux16_gate use entity work.mux16_gate;	
	for mux16_gate_1: mux16_gate use entity work.mux16_gate;	
	for and_gate_0 : and_gate use entity work.and_gate;
	for and_gate_1 : and_gate use entity work.and_gate;
	for and_gate_2 : and_gate use entity work.and_gate;
	for and_gate_3 : and_gate use entity work.and_gate;
	for and_gate_4 : and_gate use entity work.and_gate;
	for and_gate_5 : and_gate use entity work.and_gate;
	for and_gate_6 : and_gate use entity work.and_gate;
	for and_gate_7 : and_gate use entity work.and_gate;
	for and_gate_8 : and_gate use entity work.and_gate;
	for and_gate_9 : and_gate use entity work.and_gate;
	for and_gate_10 : and_gate use entity work.and_gate;
	for or_gate_0 : or_gate use entity work.or_gate;
	for or_gate_1 : or_gate use entity work.or_gate;
	for or_gate_2 : or_gate use entity work.or_gate;
	for not_gate_0 : not_gate use entity work.not_gate;	
	for not_gate_1 : not_gate use entity work.not_gate;	
	for not_gate_2 : not_gate use entity work.not_gate;	

begin	

	----------------------------
	-- STEP 0: init info signals
	----------------------------

	-- Instruction type
	not_gate_0: not_gate port map (
        in0 => instruction(0),
        out0 => l_instruction_A
    );
	
	l_instruction_C <= instruction(0);

	-- Destination bits.
	and_gate_0: and_gate port map (
		in0 => l_instruction_C, 
		in1 => instruction(10),
		out0 => l_dest_bit_A
	);

	and_gate_1: and_gate port map (
		in0 => l_instruction_C, 
		in1 => instruction(11),
		out0 => l_dest_bit_D
	);

	and_gate_2: and_gate port map (
		in0 => l_instruction_C, 
		in1 => instruction(12),
		out0 => l_dest_bit_M
	);

	-- Jump bits.
	and_gate_3: and_gate port map (
		in0 => l_instruction_C, 
		in1 => instruction(15), 
		out0 => l_j_superior
	);

	and_gate_4: and_gate port map (
		in0 => l_instruction_C, 
		in1 => instruction(14), 
		out0 => l_j_equal
	);

	and_gate_5: and_gate port map (
		in0 => l_instruction_C, 
		in1 => instruction(13),
		out0 => l_j_inferior
	);

	-- a bit.
	and_gate_9: and_gate port map (
		in0 => l_instruction_C, 
		in1 => instruction(3),
		out0 => l_a_bit
	);	

	-- c bits.
	l_c1_bit <= instruction(4);
	l_c2_bit <= instruction(5);
	l_c3_bit <= instruction(6);
	l_c4_bit <= instruction(7);
	l_c5_bit <= instruction(8);
	l_c6_bit <= instruction(9);

	------------------------------------
	-- STEP 1: Handle register D loading
	------------------------------------

	-- D register.
	reg_D: reg port map (
		in0 => l_alu_out, 
		load0 => l_dest_bit_D,
		clk => clk, 
		out0 => l_out_reg_D
	);

	out_d <= l_out_reg_D;

	------------------------------------
	-- STEP 2: Handle register A loading
	------------------------------------

	-- Load new address in register A:
	-- if Destination bit A is set (imply instruction C)
	-- or if instruction A.	
	or_gate_0: or_gate port map (
		in0 => l_dest_bit_A,
		in1 => l_instruction_A,
		out0 => l_out_or_0
	);

	-- Differentiate if we are executing an A instruction or C instruction,
	-- to know if we feed the instruction (aka address) or the ALU to
	-- the A register.
	mux16_gate_0: mux16_gate port map (		
		in0 => l_alu_out, 
		in1 => instruction, 
		sel0 => l_instruction_A, 
		out0 => l_out_mux_0
	);

	-- A register.
	reg_A: reg port map (
		in0 => l_out_mux_0, 
		load0 => l_out_or_0,
		clk => clk, 
		out0 => l_out_reg_A
	);

	-- Output A register value.
	addr_mem <= l_out_reg_A;

	-- Output write mem if C instruction and if bit M set.
	write_mem <= l_dest_bit_M;

	out_a <= l_out_reg_A;

	-----------------------------------
	-- STEP 3: Handle PC inc or loading
	-----------------------------------

	-- Check jump condition for alu output < 0.
	and_gate_6: and_gate port map (
		in0 => l_j_inferior, 
		in1 => l_alu_out_ng, 
		out0 => l_out_and_6
	);

	-- Check jump condition for alu output = 0.
	and_gate_7: and_gate port map (
		in0 => l_j_equal, 
		in1 => l_alu_out_zr, 
		out0 => l_out_and_7
	);

	-- Check jump condition for alu output > 0: not negative
	not_gate_1: not_gate port map (
        in0 => l_alu_out_ng,
        out0 => l_out_not_1
    );

	-- Check jump condition for alu output > 0: not zero
	not_gate_2: not_gate port map (
        in0 => l_alu_out_zr,
        out0 => l_out_not_2
    );

	and_gate_10: and_gate port map (
		in0 => l_out_not_1, 
		in1 => l_out_not_2, 
		out0 => l_out_and_10
	);

	and_gate_8: and_gate port map (
		in0 => l_j_superior, 
		in1 => l_out_and_10, 
		out0 => l_out_and_8
	);

	-- Load new PC from A register if one jump condition is met...
	or_gate_1: or_gate port map (
		in0 => l_out_and_6,
		in1 => l_out_and_7,
		out0 => l_out_or_1
	);

	or_gate_2: or_gate port map (
		in0 => l_out_or_1,
		in1 => l_out_and_8,
		out0 => l_out_or_2
	);

	-- ... or else, increment PC as usual.
	pc_0: pc port map (
		in0 => l_out_reg_A,
		load0 => l_out_or_2,
		inc0 => '1',
		reset0 => reset,
		clk => clk,
		out0 => out_pc
	);

	---------------------------------
	-- STEP 4: Handle ALU computation
	---------------------------------

	-- First ALU operand is always D register. 
	-- If a bit is set, ALU will work with in_mem as second operand,
	-- otherwise will work with A register as second operand.
	mux16_gate_1: mux16_gate port map (
		in0 => l_out_reg_A, 	
		in1 => in_mem, 			
		sel0 => l_a_bit, 
		out0 => l_out_mux_1
	);

	-- ALU.
	alu_0: alu port map (
		x => l_out_reg_D,
		y => l_out_mux_1,
		zx => l_c1_bit,                  
		nx => l_c2_bit,
		zy => l_c3_bit,
		ny => l_c4_bit,
		f  => l_c5_bit,
		no => l_c6_bit,
		out0 => l_alu_out,
		zr => l_alu_out_zr,
		ng => l_alu_out_ng
	);

	out_mem <= l_alu_out;

end rtl;
