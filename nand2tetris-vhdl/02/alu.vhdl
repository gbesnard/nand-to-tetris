library ieee;
use ieee.std_logic_1164.all;

-- The ALU (Arithmetic Logic Unit).
-- Computes one of the following functions:
-- x+y, x-y, y-x, 0, 1, -1, x, y, -x, -y, !x, !y,
-- x+1, y+1, x-1, y-1, x&y, x|y on two 16-bit inputs, 
-- according to 6 input bits denoted zx,nx,zy,ny,f,no.
-- In addition, the ALU computes two 1-bit outputs:
-- if the ALU output == 0, zr is set to 1; otherwise zr is set to 0;
-- if the ALU output < 0, ng is set to 1; otherwise ng is set to 0.

-- Implementation: the ALU logic manipulates the x and y inputs
-- and operates on the resulting values, as follows:
-- if (zx == 1) set x = 0        // 16-bit constant
-- if (nx == 1) set x = !x       // bitwise not
-- if (zy == 1) set y = 0        // 16-bit constant
-- if (ny == 1) set y = !y       // bitwise not
-- if (f == 1)  set out = x + y  // integer 2's complement addition
-- if (f == 0)  set out = x & y  // bitwise and
-- if (no == 1) set out = !out   // bitwise not
-- if (out == 0) set zr = 1
-- if (out < 0) set ng = 1

entity alu is
	port (
		x  : in std_logic_vector(0 to 15);     -- 16-bit input
		y  : in std_logic_vector(0 to 15);     -- 16-bit input
		zx : in std_logic;                     -- zero the x input?                  
		nx : in std_logic;                     -- negate the x input?
		zy : in std_logic;                     -- zero the y input?
		ny : in std_logic;                     -- negate the y input?
		f  : in std_logic;                     -- compute out = x + y (if 1) or x & y (if 0)
		no : in std_logic;                     -- negate the out output?

		out0 : out std_logic_vector(0 to 15);  -- 16-bit output
		zr : out std_logic;                    -- 1 if (out == 0), 0 otherwise
		ng : out std_logic                     -- 1 if (out < 0),  0 otherwise
	);
end alu;

architecture rtl of alu is
	signal carry0 : std_logic_vector(0 to 15);
	signal xtmp, notxtmp, ytmp, notytmp : std_logic_vector(0 to 15);	
	signal xwised, ywised, xplusy, xandy : std_logic_vector(0 to 15);
	signal fout, notfout, outtmp : std_logic_vector(0 to 15);
	signal zrtmp0, zrtmp1, zrtmp2, zrtmp3 : std_logic;
	
	--  Declaration of components that will be instantiated.
	component mux16_gate is
		port (
			in0 : in std_logic_vector(0 to 15); 
			in1 : in std_logic_vector(0 to 15); 
			sel0 : in std_logic; 
			out0 : out std_logic_vector(0 to 15)
		);
	end component;

	component not16_gate
		port (
			in0 : in std_logic_vector(0 to 15); 
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;
 
	component add16
		port (
			in0 : in std_logic_vector(0 to 15); 
			in1 : in std_logic_vector(0 to 15); 
			out0 : out std_logic_vector(0 to 15)
		);
    	end component;

	component and16_gate
		port (
			in0 : in std_logic_vector(0 to 15); 
			in1 : in std_logic_vector(0 to 15); 
			out0 : out std_logic_vector(0 to 15)
		);
  	end component;
	
	component or8way_gate
		port (
			in0 : in std_logic_vector(0 to 7);
			out0 : out std_logic
		);
	end component;
		
	component or_gate
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
	for mux16_gate_0: mux16_gate use entity work.mux16_gate;	
	for mux16_gate_1: mux16_gate use entity work.mux16_gate;
	for mux16_gate_2: mux16_gate use entity work.mux16_gate;
	for mux16_gate_3: mux16_gate use entity work.mux16_gate;
	for mux16_gate_4: mux16_gate use entity work.mux16_gate;
	for mux16_gate_5: mux16_gate use entity work.mux16_gate;
	for not16_gate_0: not16_gate use entity work.not16_gate;
	for not16_gate_1: not16_gate use entity work.not16_gate;
	for not16_gate_2: not16_gate use entity work.not16_gate;
	for add16_0: add16 use entity work.add16;
	for and16_gate_0: and16_gate use entity work.and16_gate;
	for or8way_gate_0: or8way_gate use entity work.or8way_gate;
	for or8way_gate_1: or8way_gate use entity work.or8way_gate;
	for or_gate_0: or_gate use entity work.or_gate;
	for not_gate_0: not_gate use entity work.not_gate;	

begin

	-- step 1: if (zx == 1) set x = 0
	mux16_gate_0: mux16_gate port map (
		in0 => x, 
		in1 => "0000000000000000", 
		sel0 => zx, 
		out0 => xtmp
	);

	-- step 2: if (nx == 1) set x = !x
	not16_gate_0: not16_gate port map (
		in0 => xtmp,
		out0 => notxtmp
	);
	
	mux16_gate_1: mux16_gate port map (
		in0 => xtmp, 
		in1 => notxtmp, 
		sel0 => nx, 
		out0 => xwised
	);

	-- step 3: if (zy == 1) set y = 0
	mux16_gate_2: mux16_gate port map (
		in0 => y, 
		in1 => "0000000000000000",
		sel0 => zy, 
		out0 => ytmp
	);

	-- step 4: if (ny == 1) set y = !y
	not16_gate_1: not16_gate port map (
		in0 => ytmp,
		out0 => notytmp
	);
	
	mux16_gate_3: mux16_gate port map (
		in0 => ytmp, 
		in1 => notytmp, 
		sel0 => ny, 
		out0 => ywised
	);	

	-- step 5: if (f == 1)  set out = x + y, else if (f == 0) set out = x & y 
	add16_0: add16 port map (	
		in0 => xwised,
		in1 => ywised,
		out0 => xplusy
	);    	

	and16_gate_0: and16_gate port map (		
		in0 => xwised,
		in1 => ywised,
		out0 => xandy
	);  	

	mux16_gate_4: mux16_gate port map (
		in0 => xandy, 
		in1 => xplusy, 
		sel0 => f, 
		out0 => fout
	);

	-- step 6: if (no == 1) set out = !out	
	not16_gate_2: not16_gate port map (
		in0 => fout,
		out0 => notfout
	);

	mux16_gate_5: mux16_gate port map (
		in0 => fout, 
		in1 => notfout,
		sel0 => no, 
		out0 => outtmp
	);

	out0 <= outtmp;

	-- step 7: if (out < 0) set ng = 1
	ng <= outtmp(15);

	-- step 8: if (out == 0) set zr = 1
	or8way_gate_0: or8way_gate port map (
		in0 => outtmp(0 to 7),
		out0 => zrtmp1
	);

	or8way_gate_1: or8way_gate port map (
		in0 => outtmp(8 to 15),
		out0 => zrtmp2
	);
		
	or_gate_0: or_gate port map (
		in0 => zrtmp1,
		in1 => zrtmp2,
		out0 => zrtmp3
	);
		
	not_gate_0: not_gate port map (
		in0 => zrtmp3,
		out0 => zr
	);

end rtl;
