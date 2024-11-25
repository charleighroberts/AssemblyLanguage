NAME=test3

all: test3

clean:
	rm -rf test3 test3.o

test3: test3.asm
	nasm -f elf test3.asm
	# gcc -no-pie -g -m32 -o test3 test3.o driver.c asm_io.o
	gcc -no-pie -g -m32 -o test3 test3.o driver.c asm_io.o
	