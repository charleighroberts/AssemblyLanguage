NAME=Q1

all: Q1

clean:
	rm -rf  Q1 Q1.o
                                  
Q1: Q1.asm
	nasm -f elf -F dwarf -g Q1.asm
	gcc -no-pie -g -m32 -znoexecstack -o Q1 Q1.o driver.c asm_io.o
