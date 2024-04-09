; Author: Megan Avery Spring 2023
; Example - working with arrays as parameters in subprograms

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
NUMBERS_LENGTH EQU 10
BYTES_IN_INT EQU 4

multiply_prompt db "Enter number to multiply by: ", 0
shift_prompt db "Enter number to rotate shift left by: ", 0

original_message db "Original Array: ", 0
multiplied_message db "Multiplied Array: ", 0
shifted_message db "Shifted Array: ", 0

numbers dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
space db " ", 0


segment .bss
;
; uninitialized data is put in the bss segment
;

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		; print message about the original array
		mov eax, original_message
		call print_string

		; print the original array for the first time
		push NUMBERS_LENGTH
		push numbers
		call print_array_simple
		add esp, 8

		call print_nl

		; get number to multiply each element in array by
		mov eax, multiply_prompt
		call print_string
		call read_int

		; call subprogram to multiply each element in the array
		; by the factor given by the user
		push eax
		push NUMBERS_LENGTH
		push numbers
		call multiply_array_elements
		add esp, 12

		; print out multiplied array
		mov eax, multiplied_message
		call print_string

		push NUMBERS_LENGTH
		push numbers
		call print_array_simple
		add esp, 8
		
		call print_nl

		; get amount to rotate shift left by
		mov eax, shift_prompt
		call print_string
		call read_int

		; call subprogram to rotate shift the array
		push eax
		push NUMBERS_LENGTH
		push numbers
		call rotate_shift_array_left
		add esp, 12

		; print out the shifted array
		mov eax, shifted_message
		call print_string

		push NUMBERS_LENGTH
		push numbers
		call print_array_simple
		add esp, 8

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

; Subprogram to multiply every element in an int array 
; by a given factor
;
; method header: multiply_array_elements(arr, arr_size, factor)
;
; Stack Frame:
; ------------
; EBP + 16      paremter 3: the factor to multiply by
; EBP + 12      paremter 2: size of the array
; EBP + 8       paremter 1: the address of the first element in the array
; EBP + 4       return address
; EBP           previous EBP
multiply_array_elements:
		; prologue
		enter 0, 0

		; save off ESI and EBX 
		push esi
		push ebx

		xor esi, esi		; 0 out the source index
		mov ecx, [ebp + 12]	; move the size of the array into ECX
		mov ebx, [ebp + 8]	; ove the starting address into EBX

; for loop to run over each element in the array and multiply it by the factor
multiply_loop:
		mov eax, dword [ebx + BYTES_IN_INT * esi]	; move the current value of arr[i] into EAX
		imul eax, [ebp + 16]						; multiply value of arr[i] by factor

		mov dword [ebx + BYTES_IN_INT * esi], eax	; arr[i] = updated value

		inc esi										; add one to ESI to move down one spot in the array
		loop multiply_loop							; loop back to the top

		; restore ESI and EBX
		pop ebx
		pop esi

		; epilogue
		leave
		ret

; Subprogram to rotate shift the given array left by the given amount
;
; method header: rotate_shift_array_left(arr, arr_size, rotate_amount)
;
; Stack Frame:
; ------------
; EBP + 16      paremter 3: the amount to rotate left by
; EBP + 12      paremter 2: size of the array
; EBP + 8       paremter 1: the address of the first element in the array
; EBP + 4       return address
; EBP           previous EBP
; EBP - 4		placeholder for the first element in the array
rotate_shift_array_left:
		; prologue - making room for 1 local variable
		enter 4, 0

		; save off ESI, EDI, and EBX
		push esi
		push edi
		push ebx
		
		mov ecx, [ebp + 16]		; move amount to rotate into ECX
outer_loop:
		push ecx				; save off outer value of ECX

		mov esi, 1				; move 1 into the source index (ESI) (i = 1)

		mov ecx, [ebp + 12]		; move the size of the array into ECX
		dec ecx					; ECX-- 

		mov ebx, [ebp + 8]		; move the address of the first element into EBX

		mov eax, [ebx]			; move the value at arr[0] into EAX
		mov [ebp - 4], eax		; save the value of arr[0] into the local variable

; innner loop to shift every element to the left one spot
; will run size of array - 1 times
shift_loop:
		mov edi, esi			; move the source index (ESI) into the destination index (EDI)
		dec edi					; EDI--, to get ready to shift to the left

		mov eax, [ebx + BYTES_IN_INT * esi]	; EAX = arr[i]
		mov [ebx + BYTES_IN_INT * edi], eax	; arr[i - 1] = arr[i]

		inc esi								; ESI++ (i++)
		loop shift_loop						; loop back to the top of the inner loop

		mov eax, [ebp + 8]					; EAX = address of first element 
		mov ebx, [ebp + 12]					; EBX = size of the array
		imul ebx, BYTES_IN_INT				; EBX *= 4
		sub ebx, BYTES_IN_INT				; EBX -= 4 

		add eax, ebx						; EAX is the address of the last element in the array
 
		mov ebx, [ebp - 4]					; move local variable (the original first element in the array) into EBX
		mov [eax], ebx						; move EBX into value at EAX, move original first element to the end of the array

		pop ecx								; restore ECX to its value for the outer loop
		loop outer_loop						; loop back to the top of the outerloop

		; restore EBX, EDI, and ESI
		pop ebx
		pop edi 
		pop esi

		; epilogue
		leave
		ret

; Subprogram to print the contents of an integer array
; numbers separated by spaces
;
; method header: print_array_simple(arr, arr_size)
;
; Stack Frame:
; ------------
; EBP + 12      paremter 2: size of the array
; EBP + 8       paremter 1: the address of the first element in the array
; EBP + 4       return address
; EBP           previous EBP
print_array_simple:
		; progogue
		enter 0, 0

		; storing off ESI and EBX
		push esi
		push ebx

		xor esi, esi				; zero out the source index (i)
		mov ecx, [ebp + 12]			; move size of array into ECX (loop counter)
		mov ebx, [ebp + 8]			; move address of first element in array into EBX

; loop to print out each element in the array then a space
print_loop:
		mov eax, dword [ebx + BYTES_IN_INT * esi]	; move arr[i] into EAX
		call print_int								; print arr[i]

		; print a space
		mov eax, space	
		call print_string

		inc esi										; i++
		loop print_loop								; loop back to the top of the for loop

		call print_nl								; print a newline 

		; restore EBX and ESI
		pop ebx
		pop esi

		; epilogue
		leave
		ret
		


