import csv
import sys

if __name__ == "__main__":
	if len(sys.argv) != 2:
		print("Helper script to convert original cmp file to list used in VHDL test benches")
		print("Usage: python convert-test.py file.cmp")
	else:	
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
						if len(value) == 1:
							print('\'', end = '')
						else:
							print('\"', end = '')

						# Reverse bit order because it is 
						# read in reverse in our VHDL test bench.
						print (value[::-1], end = '')

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
