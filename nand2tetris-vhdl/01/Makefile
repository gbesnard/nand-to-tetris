all: nand_gate not_gate

nand_gate: 
	ghdl -i --workdir=workdir nand_gate.vhdl nand_gate_tb.vhdl
	ghdl -m --workdir=workdir nand_gate_tb

not_gate: 
	ghdl -i --workdir=workdir not_gate.vhdl not_gate_tb.vhdl
	ghdl -m --workdir=workdir not_gate_tb


clean:
	ghdl --remove --workdir=workdir
