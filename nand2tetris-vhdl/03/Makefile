all: previous_components dff bit reg ram8 ram64 ram512 ram4k ram16k ram16k_fast

previous_components:
	make -C ../01/
	cp ../01/workdir/* workdir/
	make -C ../02/
	cp ../02/workdir/* workdir/

dff: 
	ghdl -i --workdir=workdir -O3 dff.vhdl dff_tb.vhdl
	ghdl -m --workdir=workdir -O3 dff_tb

bit: 
	ghdl -i --workdir=workdir -O3 bit.vhdl bit_tb.vhdl
	ghdl -m --workdir=workdir -O3 bit_tb

reg: 
	ghdl -i --workdir=workdir -O3 reg.vhdl reg_tb.vhdl
	ghdl -m --workdir=workdir -O3 reg_tb

ram8: 
	ghdl -i --workdir=workdir -O3 ram8.vhdl ram8_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram8_tb

ram64: 
	ghdl -i --workdir=workdir -O3 ram64.vhdl ram64_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram64_tb

ram512: 
	ghdl -i --workdir=workdir -O3 ram512.vhdl ram512_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram512_tb

ram4k: 
	ghdl -i --workdir=workdir -O3 ram4k.vhdl ram4k_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram4k_tb

ram16k: 
	ghdl -i --workdir=workdir -O3 ram16k.vhdl ram16k_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram16k_tb

ram16k_fast: 
	ghdl -i --workdir=workdir -O3 ram16k_fast.vhdl ram16k_fast_tb.vhdl
	ghdl -m --workdir=workdir -O3 ram16k_fast_tb

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
	./ram64_tb	
	./ram16k_tb
	./ram16k_fast_tb

wave:
	ghdl -r dff_tb --wave=dff_wave.ghw --stop-time=1000us
	ghdl -r bit_tb --wave=bit_wave.ghw
	ghdl -r reg_tb --wave=reg_wave.ghw
	ghdl -r ram8_tb --wave=ram8_wave.ghw
	ghdl -r ram64_tb --wave=ram64_wave.ghw
	ghdl -r ram512_tb --wave=ram512_wave.ghw
	ghdl -r ram4k_tb --wave=ram512_wave.ghw
	ghdl -r ram16k_tb --wave=ram16k_wave.ghw
	ghdl -r ram16k_fast_tb --wave=ram16k_fast_tb.ghw
