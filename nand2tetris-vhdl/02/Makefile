all: common_gates std_logic_vector_to_string_package half_adder full_adder add16 inc16 alu

common_gates:
	make -C ../01/
	cp ../01/workdir/* workdir/

std_logic_vector_to_string_package:
	ghdl -i --workdir=workdir std_logic_vector_to_string_package.vhdl

half_adder: 
	ghdl -i --workdir=workdir half_adder.vhdl half_adder_tb.vhdl
	ghdl -m --workdir=workdir half_adder_tb

full_adder: 
	ghdl -i --workdir=workdir full_adder.vhdl full_adder_tb.vhdl
	ghdl -m --workdir=workdir full_adder_tb

add16: 
	ghdl -i --workdir=workdir add16.vhdl add16_tb.vhdl
	ghdl -m --workdir=workdir add16_tb

inc16: 
	ghdl -i --workdir=workdir inc16.vhdl inc16_tb.vhdl
	ghdl -m --workdir=workdir inc16_tb

alu: 
	ghdl -i --workdir=workdir alu.vhdl alu_tb.vhdl
	ghdl -m --workdir=workdir alu_tb

clean:
	make -C ../01/ clean
	ghdl --remove --workdir=workdir

test:
	./half_adder_tb
	./full_adder_tb
	./add16_tb
	./inc16_tb
	./alu_tb
