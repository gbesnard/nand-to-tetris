# Nand2Tetris
[Build a Modern Computer from First Principles](https://www.nand2tetris.org/)

- All combinational chips are constructed from Nand gates.
- All sequential chips are constructed from DFF gates, and combinational chips.

## Architecture
- 16-bit computer.
- 32KB of RAM (16K registers of 16 bits).

## Capabilities
- VHDL hack computer can execute small binary programs which are preloaded in ROM, such as addition, multiplication or max function.
- Results can be checked using a test bench, by analyzing signals through gtkwave, or using the ncurses based co-simulation.

## Tools
For original Nand2Tetris, use the course provided tools.

For VHDL:

- ghdl
- gtkwave

## Todo
- Part > 4 for original nand2tetris.
- For co-simulation: set frequency, start, continue, pause, reset
- For co-simulation: interactive ROM loading
- For co-simulation: RAM/ROM monitoring screen
- For co-simulation: help screen
- Fillscreen function using co-simulation screen (add new memory mapping for IO)
- Assembler for asm.
- Stack and functions implementation.
- Assembler for JACK high level language.
- Try to port it to an FPGA board.
