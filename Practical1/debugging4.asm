; Author: Megan Avery - Spring 2024
;
; The programmer was attempting to divide the number given by 
; the user by -4. Unfortunately they made 2 glaring mistakes 
; during their attempt. Explain what they did wrong and how 
; you would fix it.

%include "asm_io.inc"

; initialized data
segment .data
number_prompt db "Enter a number: ", 0

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	mov eax, number_prompt
	call print_string
		
        call read_int
		
	mov ebx, eax
	not eax 

	shr eax, 2 

	call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


