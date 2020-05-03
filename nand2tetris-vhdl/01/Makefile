all: nand_gate not_gate and_gate not16_gate

nand_gate: 
	ghdl -i --workdir=workdir nand_gate.vhdl nand_gate_tb.vhdl
	ghdl -m --workdir=workdir nand_gate_tb

not_gate: 
	ghdl -i --workdir=workdir not_gate.vhdl not_gate_tb.vhdl
	ghdl -m --workdir=workdir not_gate_tb

and_gate: 
	ghdl -i --workdir=workdir and_gate.vhdl and_gate_tb.vhdl
	ghdl -m --workdir=workdir and_gate_tb

not16_gate: 
	ghdl -i --workdir=workdir not16_gate.vhdl not16_gate_tb.vhdl
	ghdl -m --workdir=workdir not16_gate_tb

clean:
	ghdl --remove --workdir=workdir

test:
	./nand_gate_tb
	./not_gate_tb
	./and_gate_tb
	./not16_gate_tb
