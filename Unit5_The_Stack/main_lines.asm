; Original Author: Paul Carter
; Updated by: Megan Avery Summer 2023
; 
; Purpose: skeleton file for writing an assembly program

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

        push -1
        push eax
        call draw_line
        add esp, 8

        call print_nl

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


