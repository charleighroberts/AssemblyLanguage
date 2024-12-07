NAME=A5

all: A5

clean:
	rm -rf A5 A5.o

A5: A5.asm
	nasm -f elf -F dwarf -g A5.asm
	gcc -no-pie -g -m32 -znoexecstack -o A5 A5.o driver.c asm_io.o
