%include "/usr/local/share/csc314/asm_io.inc"

segment .data
	x dw 14
	y db 5
segment .bss
	q resb 1
	r resb 1

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
	mov ax, [x]
	mov cl, [y]
	div cl
	; assign the quotient to the label q
     mov [q], al
    ; assign the remainder to the label r
     mov [r], ah

	;*** print the quotient ***
	movzx eax, byte[q]
	call print_int
	call print_nl

	;*** print the remainder ***
	movzx eax, byte [r]
	call print_int
	call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret