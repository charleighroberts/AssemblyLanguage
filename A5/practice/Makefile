NAME=prac

all: prac

clean:
	rm -rf  prac prac.o

prac: prac.asm
	nasm -f elf -F dwarf -g prac.asm
	gcc -no-pie -g -m32 -znoexecstack -o prac prac.o driver.c asm_io.o
