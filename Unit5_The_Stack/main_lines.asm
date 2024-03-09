; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
width_prompt db "Enter a width for the structures: ", 0

; uninitialized data
segment .bss


segment .text
        global  asm_main
        extern  draw_line, draw_flag     ; mark these subprograms as living in other files
asm_main:
        ; prologue
        enter   0,0               ; setup routine
        pusha

        mov eax, width_prompt           ; move width_prompt into EAX
        call print_string               ; print width_prompt

        call read_int                   ; get the width from the user
        call print_nl                   ; print a newline

        push eax                        ; push the width onto the stack
        call draw_flag                  ; push the return address onto the stack and jump to draw_flag
        pop eax                         ; pop the width from the stack and store it in EAX

        ; epilogue
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


