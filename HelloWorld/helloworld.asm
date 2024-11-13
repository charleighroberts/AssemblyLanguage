section.data
hello db 'Hello, World',0 ;Define a null-terminating string

section.text
global_start ;define the program entry point

_start:
;write the string to stdout
mov eax, 4 ;sys_write system call number (linux)
mov ebx, 1 ;File descriptor 1 (stdout)
mov ecx, hello ;pointer to the string to be printed
mov edx, 13 ;number of bytes to write
int 0x80 ;call the kernal

