; Sample debugging for Exam 3 - Spring 2024

; This code works… sometimes. Non deterministic code is never the goal. 
; What did the programmer do wrong and how would they fix it? 
; Why did you choose that particular instruction to add?

%include "asm_io.inc"

NUMBERS_LENGTH EQU 5
BYTES_IN_INT EQU 4

; initialized data
segment .data
numbers dd 10, 11, 12, 13, 14
space db " ", 0

; uninitialized data
segment .bss


segment .text
	global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        push NUMBERS_LENGTH
	push numbers
        call rotate_right
        add esp, 8

        push NUMBERS_LENGTH
        push numbers
        call print_array_simple
        add esp, 8

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

rotate_right:
        push ebp
        mov ebp, esp
        sub esp, 4
        push esi
        push edi
        push ebx

        mov esi, [ebp + 8]
        mov eax, [ebp + 12]
        dec eax 
        shl eax, 2

        add esi, eax

        mov ebx, [esi]
        mov [ebp - 4], ebx

        mov ecx, [ebp + 12]
        dec ecx

        mov edi, esi
        
        sub esi, 4

        mov eax, [edi]
        
        rep movsd

        mov ebx, [ebp - 4]
        mov [edi], ebx

        pop ebx
        pop edi
        pop esi
        mov esp, ebp
        pop ebp
        ret

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

