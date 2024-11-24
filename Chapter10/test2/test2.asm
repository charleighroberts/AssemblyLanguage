%include "asm_io.inc"


segment .data
prompt  db "Please input a set of non-zero integers.",10
        db "You must enter at least one integer.", 10
        db "Enter zero to trminate the input.",10,0
outmesg db "The sum of the input numbers is: ",0

segment .bss
sum resd 1

segment .text
	global  asm_main

asm_main:
        push ebp
        mov  ebp, esp
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
    call variable_sum           ; returns sum
  
    mov [sum], eax              ; save the returned value in sum
    mov eax, outmesg            ; dislay the sum
    call print_string
    mov eax, [sum]
    call print_int
    call print_nl

; *********** CODE ENDS HERE ***********
        mov eax, 0
        mov esp, ebp
        pop ebp
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

        pop ecx                ; restore registers
        pop ebx
        pop ebp
        ret