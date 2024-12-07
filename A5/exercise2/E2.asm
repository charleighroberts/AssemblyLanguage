%include  "asm_io.inc"


segment .data
arr dd 10, 20, 30, 40, 50  ;declare an array with inital values
arraysize equ 5   ;define size of array
sum dd 0
outmesg db "The sum of the elements of the array is: ",0
space db ", ",0

segment .bss

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    mov ecx, 0     ;loop counter
    mov esi, array ;pointer to the beginning of the array
    mov edi, sum    ;pointer to the sum var
loop_start:
    mov eax, [arr + esi * 4] ;load the current array element into eax uring indirect addressing
                            ;assuming each element is a 32-bit integer
    add [edi], eax           ; add the current array element to the sum
    inc ecx                  ;increment loop counter
    cmp ecx, array_size          ; check if we have reached the end of the array
    jl loop_start              ; jump to  array_loop (loop_start) if ecx is less than array size
    
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

