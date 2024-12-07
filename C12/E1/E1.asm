%include  "asm_io.inc"


segment .data
arr dd 1, 2, 4, 9, 6
outmesg db "The sum of the elements of the array is: ",0
space db ", ",0

segment .bss

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    mov esi, 0 ;option 2
    mov ecx, 5
    mov edi, 0 ;edi is the sum
loop_start:
    mov eax, [arr + esi] ;option 2
    add edi, eax
    add esi, 4 ;when array is dd
    loop loop_start
;print the sum of the array
    mov eax, outmesg
    call print_string
    mov eax, edi
    call print_int
    call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

