all: std_logic_vector_to_string_package virtual_register_array_package \
	nand_gate not_gate and_gate or_gate xor_gate \
	mux_gate dmux_gate not16_gate and16_gate or16_gate \
	mux16_gate or8way_gate mux4way16_gate mux8way16_gate \
	dmux4way_gate dmux8way_gate half_adder full_adder add16 inc16 \
	alu dff bit reg ram8 ram64 ram512 ram4k ram16k ram16k_fast pc \
	cpu rom32k computer computer_cosim \
	light_clean

std_logic_vector_to_string_package:
	ghdl -i --work=work --workdir=workdir -O3 src/std_logic_vector_to_string_package.vhdl

virtual_register_array_package:
	ghdl -i --workdir=workdir -O3 src/virtual_register_array_package.vhdl

nand_gate: 
	ghdl -i --workdir=workdir -O3 src/nand_gate.vhdl tb/nand_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 nand_gate_tb

not_gate: 
	ghdl -i --workdir=workdir -O3 src/not_gate.vhdl tb/not_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 not_gate_tb

and_gate: 
	ghdl -i --workdir=workdir -O3 src/and_gate.vhdl tb/and_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 and_gate_tb

or_gate: 
	ghdl -i --workdir=workdir -O3 src/or_gate.vhdl tb/or_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 or_gate_tb

xor_gate: 
	ghdl -i --workdir=workdir -O3 src/xor_gate.vhdl tb/xor_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 xor_gate_tb

mux_gate: 
	ghdl -i --workdir=workdir -O3 src/mux_gate.vhdl tb/mux_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 mux_gate_tb

dmux_gate: 
	ghdl -i --workdir=workdir -O3 src/dmux_gate.vhdl tb/dmux_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 dmux_gate_tb

not16_gate: 
	ghdl -i --workdir=workdir -O3 src/not16_gate.vhdl tb/not16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 not16_gate_tb

and16_gate: 
	ghdl -i --workdir=workdir -O3 src/and16_gate.vhdl tb/and16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 and16_gate_tb

or16_gate: 
	ghdl -i --workdir=workdir -O3 src/or16_gate.vhdl tb/or16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 or16_gate_tb

mux16_gate: 
	ghdl -i --workdir=workdir -O3 src/mux16_gate.vhdl tb/mux16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 mux16_gate_tb

or8way_gate: 
	ghdl -i --workdir=workdir -O3 src/or8way_gate.vhdl tb/or8way_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 or8way_gate_tb

mux4way16_gate: 
	ghdl -i --workdir=workdir -O3 src/mux4way16_gate.vhdl tb/mux4way16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 mux4way16_gate_tb

mux8way16_gate: 
	ghdl -i --workdir=workdir -O3 src/mux8way16_gate.vhdl tb/mux8way16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 mux8way16_gate_tb

dmux4way_gate: 
	ghdl -i --workdir=workdir -O3 src/dmux4way_gate.vhdl tb/dmux4way_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 dmux4way_gate_tb

dmux8way_gate: 
	ghdl -i --workdir=workdir -O3 src/dmux8way_gate.vhdl tb/dmux8way_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 dmux8way_gate_tb

half_adder: 
	ghdl -i --workdir=workdir -O3 src/half_adder.vhdl tb/half_adder_tb.vhdl
	ghdl -m --workdir=workdir -O3 half_adder_tb

full_adder: 
	ghdl -i --workdir=workdir -O3 src/full_adder.vhdl tb/full_adder_tb.vhdl
	ghdl -m --workdir=workdir -O3 full_adder_tb

add16: 
	ghdl -i --workdir=workdir -O3 src/add16.vhdl tb/add16_tb.vhdl
	ghdl -m --workdir=workdir -O3 add16_tb

inc16: 
	ghdl -i --workdir=workdir -O3 src/inc16.vhdl tb/inc16_tb.vhdl
	ghdl -m --workdir=workdir -O3 inc16_tb

alu: 
	ghdl -i --workdir=workdir -O3 src/alu.vhdl tb/alu_tb.vhdl
	ghdl -m --workdir=workdir -O3 alu_tb

dff: 
	ghdl -i --workdir=workdir -O3 src/dff.vhdl tb/dff_tb.vhdl
	ghdl -m --workdir=workdir -O3 dff_tb

bit: 
	ghdl -i --workdir=workdir -O3 src/bit.vhdl tb/bit_tb.vhdl
	ghdl -m --workdir=workdir -O3 bit_tb

reg: 
	ghdl -i --workdir=workdir -O3 src/reg.vhdl tb/reg_tb.vhdl
	ghdl -m --workdir=workdir -O3 reg_tb

ram8: 
	ghdl -i --workdir=workdir -O3 src/ram8.vhdl tb/ram8_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram8_tb

ram64: 
	ghdl -i --workdir=workdir -O3 src/ram64.vhdl tb/ram64_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram64_tb

ram512: 
	ghdl -i --workdir=workdir -O3 src/ram512.vhdl tb/ram512_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram512_tb

ram4k: 
	ghdl -i --workdir=workdir -O3 src/ram4k.vhdl tb/ram4k_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram4k_tb

ram16k: 
	ghdl -i --workdir=workdir -O3 src/ram16k.vhdl tb/ram16k_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram16k_tb

ram16k_fast: 
	ghdl -i --workdir=workdir -O3 src/ram16k_fast.vhdl tb/ram16k_fast_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram16k_fast_tb

pc:
	ghdl -i --workdir=workdir -O3 src/pc.vhdl tb/pc_tb.vhdl
	ghdl -m --workdir=workdir -O3 pc_tb

cpu:
	ghdl -i --workdir=workdir -O3 src/cpu.vhdl tb/cpu_tb.vhdl
	ghdl -m --workdir=workdir -O3 cpu_tb

rom32k:
	ghdl -i --workdir=workdir -fsynopsys -O3 src/rom32k.vhdl tb/rom32k_tb.vhdl
	ghdl -m --workdir=workdir -fsynopsys -O3 rom32k_tb

computer:
	ghdl -i --workdir=workdir -fsynopsys -O3 src/computer.vhdl tb/computer_tb.vhdl
	ghdl -m --workdir=workdir -fsynopsys -O3 computer_tb

computer_cosim:
	ghdl -a --workdir=workdir -fsynopsys tb/computer_cosim.vhdl
	ghdl --bind --workdir=workdir -fsynopsys computer_cosim 
	gcc -O3 -Wall -Wextra src/computer_cosim.c -lcurses -o computer_cosim -Wl,`ghdl --list-link computer_cosim`

test:
	./nand_gate_tb
	./not_gate_tb
	./and_gate_tb
	./or_gate_tb
	./xor_gate_tb
	./mux_gate_tb
	./dmux_gate_tb
	./not16_gate_tb
	./and16_gate_tb
	./or16_gate_tb
	./mux16_gate_tb
	./or8way_gate_tb
	./mux4way16_gate_tb
	./mux8way16_gate_tb
	./dmux4way_gate_tb
	./dmux8way_gate_tb
	./half_adder_tb
	./full_adder_tb
	./add16_tb
	./inc16_tb
	./alu_tb
	./dff_tb --stop-time=1000us
	./bit_tb
	./reg_tb
	./ram8_tb
	./ram64_tb	
	./ram512_tb	
	./ram4k_tb	
	./ram16k_tb
	./ram16k_fast_tb
	./pc_tb
	./cpu_tb
	cp rom-programs/test-rom.hack	rom-programs/init-rom.hack && ./rom32k_tb
	cp rom-programs/add-rom.hack	rom-programs/init-rom.hack && cp tb/cmp/add-cmp.txt 	tb/cmp/cmp.txt && ./computer_tb --ieee-asserts=disable-at-0 --stop-time=2us
	cp rom-programs/mult-rom.hack	rom-programs/init-rom.hack && cp tb/cmp/mult-cmp.txt 	tb/cmp/cmp.txt && ./computer_tb --ieee-asserts=disable-at-0 --stop-time=2us
	cp rom-programs/max-rom.hack	rom-programs/init-rom.hack && cp tb/cmp/max-cmp.txt 	tb/cmp/cmp.txt && ./computer_tb --ieee-asserts=disable-at-0 --stop-time=2us

wave:
	mkdir -p waves
	cp rom-programs/add-rom.hack	rom-programs/init-rom.hack && cp tb/cmp/add-cmp.txt     tb/cmp/cmp.txt && ghdl -r computer_tb --ieee-asserts=disable-at-0 --wave=waves/computer_add_wave.ghw --stop-time=2us
	cp rom-programs/mult-rom.hack 	rom-programs/init-rom.hack && cp tb/cmp/mult-cmp.txt     tb/cmp/cmp.txt && ghdl -r computer_tb --ieee-asserts=disable-at-0 --wave=waves/computer_mult_wave.ghw --stop-time=2us
	cp rom-programs/max-rom.hack 	rom-programs/init-rom.hack && cp tb/cmp/max-cmp.txt     tb/cmp/cmp.txt && ghdl -r computer_tb --ieee-asserts=disable-at-0 --wave=waves/computer_max_wave.ghw --stop-time=2us

light_clean:
	rm -f e~*.o e~*.lst

clean:
	ghdl --remove --workdir=workdir
	rm -f *.ghw
	rm -rf waves
