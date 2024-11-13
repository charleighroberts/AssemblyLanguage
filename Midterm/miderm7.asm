mov ebx, 5      
loop_start:
    mov eax, ebx  
    call print_int 
    dec eax      
    cmp eax, 0   
    jg loop_start