%include  "asm_io.inc"


segment .data
string db "Hello World!", 0 ; The string with a null terminator

segment .bss

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    mov esi, string    ; pointer to the start of the string
    mov ecx, 5            ; Counter for 5 characters

write_loop:
    mov al, [esi]         ; current character from the string into AL
    call print_char        ; Print the character
    inc esi               ;move to next character
    loop write_loop       ; Repeat 

    call print_nl         ; Print a newline for better formatting

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

