; Author: Megan Avery Spring 2024

segment .data
prompt1 db    "Enter a number: ", 0       ; don't forget nul terminator
prompt2 db    "Enter another number: ", 0

int_format db "%d", 0
output_format db    "You entered %d and %d, their sum is %d", 0

segment .bss
;
; These labels refer to double words used to store the inputs
;
input1  resd 1
input2  resd 1


segment .text
        global  asm_main
		extern scanf, printf
asm_main:
        enter   0,0               ; setup routine
        pusha

		; print first prompt
		push dword prompt1
		call printf
		pop ecx

		; get first input
		push input1
		push dword int_format
		call scanf
		add esp, 8

		; print second prompt
		push dword prompt2
		call printf
		pop ecx

		; get second input
		push input2
		push dword int_format
		call scanf
		add esp, 8

		; add numbers to get a sum
		mov eax, [input1]
		add eax, [input2]

		; print out the final message
		push eax
		push dword [input2]
		push dword [input1]
		push dword output_format
		call printf
		add esp, 16

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


