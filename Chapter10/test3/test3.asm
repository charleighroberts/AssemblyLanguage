%include "asm_io.inc"

segment .data
msg1  db "enter N: ",0
msg2  db "The first ",0
msg3 db " Fibonacci numbers are: ", 0
space db " ",0

segment .bss
N resd 1

segment .text
        global  asm_main

asm_main:
        push    ebp
        mov             ebp, esp
   ; ********** CODE STARTS HERE **********
    mov eax, msg1                   ; eax = address of msg1
    call print_string               ; print msg1
    call read_int                   ; get an integer from the keyboard (in EAX)
    mov [N], eax                    ; store the integer in N

    mov ecx, 0                      ; ecx is the loop counter (i=0)
    push ecx                        ; put the loop counter (i) on the stack (parameter of Fibonacci function)

    mov eax, msg2                   ; eax = address of msg2
    call print_string               ; print msg2
    mov eax, [N]                    ; eax := [N]
    call print_int                  ; print N
    mov eax, msg3                   ; eax = address of msg3
    call print_string               ; print msg3
loop_start:
    call Fibonacci                  ; call Fibonacci subprogram
    call print_int                  ; print Fibonacci(i)
    mov eax, space                  ; add a space between the printed values
    call print_string               ; print the space
    inc ecx                         ; increment the loop counter
    push ecx                        ; put the loop counter on the stack
    cmp ecx, [N]                    ; compare the loop counter (i) to N
    jge loop_end                    ; if i >= N, goto loop_end
    jmp loop_start                  ; otherwise, goto loop_start

loop_end:
call print_nl                       ; print a new line

; *********** CODE ENDS HERE ***********
        mov             eax, 0
        mov             esp, ebp
        pop             ebp
        ret

Fibonacci:
    enter 4,0                       ; i is in [ebp+8]
                                    ; local var x = Fibonacci(i-1) is in [ebp - 4]
    mov eax, [ebp +8]               ; eax = i
        ;if N = 0
    cmp eax, 0
    jne else1
    jmp end

else1:
       ;if N = 1
    cmp eax, 1
    jne next
    jmp end
next:
    mov eax, [ebp+8]                ; eax = i
    sub eax, 1                      ; eax:= eax - 1
    push eax                        ; put (i-1) on the stack
    call Fibonacci                  ; call Fibonacci(i-1)
    add esp, 4                      ; remove (i-1) from the stack
    mov [ebp-4], eax                ; put the returned value in x

    mov eax, [ebp+8]                ; eax =i
    sub eax, 2                      ; eax:= eax -2
    push eax                        ; put (i-2) on the stack
    call Fibonacci                  ; call Fibonacci(i-2)
    add esp, 4                      ; remove (i-2) from the stack
    add eax, [ebp-4]                ; eax:= eax + x
    jmp end
end:
    leave
    ret