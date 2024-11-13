%include "/usr/local/share/csc314/asm_io.inc"


segment .data
	prompt db 'Enter a number: ',0
	prime db 'The number you entered was prime.',0
	notprime db 'The number you entered was not prime.',0

segment .bss
	num resd 1

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    mov eax, prompt
    call print_string
    call read_int
    mov [num],eax

    cmp eax,1
    jle print_notprime  ;if n <= 1

    mov eax,2 ;i =2
    loop_start:
    mov eax, [num]
    cdq
    idiv ecx ;n/2
    cmp edx ;compare the remainder with 0
    jz print_notprime
    inc ecx ;i++
    cmp ecx,eax ;compare i with n
    jl loop_start
    mov eax, prime
    call print_string
    jmp loop_end

print_notprime:
    mov eax, notprime
    call print_string
    call print_nl

loop_end:
    call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
