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
    M=D     // addr = 16384 (screen’s base address)
    @1024   
    D=A
    @n
    M=D		// n = pixel number = 1024
    @i
    M=0     // i = 0

(LOOP)	
    @KBD  // keyboard addr 
    D=M     // D = keyboard register content
    @FILL
    D;JGT   // if keyboard register > 0

(UNFILL)
    // if i < 0, wait
    @i
    D=M
    @LOOP
    D;JLT

    // else, unfill
    @addr
    A=M
    M=0    // RAM[addr]=0
    @i
    M=M-1   // i = i - 1
    @1
    D=A
    @addr
    M=M-D   // addr = addr-1
    @LOOP
    0;JMP   // goto LOOP

(FILL)
	// if i>=n, wait
    @i
    D=M
    @n
    D=D-M    
    @LOOP
    D;JGE

    // else, fill
    @addr
    A=M
    M=1		// RAM[addr]=1

	// check if incr needed or if over
	// if i != n-1, increment i and addr
    @n
    D=M
    @i
    D=D-M
	D=D-1			
    @INC
    D;JNE

	// No increment needed
	@LOOP
	0;JMP	// goto LOOP

(INC)
    @i
    M=M+1	// i = i + 1
    @1
    D=A
    @addr
    M=D+M	// addr = addr + 1
    @LOOP
    0;JMP	// goto LOOP

(END)
	@END
	0;JMP
