%include "/usr/local/share/csc314/asm_io.inc"


segment .data
	promptA db 'Enter a value for A: ',0
	promptB db 'Enter a value for B: ',0
	outmsg db 'The value of X = (17+A) * ((B*32)/A) + 123 - B is: ',0

segment .bss
	A resd 1
	B resd 1
	X resd 1

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
	;prompt for A
	mov eax, promptA
	call print_string
	call read_int
	mov eax, [A]
 	;prompt for B
	mov ebx, promptB
	call print_string
	call read_int
	mov ebx, [B] ;put B in both ebx and ecx
	mov ecx, [B] 

	;solve for X
	;step 1 B*32
	shl ebx,5 ;shift left by 5
 
	; (B*32) / A
	cdq	; sign extend eax into edx               
	idiv ebx ;take ebx and / by eax which is [A]

	;take (A + 17)
	add eax,17

	;step (A+17)  * ((B*32)/A)
	imul eax,ebx

	;step 5 add 123
	add eax,123

	;step 6 subtract b
	sub eax, ecx

	;put output into X
	mov [X],eax

	;output
	mov eax, outmsg
	call print_string
	mov eax, [A]
	call print_int
	call print_nl
	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
