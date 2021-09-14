// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// TODO: explicit: Do something with screen.

(START)
	@1
	D=A		// D = 1
	@16384
	M=D		// pixels[0] = 1
	@17407
	M=D		// pixels[1023] = 1

(START)
    @SCREEN
    D=A
    @addr
    M=D     // addr = 16384 (screen’s base address)
    @1024   
    D=A
    @n
    M=D		// n = pixel number = 1024
    @i
    M=0     // i = 0

(FILL)
    @FILL	// TODO: useless garbage ?

	// if i>=n, wait
    @i
    D=M
    @n
    D=D-M    	
    @END
    D;JGE

    // else, fill
    @addr
    A=M
    M=1		// RAM[addr]=1

    @i
    M=M+1	// i = i + 1
    @1
    D=A
    @addr
    M=D+M	// addr = addr + 1
    @FILL
    0;JMP	// goto FILL

(END)
	@END
	0;JMP
