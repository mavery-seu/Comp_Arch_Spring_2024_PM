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
		; prologue
        enter   0,0               ; setup routine
        pusha

		; print message about the original matrix
		mov eax, original_matrix
		call print_string
		call print_nl

		; print the original matrix
		push dword [matrix_cols]
		push dword [matrix_rows]
		push matrix
		call print_matrix
		add esp, 12

		; print the update question and get answer
		call print_nl
		mov eax, update_question
		call print_string
		call read_char

		; consume extra newline character
		mov ebx, eax
		call read_char
; while to keep going as long as the user enters a lowercase y
update_while:
		cmp ebx, "y"
		jne end_while				; jump to the end if the user doesn't enter a y

		call print_nl				; print a newline character

		; call update_matrix
		push dword [matrix_cols]
		push matrix
		call update_matrix
		add esp, 8

		; consume newline character
		call read_char
		call print_nl

		; print the updated matrix
		push dword [matrix_cols]
		push dword [matrix_rows]
		push matrix
		call print_matrix
		add esp, 12

		; ask again if the user wants to update the matrix
		call print_nl
		mov eax, update_question
		call print_string
		call read_char			; get answer

		; consume the newline character
		mov ebx, eax
		call read_char

		; unconditional jump back to the top of the while loop
		jmp update_while

; the label for the end of the while loop
end_while:

		; epilogue
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

; Subprogram to update a matrix at a position gotten from the user
;
; method header: update_matrix(arr, num_cols)
;
; Stack Frame:
; ------------
; EBP + 12      paremter 2: the number of columns in the matrix
; EBP + 8       paremter 1: the address of the first element in the matrix
; EBP + 4       return address
; EBP           previous EBP
update_matrix:
		; prologue
		enter 0, 0

		; storing off ESI and EBX
		push esi 
		push ebx
		
		; get the row to update
		mov eax, row_question
		call print_string
		call read_int

		mov ebx, eax				; save off row to update

		; get the column to update
		mov eax, col_question
		call print_string
		call read_int

		mov ecx, eax				; save off column to update

		; get the new value for the matrix stop
		mov eax, new_int_question
		call print_string
		call read_int

		mov edx, [ebp + 8]			; move the address of matrix[0][0] into EDX
		
		imul ebx, [ebp + 12]		; multiple EBX (the row) by the number of columns (N)
		imul ebx, BYTES_IN_INT		; multiple that by 4
		add edx, ebx				; add N * row * 4 to the address of matrix[0][0]

		imul ecx, BYTES_IN_INT		; multiply the column by 4
		add edx, ecx				; add the column * 4 to address of matrix[0][0] + N * row * 4

		mov [edx], eax				; move the new value into matrix[row][col]

		; restore EBX and ESI
		pop ebx
		pop esi

		; epilogue
		leave
		ret

; Subprogram to print out the contents of an in matrix
;
; method header: print_matrix(arr, num_rows, num_cols)
;
; Stack Frame:
; ------------
; EBP + 16      paremter 3: the number of columns in the matrix
; EBP + 12      paremter 2: the number of rows in the matrix
; EBP + 8       paremter 1: the address of the first element in the matrix
; EBP + 4       return address
; EBP           previous EBP
print_matrix:
		; prologue
		enter 0, 0

		; save off ESI and EBX
		push esi
		push ebx

		xor esi, esi				; zero out the source index (i)
		mov ebx, [ebp + 8]			; move the address of matrix[0][0] into EBX
		mov ecx, [ebp + 12]			; move the number of rows into ECX
; loop that runs "rows" times
row_loop:
		push ecx					; save off outer loop's value fo ECX
		mov ecx, [ebp + 16]			; move the number of columns into ECX
; loop that runs "cols" times
col_loop:
		mov eax, [ebx + BYTES_IN_INT * esi]	; move matrix[i] into EAX, treating matrix like one long 1D array
		call print_int						; print matrix[i]

		; print a space
		mov eax, " "
		call print_char

		inc esi						; i++
		loop col_loop				; jump back to the top of the inner loop

		call print_nl				; print a newline character

		pop ecx						; restore outer loop's value of ECX from before
		loop row_loop				; loop back to the top of the outer loop

		; restore EBX and ESI
		pop ebx
		pop esi

		; epilogue
		leave
		ret

