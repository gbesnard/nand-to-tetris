all: previous_components std_logic_vector_to_string_package half_adder full_adder add16 inc16 alu

previous_components:
	make -C ../01/
	cp ../01/workdir/* workdir/

std_logic_vector_to_string_package:
	ghdl -i --workdir=workdir -O3 std_logic_vector_to_string_package.vhdl

half_adder: 
	ghdl -i --workdir=workdir -O3 half_adder.vhdl half_adder_tb.vhdl
	ghdl -m --workdir=workdir -O3 half_adder_tb

full_adder: 
	ghdl -i --workdir=workdir -O3 full_adder.vhdl full_adder_tb.vhdl
	ghdl -m --workdir=workdir -O3 full_adder_tb

add16: 
	ghdl -i --workdir=workdir -O3 add16.vhdl add16_tb.vhdl
	ghdl -m --workdir=workdir -O3 add16_tb

inc16: 
	ghdl -i --workdir=workdir -O3 inc16.vhdl inc16_tb.vhdl
	ghdl -m --workdir=workdir -O3 inc16_tb

alu: 
	ghdl -i --workdir=workdir -O3 alu.vhdl alu_tb.vhdl
	ghdl -m --workdir=workdir -O3 alu_tb

clean:
	make -C ../01/ clean
	ghdl --remove --workdir=workdir

test:
	./half_adder_tb
	./full_adder_tb
	./add16_tb
	./inc16_tb
	./alu_tb
