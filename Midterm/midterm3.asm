%include "/usr/local/share/csc314/asm_io.inc"


segment .data
	x db 17

segment .bss

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
	mov eax, x
    mov ebx, 10
	add ebx, eax
	call print_int
	
	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret