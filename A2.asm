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
	mov [A], eax
	call print_int
	call print_nl


 	;prompt for B
	mov eax, promptB
	call print_string
	call read_int
	mov [B],eax
	call print_int
	call print_nl

;move A and B into registers
	mov eax, [B]
	mov ebx, [B]
	mov ecx, [A]

	;step 1 B*32
	shl eax,5 ;shift left by 5
 
	;step 2  (B*32) / A
	cdq	; sign extend eax into edx               
	idiv ecx; idiv = (eax/ecx) quotient stored in eax

	;step 3 take A+17
	add ecx,17
	
	;step 4 (A+17) * ((B*32)/A)
	imul eax,ecx

	;step 5 add 123
	add eax,123

	;step 6 subtract b
	sub  eax, ebx

	;put output into X
	mov [X],eax

	;output
	mov eax, outmsg
	call print_string
	mov eax, [X]
	call print_int
	call print_nl
	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
