; Sample debugging for Exam 3 - Spring 2024

; Describe what is happening in this piece of code. What is causing the segfault? 
; What is this situation usually called in higher level languages?

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Number: ", 0

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
        call figure_it_out
        add esp, 4

        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

figure_it_out:
        push ebp
        mov ebp, esp

        mov eax, [ebp + 8]
        inc eax

        call print_int

        push eax
        call figure_it_out
        add esp, 4

        add eax, 5

        pop ebp
        ret


