NAME=A5-2

all: A5-2

clean:
	rm -rf A5-2 A5-2.o

A5-2: A5-2.asm
	nasm -f elf -F dwarf -g A5-2.asm
	gcc -no-pie -g -m32 -znoexecstack -o A5-2 A5-2.o driver.c asm_io.o
