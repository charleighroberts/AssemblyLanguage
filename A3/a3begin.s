section .data
    prompt db "Enter a guess: ",0
    too_high db "Too High!",0
    too_low db "Too Low!",0
    correct db "Correct!",0
      input_format db "%d", 0
    output_format db "%d", 10, 0

section .bss
   input resd 1
    random_num resb 1

section .text
    extern printf, scanf, rand, srand, time
    global _start

_start:
    ;generate a random number between 1 and 255
; Seed the random number generator
    push dword 0
    call time
    add esp, 4
    push eax
    call srand
    add esp, 4

    ; Generate a random number between 0 and 255
    call rand
    and eax, 255           ; Limit to 0-255
    mov [random_num], al  ; Store random number

guess_loop:
    ; Prompt user for input
    push prompt
    call printf
    add esp, 4

    ; Read user input
    push input_format
    push input
    call scanf
    add esp, 8

    ; Compare input with random number
    mov eax, [input]
    mov bl, [random_num]

    cmp eax, ebx
    je correct_guess       ; If equal, jump to correct_guess

    cmp eax, ebx
    jg too_high_guess
    jl too_low_guess

too_high_guess:
    push too_high
    call printf
    add esp, 4
    jmp guess_loop

too_low_guess:
    push too_low
    call printf
    add esp, 4
    jmp guess_loop

correct_guess:
    push correct
    call printf
    add esp, 4

    ; Exit program
    mov eax, 1            ; syscall: exit
    xor ebx, ebx          ; status: 0
    int 0x80