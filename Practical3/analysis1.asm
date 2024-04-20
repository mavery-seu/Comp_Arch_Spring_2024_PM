; Sample analysis for Exam 3 - Spring 2024

; Explain, in detail, how the assembly code is interacting with the C subroutines  
; in this piece of code. Why does this work? 

; initialized data
segment .data
prompt db "Number: ", 0
number_format db "%d", 0
message db 10, "Product: %d", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
                extern printf, scanf
asm_main:
        enter   8, 0               ; setup routine
        pusha

	push prompt
        call printf
        add esp, 4

        lea eax, [ebp - 4]
        push eax
        push number_format
        call scanf
        add esp, 8

        push prompt
        call printf
        add esp, 4

        lea eax, [ebp - 8]
        push eax
        push number_format
        call scanf
        add esp, 8

        mov eax, [ebp - 4]
        imul eax, [ebp - 8]

        push eax
        push message
        call printf
        add esp, 8
        
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


