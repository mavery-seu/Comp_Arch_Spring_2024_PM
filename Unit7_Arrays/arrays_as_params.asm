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

		mov eax, original_message
		call print_string

		push NUMBERS_LENGTH
		push numbers
		call print_array_simple
		add esp, 8

		call print_nl

		mov eax, multiply_prompt
		call print_string
		call read_int

		push eax
		push NUMBERS_LENGTH
		push numbers
		call multiply_array_elements
		add esp, 12

		mov eax, multiplied_message
		call print_string

		push NUMBERS_LENGTH
		push numbers
		call print_array_simple
		add esp, 8
		
		call print_nl

		mov eax, shift_prompt
		call print_string
		call read_int

		push eax
		push NUMBERS_LENGTH
		push numbers
		call rotate_shift_array_left
		add esp, 12

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

multiply_array_elements:
		enter 0, 0
		push esi
		push ebx

		xor esi, esi
		mov ecx, [ebp + 12]
		mov ebx, [ebp + 8]

multiply_loop:
		mov eax, dword [ebx + BYTES_IN_INT * esi]
		imul eax, [ebp + 16]

		mov dword [ebx + BYTES_IN_INT * esi], eax

		inc esi
		loop multiply_loop

		pop ebx
		pop esi
		leave
		ret

rotate_shift_array_left:
		enter 4, 0
		push esi
		push edi
		push ebx

		
		mov ecx, [ebp + 16]
outer_loop:
		push ecx

		mov esi, 1

		mov ecx, [ebp + 12]
		dec ecx

		mov ebx, [ebp + 8]

		mov eax, [ebx]
		mov [ebp - 4], eax

shift_loop:
		mov edi, esi
		dec edi

		mov eax, [ebx + BYTES_IN_INT * esi]
		mov [ebx + BYTES_IN_INT * edi], eax

		inc esi
		loop shift_loop

		mov eax, [ebp + 8]
		mov ebx, [ebp + 12]
		imul ebx, BYTES_IN_INT
		sub ebx, BYTES_IN_INT

		add eax, ebx
 
		mov ebx, [ebp - 4]
		mov [eax], ebx

		pop ecx
		loop outer_loop

		pop ebx
		pop edi 
		pop esi
		leave
		ret

print_array_simple:
		enter 0, 0
		push esi
		push ebx

		xor esi, esi
		mov ecx, [ebp + 12]
		mov ebx, [ebp + 8]

print_loop:
		mov eax, dword [ebx + BYTES_IN_INT * esi]
		call print_int

		mov eax, space
		call print_string

		inc esi
		loop print_loop

		call print_nl

		pop ebx
		pop esi
		leave
		ret
		


