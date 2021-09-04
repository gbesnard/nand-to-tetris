all: nand_gate not_gate and_gate or_gate xor_gate mux_gate dmux_gate not16_gate and16_gate or16_gate mux16_gate or8way_gate mux4way16_gate mux8way16_gate dmux4way_gate dmux8way_gate

nand_gate: 
	ghdl -i --workdir=workdir -O3 nand_gate.vhdl nand_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 nand_gate_tb

not_gate: 
	ghdl -i --workdir=workdir -O3 not_gate.vhdl not_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 not_gate_tb

and_gate: 
	ghdl -i --workdir=workdir -O3 and_gate.vhdl and_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 and_gate_tb

or_gate: 
	ghdl -i --workdir=workdir -O3 or_gate.vhdl or_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 or_gate_tb

xor_gate: 
	ghdl -i --workdir=workdir -O3 xor_gate.vhdl xor_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 xor_gate_tb

mux_gate: 
	ghdl -i --workdir=workdir -O3 mux_gate.vhdl mux_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 mux_gate_tb

dmux_gate: 
	ghdl -i --workdir=workdir -O3 dmux_gate.vhdl dmux_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 dmux_gate_tb

not16_gate: 
	ghdl -i --workdir=workdir -O3 not16_gate.vhdl not16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 not16_gate_tb

and16_gate: 
	ghdl -i --workdir=workdir -O3 and16_gate.vhdl and16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 and16_gate_tb

or16_gate: 
	ghdl -i --workdir=workdir -O3 or16_gate.vhdl or16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 or16_gate_tb

mux16_gate: 
	ghdl -i --workdir=workdir -O3 mux16_gate.vhdl mux16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 mux16_gate_tb

or8way_gate: 
	ghdl -i --workdir=workdir -O3 or8way_gate.vhdl or8way_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 or8way_gate_tb

mux4way16_gate: 
	ghdl -i --workdir=workdir -O3 mux4way16_gate.vhdl mux4way16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 mux4way16_gate_tb

mux8way16_gate: 
	ghdl -i --workdir=workdir -O3 mux8way16_gate.vhdl mux8way16_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 mux8way16_gate_tb

dmux4way_gate: 
	ghdl -i --workdir=workdir -O3 dmux4way_gate.vhdl dmux4way_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 dmux4way_gate_tb

dmux8way_gate: 
	ghdl -i --workdir=workdir -O3 dmux8way_gate.vhdl dmux8way_gate_tb.vhdl
	ghdl -m --workdir=workdir -O3 dmux8way_gate_tb

clean:
	ghdl --remove --workdir=workdir

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

test_dump:
	ghdl -r mux4way16_gate_tb --vcd=mux4way16_gate_tb.vcd
