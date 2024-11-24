NAME=A4

all: A4

clean:
	rm -rf A4 A4.o

A4: A4.asm
	nasm -f elf -F dwarf -g A4.asm
	gcc -no-pie -g -m32 -znoexecstack -o A4 A4.o driver.c asm_io.o
