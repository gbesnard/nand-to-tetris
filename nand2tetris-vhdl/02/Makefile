all: common_gates half_adder full_adder add16

common_gates:
	make -C ../01/
	cp ../01/workdir/* workdir/

half_adder: 
	ghdl -i --workdir=workdir half_adder.vhdl half_adder_tb.vhdl
	ghdl -m --workdir=workdir half_adder_tb

full_adder: 
	ghdl -i --workdir=workdir full_adder.vhdl full_adder_tb.vhdl
	ghdl -m --workdir=workdir full_adder_tb

add16: 
	ghdl -i --workdir=workdir add16.vhdl add16_tb.vhdl
	ghdl -m --workdir=workdir add16_tb

clean:
	make -C ../01/ clean
	ghdl --remove --workdir=workdir

test:
	./half_adder_tb
	./full_adder_tb
	./add16_tb