%include  "asm_io.inc"


segment .data
prompt  db "Please input three non-zero integers.",10
        db "You must enter at least one integer.", 10
        db "Enter zero to terminate the input.",10,0
outmesg db "The sum of the numbers is: ",0
outmesg1 db "The maximum of the numbers is: ",0
outmesg2 db "The minimum of the numbers is: ",0

debug1 db "updated max is: ",0
debug2 db "updated min is: ",0
debug3 db "Current edx is: ",0
debug4 db "current max is: ",0
debug5 db "current min is: ",0

segment .bss
sum resd 1
max resd 1
min resd 1
c_max resd 1
c_min resd 1
c_esi resd 1

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
        mov eax, prompt         ; request input numbers
        call print_string
        xor ECX, ECX            ; ECX keeps number count
read_number:
        call GetInt             ; read input number
        cmp eax, 0              ; if the number is zero
        je stop_reading         ; no more numbers to read
        push eax                ; place the number on the stack
        inc ECX                 ; increment number count
        jmp read_number

stop_reading:
    push ECX                    ; place number count on the stack
    call variable_sum            ; returns sum
  
    mov [sum], eax              ; save the returned value in sum
    mov eax, outmesg            ; dislay the sum
    call print_string
    mov eax, [sum]
    call print_int
    call print_nl

	inc ECX                 ; increment number count
	push ECX
	call min_max				;returns min and max of numbers

	mov eax, outmesg1            ; dislay the max
    call print_string
    mov eax, [max]
    call print_int
    call print_nl
	
	mov eax, outmesg2            ; dislay the min
    call print_string
    mov eax, [min]
    call print_int
    call print_nl


	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

GetInt:
        push ebp                ; save original EBP
        mov ebp, esp            ; set EBP = ESP
        call read_int
        pop ebp                 ; restore original EBP
        ret

variable_sum:
        push ebp
        mov ebp, esp

        push ebx               ; save EBX
        push ecx               ; save ECX
        mov ecx, [ebp+8]       ; ECX:= # of integers to be added
        mov ebx, ebp
        add EBX, 12            ; EBX:= pointer to first number
        xor eax, eax           ; sum:= 0
        add_loop:
             add eax, [ebx]    ; sum:= sum + next number
             add ebx, 4        ; EBX points to the next integer
             loop add_loop     ; repeat count in ECX

        pop ecx           ; restore registers
        pop ebx
        pop ebp
        ret

min_max:
	push ebp
    mov ebp, esp
	;************code************
	push ebx               ; save EBX
	push ecx               ; save ECX
	push edx				;save EDX	
	

	mov ecx, [ebp+8]       ; ECX:= # of integers to be added (count)
	mov ebx, ebp
	add EBX, 12            ; EBX:= pointer to first number
	mov eax, [ebx]          ; start max with the first number
    mov edx, [ebx]          ; start min with the first number
	mov [c_max], eax      ; Store initial max for debugging
    mov [c_min], edx      ; Store initial min for debugging
   ; sub ecx, 1              ; Adjust count as we've processed the first number
    ;add ebx, 4              ; Move pointer to the next number
	;dec ecx               ; Adjust count for the remaining numbers
	min_max_loop:
		cmp ecx, 0              ; Check if there are zero number lest
    	je min_max_done         ; Exit loop if finished

    	mov esi, [ebx]          ; Load the next number into ESI
			
		cmp esi, eax            ; Compare with current max
		jle check_min           ; If ESI <= max, skip max update
		mov eax, esi            ; Update max
		mov [c_max], eax      ; Store updated max for debugging

		  ; Debug print for max
		mov eax, debug1        ; Debug message for max
		call print_string
		mov  eax, [c_max]      ; Current max value
		call print_int
		call print_nl

	check_min:
		cmp esi,edx          ; Compare with current min
    	jge next_iteration      ; If ESI >= min, skip min update
    	mov edx, esi            ; Update min
		mov [c_min], edx      ; Store updated min for debugging

		 ; Debug print for min
		;mov eax, debug2   ; Debug message for min
		;call print_string
		;mov eax, [c_min]      ; Current min value
		;call print_int
		;call print_nl

	next_iteration:
    add ebx, 4              ; Move to the next number
    loop min_max_loop       ; reduce the ECX and repeat loop
	min_max_done:
    mov [max], eax      ; Store max result
    mov [min], edx      ; Store min result

	;**************************
                ; Restore registers
	pop     edx
    pop     ecx
    pop     ebx
    pop     ebp
    ret