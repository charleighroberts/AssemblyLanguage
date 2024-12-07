;write an assembly program that 
;1. reads a string into an array by calling read_char until /n is enter
;2 prints the number of A's, B's and C's in the input array

%include  "asm_io.inc"


segment .data

        numA            dd      0
        numB            dd      0
        numC            dd      0

segment .bss
        myString resb 1

segment .text
        global  asm_main

asm_main:
        push    ebp
        mov             ebp, esp
        ; ********** CODE STARTS HERE **********
        ;READ THE STRING
        mov ecx, 0   ;ecx is the loop counter
read_loop_start:
        call read_char
        mov BYTE[myString +ecx*1], al  ;store character from keyboard is store in al
        cmp al, 10                     ; compare the character to \n
        je read_loop_end
        inc ecx
        jmp read_loop_start
read_loop_end:

        ;LOOPCKUP THE STRING FOR LETTERS A, B AND C
        mov             ecx, 0
        do:

                cmp     BYTE [myString + ecx * 1], 'A'
                jne             nota
                        inc      WORD[numA]
                        inc ecx
            jmp do
                nota:

                cmp     BYTE [myString + ecx * 1], 'B'
                jne             notb
                        inc      WORD[numB]
                        inc ecx
                        jmp do
                notb:

                cmp     BYTE [myString + ecx * 1], 'C'
                jne             notc
                        inc      WORD[numC]
                        inc ecx
                        jmp do
                notc:

        inc             ecx
        cmp             BYTE [myString + ecx * 1], 0
        jne             do

        mov             eax, DWORD [numA]
        call    print_int
        call    print_nl

        mov             eax, DWORD [numB]
        call    print_int
        call    print_nl

        mov             eax, DWORD [numC]
        call    print_int
        call    print_nl

        ; *********** CODE ENDS HERE ***********
        mov             eax, 0
        mov             esp, ebp
        pop             ebp
        ret
