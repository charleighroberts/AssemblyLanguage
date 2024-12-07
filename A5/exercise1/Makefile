NAME=E1

all: E1

clean:
	rm -rf  E1 E1.o
                                  
E1: E1.asm
	nasm -f elf -F dwarf -g E1.asm
	gcc -no-pie -g -m32 -znoexecstack -o E1 E1.o driver.c asm_io.o
