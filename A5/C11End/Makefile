NAME=C11

all: C11

clean:
	rm -rf  C11 C11.o
                                  
C11: C11.asm
	nasm -f elf -F dwarf -g C11.asm
	gcc -no-pie -g -m32 -znoexecstack -o C11 C11.o driver.c asm_io.o
