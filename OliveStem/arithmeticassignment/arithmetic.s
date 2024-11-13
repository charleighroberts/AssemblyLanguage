%include "/mnt/c/Users/granite/Documents/AssemblyLanguage/linux-ex/asm_io.inc"
section .data
    promptA db 'Enter a value for A: ', 0
    promptB db 'Enter a value for B: ', 0
    outmsg db 'The value of X is: ', 0
    newline db 0xA
    formatIn db '%d', 0
    formatOut db '%d', 0

section .bss
    A resd 1
    B resd 1
    X resd 1

section .text
    global _start

_start:
    ; Prompt for A
    MOV edx, 21                ; length of prompt message
    MOV ecx, promptA           ; message to prINT
    CALL print_string

    ; Read input A
    CALL read_integer
    MOV [A], eax               ; store input in A

    ; Prompt for B
    MOV edx, 21                ; length of prompt message
    MOV ecx, promptB           ; message to prINT
    CALL prINT_string               ; system CALL

    ; Read input B
    CALL read_integer
    MOV [B], eax               ; store input in B              ; system CALL

    ; Load A and B into registers
    MOV eax, [A]               ; load A into eax
    MOV ebx, [B]               ; load B into ebx

    ; Calculate X = (17 + A) * ((B * 32) / A) + 123 - B
    ; Step 1: (17 + A)
    ADD eax, 17             ; eax = 17 + A

    ; Step 2: B * 32
    MOV ecx, ebx            ; copy B into ecx
    SHL ecx, 5              ; ecx = B * 32 (shift left by 5)

    ; Step 3: (B * 32) / A
    CDQ                     ; sign extend eax into edx:eax
    IDIV eax                ; eax = (B * 32) / A

    ; Step 4: (17 + A) * ((B * 32) / A)
    IMUL eax, ecx           ; eax = (17 + A) * ((B * 32) / A)

    ; Step 5: ADD 123
    ADD eax, 123            ; eax += 123

    ; Step 6: subtract B
    SUB eax, ebx            ; eax -= B

    ; Store result in X
    MOV [X], eax

    ; Output result
    MOV edx, 20                ; length of result message
    MOV ecx, resultMsg         ; message to print
    CALL print_string

    ; PrINT X
    MOV eax, [X]               ; load value of X
    CALL print_integer          ; Print the integer value

    ; Exit program
    MOV eax, 1              ; sys_exit
    XOR ebx, ebx            ; exit code 0
    INT 0x80                ; system CALL

