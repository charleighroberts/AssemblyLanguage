NAME=test

all: test

clean:
	rm -rf test test.o

test: test.asm
	nasm -f elf test.asm
	# gcc -no-pie -g -m32 -o test test.o driver.c asm_io.o
	gcc -no-pie -g -m32 -o test test.o driver.c asm_io.o
	