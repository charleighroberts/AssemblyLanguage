%include "/usr/local/share/csc314/asm_io.inc"


segment .data
  a dd 0
  b dd 0
  a_before db "Value of a before: ", 0
  b_before db "Value of b before: ", 0
  a_after db "Value of a after: ", 0
  b_after db "Value of b after: ", 0

segment .bss


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
	mov eax, a_before
    call print_string
	mov eax, [a]
	call print_int
    call print_nl
	mov eax, b_before
    call print_string
	mov eax, [b]
    call print_int
    call print_nl

	mov eax, [a]
	cmp eax, 0
	jg greater
	;else
	mov eax, 1
	mov [b], eax
	jmp end_if
greater:
	;set b to 0
	mov eax, 0
	mov [b],eax
end_if:
    mov eax, a_after
    call print_string
    mov eax, [a]
    call print_int
    call print_nl

    mov eax, b_after
    call print_string
    mov eax, [b]
    call print_int
    call print_nl


	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
