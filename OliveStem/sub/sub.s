section .data    

section .text 

global _start
_start:
    MOV eax,5
    MOV ebx,3
    SUB eax,ebx ;stores in eax
    INT 80h
