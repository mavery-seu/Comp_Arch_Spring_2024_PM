; Sample debugging for Exam 2 - Spring 2024

; This code prints 1 no matter what the user inputs, what is wrong with the program?
; Explain in detail why this is a problem and how to fix it.

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number: ", 0

; uninitialized data
segment .bss

segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		mov eax, prompt
        call print_string

        call read_int

        push eax
        push dword 10
        call sub
        add esp, 8

        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

sub:
    mov eax, [ebp + 8]
    add eax, [ebp + 12]

    ret

