; Author: Megan Avery Spring 2024
;
; This basic program does something fundamentally incorrect.
; Describe in detail what this is and how it could be fixed.

%include "asm_io.inc"

; initialized data
segment .data
greeting db "Greetings! Enter a number: ", 0
goodbye db "Goodbye!", 0

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, greeting
        call print_string

        call read_int
        call print_string

        mov eax, goodbye
        call print_string

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


