; Author: Megan Avery Spring 2023
; Example - working with 2D arrays

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
BYTES_IN_INT EQU 4

matrix_rows dd 5
matrix_cols dd 4 

matrix times 20 dd 0

original_matrix db "Original Matrix: ", 0
update_question db "Update matrix? [y/n]: ", 0

row_question db "Row? ", 0
col_question db "Column? ", 0
new_int_question db "New integer? ", 0

updated_matrix db "Updated Matrix: ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		mov eax, original_matrix
		call print_string
		call print_nl

		push dword [matrix_cols]
		push dword [matrix_rows]
		push matrix
		call print_matrix
		add esp, 12

		call print_nl
		mov eax, update_question
		call print_string
		call read_char

		mov ebx, eax
		call read_char
update_while:
		cmp ebx, "y"
		jne end_while

		call print_nl

		push dword [matrix_cols]
		push matrix
		call update_matrix
		add esp, 8

		call read_char
		call print_nl

		push dword [matrix_cols]
		push dword [matrix_rows]
		push matrix
		call print_matrix
		add esp, 12

		call print_nl
		mov eax, update_question
		call print_string
		call read_char

		mov ebx, eax
		call read_char

		jmp update_while

end_while:

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

update_matrix:
		enter 0, 0
		push esi 
		push ebx
		
		mov eax, row_question
		call print_string
		call read_int

		mov ebx, eax	

		mov eax, col_question
		call print_string
		call read_int

		mov ecx, eax		

		mov eax, new_int_question
		call print_string
		call read_int

		mov edx, [ebp + 8]
		
		imul ebx, [ebp + 12]
		imul ebx, BYTES_IN_INT
		add edx, ebx

		imul ecx, BYTES_IN_INT
		add edx, ecx

		mov [edx], eax

		pop ebx
		pop esi
		leave
		ret

print_matrix:
		enter 0, 0
		push esi
		push ebx

		xor esi, esi
		mov ebx, [ebp + 8]
		mov ecx, [ebp + 12]
row_loop:
		push ecx
		mov ecx, [ebp + 16]
col_loop:
		mov eax, [ebx + BYTES_IN_INT * esi]
		call print_int

		mov eax, " "
		call print_char

		inc esi
		loop col_loop

		call print_nl

		pop ecx
		loop row_loop


		pop ebx
		pop esi
		leave
		ret

