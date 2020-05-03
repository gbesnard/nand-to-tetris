all: dff

dff: 
	ghdl -i --workdir=workdir dff.vhdl dff_tb.vhdl
	ghdl -m --workdir=workdir dff_tb

clean:
	ghdl --remove --workdir=workdir
	rm *.ghw

test:
	./dff_tb

dff_wave:
	ghdl -r dff_tb --wave=dff_wave.ghw
