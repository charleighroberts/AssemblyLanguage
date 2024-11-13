%include "/usr/local/share/csc314/asm_io.inc"


segment .data
msg    dd "enter a synmbol (*/#)",0,10
empty  dd " ",0
segment .bss
c dd 1

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    mov eax, msg			; prompt message
	call print_string		; print the prompt message
	call read_char			; read the symbol
    mov [c],eax 			; store the symbol in label c
	
    call print_char         ; print the symbol
    call print_nl			; print a new line
    
    call print_char
	mov eax, empty
    call print_string
	mov eax, [c]  
    call print_char
    call print_nl 
	
	call print_char
	mov eax, empty
	call print_string
	mov eax, [c]
	call print_char
	mov eax, empty
	call print_string
	mov eax, [c]
	call print_char
	call print_nl
   
    call print_char
	mov eax, empty
	call print_string
	mov eax, [c]
	call print_char
	mov eax, empty
	call print_string
	mov eax, [c]
	call print_char
    mov eax, empty
	call print_string
	mov eax, [c]
	call print_char
	call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
