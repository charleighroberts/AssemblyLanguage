%include "/usr/local/share/csc314/asm_io.inc"


segment .data
	prompt db "Enter a guess: ",0
	too_high db "Too high",0
	too_low db "Too low",0
	correct db "Correct!",0
	random_msg db "Random number is : ",0 ;for testing purposes

segment .bss
	guess resd 1
	random resb 1

segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
	;generate a random number  0-255
	mov ebx,0  
	mov bl,cl;store random number
	mov [random],bl

	;print random number for testing purposes
	mov eax,random_msg
	call print_string
	movzx eax,byte[random]
	call print_int
	call print_nl

guess_loop:
;get guess
	mov eax, prompt
	call print_string
	call read_int
	mov [guess], eax
	mov al,[guess] 
;compare guess with random number
	cmp al,[random] ;compare guess with random
	je correct_guess  ;if guess == random go to correct guess
;check if guess is too high
	jl toolow  ;if guess < random 
	mov eax, too_high
	call print_string
	call print_nl
	jmp guess_loop  ;ask for another guess
toolow:
	mov  eax, too_low
	call print_string
	call print_nl
	jmp guess_loop
correct_guess:
	mov eax, correct
	call print_string
	call print_nl


	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret
