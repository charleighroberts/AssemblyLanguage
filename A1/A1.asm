%include "/usr/local/share/csc314/asm_io.inc"


segment .data
	promptA db 'Enter the value of A: ',0
    promptE db 'The value of E is: ',0


segment .bss
	num resd 1

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    mov eax, promptA
    call print_string
    call read_int
    mov [num],eax

    mov ebx, [num]  
    sub ebx, 10

    mov ecx, ebx
    add ecx, [num]

    mov edx, ecx
    sub edx, 1
    add edx, ebx

    mov eax, [num]
    add eax, edx

    mov [num], eax

    mov eax, promptE
    call print_string
    mov eax, [num]
    call print_int
    call print_nl
	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
