# ROM Programs
These few hack programs can be loaded into ROM for computer test.

## init-rom
Default ROM loaded at startup, can be any of the following programs.

## test-rom
- ROM used for rom32k test bench, content doesn't mean anything.

## add-rom
- Computes R0 = 2 + 3  (R0 refers to RAM[0])

## mult-rom
- Stores 6 in R0 and 7 in R1
- Multiplies R0 and R1 and stores the result in R2.

## max-rom
- Stores 23456 in R0 and 12345 in R1
- Find the max value and stores the result in R2.

## screen-rom
- Runs an infinite loop that listens to the keyboard input.
- When a key is pressed (any key), the program blackens the screen, i.e. writes "black" in every pixel;
- When no key is pressed, the program clears the screen, i.e. writes "white" in every pixel;
