; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
width_prompt db "Enter a width for the structures: ", 0

; uninitialized data
segment .bss


segment .text
        global  asm_main
        extern  draw_line, draw_flag
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, width_prompt
        call print_string

        call read_int
        call print_nl

        push eax
        call draw_flag
        pop eax

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


