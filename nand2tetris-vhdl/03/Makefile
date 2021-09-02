all: previous_components dff bit reg

previous_components:
	make -C ../01/
	cp ../01/workdir/* workdir/
	make -C ../02/
	cp ../02/workdir/* workdir/

dff: 
	ghdl -i --workdir=workdir dff.vhdl dff_tb.vhdl
	ghdl -m --workdir=workdir dff_tb

bit: 
	ghdl -i --workdir=workdir bit.vhdl bit_tb.vhdl
	ghdl -m --workdir=workdir bit_tb

reg: 
	ghdl -i --workdir=workdir reg.vhdl reg_tb.vhdl
	ghdl -m --workdir=workdir reg_tb

clean:
	make -C ../01/ clean
	make -C ../02/ clean
	ghdl --remove --workdir=workdir

test:
	./dff_tb --stop-time=1000us
	./bit_tb
	./reg_tb

wave:
	ghdl -r dff_tb --wave=dff_wave.ghw --stop-time=1000us
	ghdl -r bit_tb --wave=bit_wave.ghw --stop-time=1000us
	ghdl -r reg_tb --wave=reg_wave.ghw --stop-time=1000us
