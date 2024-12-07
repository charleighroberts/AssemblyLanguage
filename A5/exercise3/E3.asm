%include  "asm_io.inc"


segment .data
arr1 dd 1, 2, 4, 9, 6, 20, 30
space db " ",0

segment .bss
arr2 resd 7

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    cld   ;clears the direction flag
    mov esi, arr1   ;pointer arr1
    mov edi, arr2   ;pointer arr2
    mov ecx, 7       ; ecx is the loop counter
;loop_start:
    ;lodsd           ;copy the value from esi (arr1) to eax
    ;stosd           ;copies the values from eax to edi (arr2)
   ; movsd  ;option 2: lodsd and stosd can be combined into one command
   ;loop loop_start
    rep movsd ;option 3 to remove the loop_start
    
;print the elements of arr2
    mov ecx,7 
    mov edi, arr2
loop_read:
    mov eax, [edi]
    call print_int
    mov eax, space
    call print_string
    add edi, 4
    loop loop_read
call print_nl


	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

