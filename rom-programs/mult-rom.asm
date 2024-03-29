// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

(START)
	@6
	D=A		// D = 6
	@R0
	M=D		// RO = 6
	@7
	D=A		// D = 7
	@R1
	M=D		// R1 = 7
	@i
	M=0		// loop index i = 0
	@R2
	M=0		// R2 = 0

(LOOP)
	@R1
	D=M			// D = RAM[1]
	@i
	D=D-M		// D = RAM[1] - i
	@STOP
	D;JLE		// if RAM[1] - i < 0, stop
	@i
	M=M+1		// i++
	@R0
	D=M			// D = RAM[0]
	@R2
	M=D+M		// RAM[2] = RAM[0] + RAM[2]
	@LOOP
	0;JMP

(STOP)

(END)
	@END
	0;JMP
