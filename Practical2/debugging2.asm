; Sample debugging for Exam 2 - Spring 2024

%include "asm_io.inc"

; initialized data
segment .data

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		push dword 6
        call subprogram

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

subprogram:
        push ebp
        mov ebp, esp

        mov eax, [ebp + 8]
        imul eax, eax
        shr eax, 3
        sub eax, 2
        call print_int

        pop ebp
        ret



