; •	Prompt the user to enter a series of integers to populate an array.
; •	Use a subprogram to determine and count the number of even numbers and the number of odd numbers in the array.
; •	Display the counts of even and odd numbers to the user.
;requirements:
;•	Your program should allow the user to specify the number of elements in the array.
;•	The program should read integers from the user as input and store them in an array.
;•	Implement a subprogram that:
;	o	Accepts the array and its size as parameters.
;	o	Iterates through the array to check each element.
;	o	Counts how many elements are even and how many are odd.
;•	The main program should call the subprogram and display the results (i.e., the count of even numbers and odd numbers).



%include  "asm_io.inc"

segment .data
prompt db "How many numbers will you enter: ", 0
enter_msg db "Please enter a series of numbers:",0
even_msg db "Number of even numbers: ", 0
odd_msg db "Number of odd numbers: ", 0

segment .bss
elements resd 1   ;space for number of elements
arr resd 100        ;reserve space for up to 100 ints
even_count  resd 1       ;space for even # count
odd_count resd 1            ; space for odd count


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
 ; Prompt user for the number of elements
    mov eax, prompt
    call print_string
    call read_int
    mov [elements], eax
	call print_nl

; Prompt user to enter the series of integers
    mov eax, enter_msg
    call print_string
    mov ecx, [elements]   ; Loop counter set to number of elements
    mov edi, arr            ; Point to the start of the array
	call print_nl

input_loop:
    call read_int             ; Read an integer from the user
    mov [edi], eax      ; Store the integer in the array
    add edi, 4                ; Move to the next element in the array
    loop input_loop           ; Repeat for all elements

; Initialize counts
    mov dword [even_count], 0
    mov dword [odd_count], 0

; count even and odd numbers
    mov ecx, [elements]   ; Pass the size of the array in ECX
    mov edi, arr           ; Pass the address of the array in EDI
    call count_even_odd

; Results display
    mov eax, even_msg
    call print_string
    mov eax, [even_count]
    call print_int
    call print_nl

    mov eax, odd_msg
    call print_string
    mov eax, [odd_count]
    call print_int
    call print_nl


	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

; Count even and odd numbers
count_even_odd:
    push ebp
    mov ebp, esp

    mov esi, edi              ; Point to the start of the array

count_loop:
    mov eax, [esi]            ; Load the current element
    test eax, 1               ; Check the least significant bit
    jz is_even                ; If 0, it's even
    ; Odd case
    inc dword [odd_count]
    jmp next_element

is_even:
    ; Even case
    inc dword [even_count]

next_element:
    add esi, 4                ; Move to the next element
    loop count_loop           ; Repeat for all elements

    mov esp, ebp
    pop ebp
    ret
              