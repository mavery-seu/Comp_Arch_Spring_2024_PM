; Author: Paul Carter
; Transcribed from textbook by Megan Avery
; Spring 2024
;
; Used for tracing in class

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
prompt db "Calculate factorial of? ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		mov		eax, prompt		  ; prompt for number
		call 	print_string
		call 	read_int

		push 	eax				  ; put param on stack
		call 	factorial         ; first call the factorial
		pop		ecx				  ; take the param back off

		call	print_int		  ; print the answer

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

factorial:
		enter 0, 0
		
		mov 	eax, [ebp + 8]	  ; eax = n
		cmp 	eax, 1			  
		jbe 	term_condition	  ; if n <= 1, terminate

		dec 	eax				  
		push 	eax
		call 	factorial		  ; eax = factorial(n - 1)
		pop 	ecx				  ; answer lives in eax

		mul 	dword [ebp + 8]   ; edx:eax = eax * [ebp + 8]
		jmp short end_factorial

term_condition:
		mov 	eax, 1
		dump_stack 1, 2, 11
		call print_nl

end_factorial:
		leave
		ret
