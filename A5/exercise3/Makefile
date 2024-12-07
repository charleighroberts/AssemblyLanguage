NAME=E3

all: E3

clean:
	rm -rf  E3 E3.o
                                  
E3: E3.asm
	nasm -f elf -F dwarf -g E3.asm
	gcc -no-pie -g -m32 -znoexecstack -o E3 E3.o driver.c asm_io.o
