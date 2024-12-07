%include  "asm_io.inc"


segment .data
;arr db 1, 2, 4, 69, 6
;arr dw 1, 2, 4, 69, 6
arr dd 1, 2, 4, 69, 6
space db ", ",0

segment .bss

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    mov esi, arr
    ;mov esi, 0 ;option 2
    mov ecx, 5
loop_start:
    mov al,[esi]
    ;mov eax, [arr + esi] ;option 2
    movzx eax, al
    call print_int
    mov eax, space
    call print_string
   ;inc esi  ;when array is db
  ; add esi, 2 ;when array is dw
   add esi, 4 ;when array is dd
    loop loop_start

   call print_nl

	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

