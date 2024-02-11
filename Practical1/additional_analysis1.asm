; Author: Megan Avery - Spring 2024
; 
; What overaching operating is being applied to the number
; the user enters? Explain how you know. What is the output
; for 14? -9?

%include "asm_io.inc"

; initialized data
segment .data
number_prompt db "Enter a number: ", 0

; uninitialized data
segment .bss
number resd 1
sign resd 1


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		mov eax, number_prompt
		call print_string

		call read_int

		mov dword [number], eax

		shr eax, 31
		and eax, 1

		mov dword [sign], eax

		imul eax, -1

		mov ebx, [number]
		xor eax, ebx
		add eax, [sign]

		call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


