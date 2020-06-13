all: nand_gate not_gate and_gate or_gate xor_gate mux_gate dmux_gate not16_gate and16_gate or16_gate mux16_gate or8way_gate mux4way16_gate mux8way16_gate dmux4way_gate dmux8way_gate

nand_gate: 
	ghdl -i --workdir=workdir nand_gate.vhdl nand_gate_tb.vhdl
	ghdl -m --workdir=workdir nand_gate_tb

not_gate: 
	ghdl -i --workdir=workdir not_gate.vhdl not_gate_tb.vhdl
	ghdl -m --workdir=workdir not_gate_tb

and_gate: 
	ghdl -i --workdir=workdir and_gate.vhdl and_gate_tb.vhdl
	ghdl -m --workdir=workdir and_gate_tb

or_gate: 
	ghdl -i --workdir=workdir or_gate.vhdl or_gate_tb.vhdl
	ghdl -m --workdir=workdir or_gate_tb

xor_gate: 
	ghdl -i --workdir=workdir xor_gate.vhdl xor_gate_tb.vhdl
	ghdl -m --workdir=workdir xor_gate_tb

mux_gate: 
	ghdl -i --workdir=workdir mux_gate.vhdl mux_gate_tb.vhdl
	ghdl -m --workdir=workdir mux_gate_tb

dmux_gate: 
	ghdl -i --workdir=workdir dmux_gate.vhdl dmux_gate_tb.vhdl
	ghdl -m --workdir=workdir dmux_gate_tb

not16_gate: 
	ghdl -i --workdir=workdir not16_gate.vhdl not16_gate_tb.vhdl
	ghdl -m --workdir=workdir not16_gate_tb

and16_gate: 
	ghdl -i --workdir=workdir and16_gate.vhdl and16_gate_tb.vhdl
	ghdl -m --workdir=workdir and16_gate_tb

or16_gate: 
	ghdl -i --workdir=workdir or16_gate.vhdl or16_gate_tb.vhdl
	ghdl -m --workdir=workdir or16_gate_tb

mux16_gate: 
	ghdl -i --workdir=workdir mux16_gate.vhdl mux16_gate_tb.vhdl
	ghdl -m --workdir=workdir mux16_gate_tb

or8way_gate: 
	ghdl -i --workdir=workdir or8way_gate.vhdl or8way_gate_tb.vhdl
	ghdl -m --workdir=workdir or8way_gate_tb

mux4way16_gate: 
	ghdl -i --workdir=workdir mux4way16_gate.vhdl mux4way16_gate_tb.vhdl
	ghdl -m --workdir=workdir mux4way16_gate_tb

mux8way16_gate: 
	ghdl -i --workdir=workdir mux8way16_gate.vhdl mux8way16_gate_tb.vhdl
	ghdl -m --workdir=workdir mux8way16_gate_tb

dmux4way_gate: 
	ghdl -i --workdir=workdir dmux4way_gate.vhdl dmux4way_gate_tb.vhdl
	ghdl -m --workdir=workdir dmux4way_gate_tb

dmux8way_gate: 
	ghdl -i --workdir=workdir dmux8way_gate.vhdl dmux8way_gate_tb.vhdl
	ghdl -m --workdir=workdir dmux8way_gate_tb

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
