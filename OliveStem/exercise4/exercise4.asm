%include "/mnt/c/Users/granite/Documents/AssemblyLanguage/linux-ex/asm_io.inc"

segment .data
prompt db "Enter a number n: ",0
outmesg1 db "square of ",0
outmesg2 db " is ",0
outmesg3 db "cube of ",0
outmesg4 db "times 20 is ",0
outmesg5 db "The quotient of cube/10 is ",0
outmsg6 db "The remainder of cube/10 is ",0
outmsg7 db "The negation of the remainder of cube/10 is ",0

segment .bss
n resd 1 ;reserve memory for a double word
cube resd 1; reserve memory to store the result of a cub

segment .text
    global asm_main

asm_main:
    push ebp
    mov ebp,esp
    ;********************************
    mov eax, prompt
    call print_string
    call read_int
    mov [n],eax

    ;calculate the square
    imul eax ;eax * eax the result is in edx:eax
    mov ebx, eax
    mov ebx,outmesg1
    call print_string
    mov eax,[n]
    call print_int
    mov eax,outmesg2
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    ;****************************
    mov eax,0
    mov esp,ebp
    pop ebp
    ret