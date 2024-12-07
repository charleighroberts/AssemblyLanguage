;Write an assembly program that performs the following:
;   1.	Input: A predefined array of integers stored in memory.
;   2.	Algorithm: Implement the Bubble Sort algorithm to sort the array in ascending order.
;   3.	Output: The sorted array stored back in memory.
;Detailed Requirements:
;   1.	Initialize the Array: Define an array of integers in your program. You can choose any set of unsorted integers as a test case. 
;   2.	Sorting Process:
;       o	Use the Bubble Sort algorithm:
;           	Compare adjacent elements in the array.
;           	Swap them if they are in the wrong order.
;           	Repeat this process for all elements until the array is sorted.
%include  "asm_io.inc"

segment .data
arr1 dd 50,41,62,4,63,81,1,11,34,20
space db " ",0

segment .bss
arr2 resd 10             ;;to sort in ascending order


segment .text
	global  asm_main

asm_main:
	push	ebp
	mov		ebp, esp
	; ********** CODE STARTS HERE **********
    cld   ;clears the direction flag
    mov esi, arr1   ;pointer arr1
    mov edi, arr2   ;pointer arr2
    mov ecx, 10      ; ecx is the loop counter
    rep movsd   ;option 3 to remove the loop_start ; copy data from arr1 to arr2
 
  ;buuble sort
    mov ecx, 10           ; Outer loop counter (array size)
bubble_outer:
    dec ecx               ; Reduce the number of elements to compare
    mov ebx, ecx          ; Inner loop counter
    mov esi, arr2         ; Start of the array

bubble_inner:
    mov eax, [esi]        ; Load current element
    mov edx, [esi + 4]    ; Load next element
    cmp eax, edx          ; Compare current and next
    jle no_swap           ; If current <= next, no need to swap

    ; Swap current and next elements
    mov [esi], edx        ; Place next element in current
    mov [esi + 4], eax    ; Place current element in next

no_swap:
    add esi, 4            ; Move to the next pair
    dec ebx               ; Dec inner loop counter
    jnz bubble_inner      ; Repeat until inner loop finishes

    cmp ecx, 1            ; If only one element left, sorting is done
    ja bubble_outer       ; Otherwise, repeat outer loop

    ; Print the sorted array
    mov ecx, 10           ; Number of elements to print
    mov esi, arr2         ; Start of the sorted array

print_sorted:
    mov eax, [esi]        ; Load current element
    call print_int        ; Print integer
    mov eax, space        ; Print space after number
    call print_string
    add esi, 4            ; Move to the next element
    loop print_sorted     ; Repeat until all elements are printed

    call print_nl         ; Print newline


	; *********** CODE ENDS HERE ***********
	mov		eax, 0
	mov		esp, ebp
	pop		ebp
	ret

