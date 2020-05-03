// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(START)
	@SCREEN
	D=A
	@addr
	M=D 	// addr = 16384 (screen’s base address)
	@8192	// n = pixel number / pixels per addr = 512*256 / 32=131072/16 = 8192
	D=A
	@n
	M=D
	@i
	M=0 	// i = 0

(LOOP)
	@24576	// keyboard addr
	D=M		// D = keyboard register content
	@FILL
	D;JGT	// if keyboard register > 0

(UNFILL)
	// if i < 0, wait
	@i
	D=M
	@LOOP
	D;JLT
	// else, unfill
	@addr
    A=M
    M=0    // RAM[addr]=0000000000000000

    @i
    M=M-1   // i = i - 1
    @1
    D=A
    @addr
    M=M-D   // addr = addr-1
    @LOOP
    0;JMP   // goto LOOP

(FILL)
    @FILL
	@i
	D=M
	@n
	D=D-M
	// if i>=n, wait
	@LOOP
	D;JGE
	// else, fill
	@addr
	A=M
	M=-1	// RAM[addr]=1111111111111111

	@i
	M=M+1 	// i = i + 1
	@1
	D=A
	@addr
	M=D+M	// addr = addr+1
	@LOOP
    0;JMP	// goto LOOP

(END)
    @END
    0;JMP

