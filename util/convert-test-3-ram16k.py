import csv
import sys

if __name__ == "__main__":
	
	if len(sys.argv) != 2:
		print("Helper script to convert original cmp file to list used in VHDL test benches")
		print("Usage: python convert-test.py file.cmp")
	else:	

		addr_used = []
		with open(sys.argv[1], newline='') as csvfile:
			csvreader = csv.reader(csvfile, delimiter='|', quotechar='#')
			row_count = sum(1 for row in csvreader)
			csvfile.seek(0, 0)

			for i, row in enumerate(csvreader):
				if i == 0:
					continue
				for j, value in enumerate(row):
					if j == 0:
						continue
					if j != (len(row)-1):
						value = value.strip()
						if j == 4:			
							value = ((bin(int(value)))[2:]).zfill(14)
							if value not in addr_used:
								addr_used.append(value)

		for i, addr in enumerate (addr_used):
			print ("(\'0\', \"0000000000000000\", \'1\', \"" + addr + "\", \"UUUUUUUUUUUUUUUU\"),")
			print ("(\'1\', \"0000000000000000\", \'1\', \"" + addr + "\", \"0000000000000000\"),")
		
		with open(sys.argv[1], newline='') as csvfile:
			csvreader = csv.reader(csvfile, delimiter='|', quotechar='#')
			row_count = sum(1 for row in csvreader)
			csvfile.seek(0, 0)

			for i, row in enumerate(csvreader):
				if i == 0:
					continue

				print('(', end = '')
				for j, value in enumerate(row):
					if j == 0:
						continue

					if j != (len(row)-1):
						value = value.strip()
						
						if j == 1:
							if '+' in value:
								value = '0'
							else:
								value = '1'

						if j == 2 or j == 5:						
							if value[0:1] == "-":
								value = ((bin(int(value)+(1<<16)))[2:]).zfill(16)
							else:
								value = ((bin(int(value)))[2:]).zfill(16)

						if j == 4:			
							value = ((bin(int(value)))[2:]).zfill(14)
							if value not in addr_used:
								addr_used.append(value)

						if len(value) == 1:
							print('\'', end = '')
						else:
							print('\"', end = '')

						print (value, end = '')

						if len(value) == 1:
							print('\'', end = '')
						else:
							print('\"', end = '')

						if j != (len(row)-2):
							print (", ", end = '')
						
				print(')', end = '')

				if i == (row_count-1):
					print('')
				else:
					print(',')
