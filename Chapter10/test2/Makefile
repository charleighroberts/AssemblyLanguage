NAME=test2

all: test2

clean:
	rm -rf test2 test2.o

test2: test2.asm
	nasm -f elf test2.asm
	# gcc -no-pie -g -m32 -o test2 test2.o driver.c asm_io.o
	gcc -no-pie -g -m32 -o test2 test2.o driver.c asm_io.o
	