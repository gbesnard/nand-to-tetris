all: 01 half_adder

01:
	make -C ../01/
	cp ../01/workdir/* workdir/

half_adder: 
	ghdl -i --workdir=workdir half_adder.vhdl half_adder_tb.vhdl
	ghdl -m --workdir=workdir half_adder_tb

clean:
	make -C ../01/ clean
	ghdl --remove --workdir=workdir

test:
	./half_adder_tb
