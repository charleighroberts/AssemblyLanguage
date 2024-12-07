NAME=E2

all: E2

clean:
	rm -rf  E2 E2.o
                                  
E2: E2.asm
	nasm -f elf -F dwarf -g E2.asm
	gcc -no-pie -g -m32 -znoexecstack -o E2 E2.o driver.c asm_io.o
