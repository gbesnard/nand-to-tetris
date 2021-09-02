all: previous_components dff bit reg ram8

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

ram8: 
	ghdl -i --workdir=workdir ram8.vhdl ram8_tb.vhdl
	ghdl -m --workdir=workdir ram8_tb

clean:
	make -C ../01/ clean
	make -C ../02/ clean
	ghdl --remove --workdir=workdir
	rm -f *.ghw

test:
	./dff_tb --stop-time=1000us
	./bit_tb
	./reg_tb
	./ram8_tb

wave:
	ghdl -r dff_tb --wave=dff_wave.ghw --stop-time=1000us
	ghdl -r bit_tb --wave=bit_wave.ghw --stop-time=1000us
	ghdl -r reg_tb --wave=reg_wave.ghw --stop-time=1000us
	ghdl -r ram8_tb --wave=ram8_wave.ghw --stop-time=1000us
