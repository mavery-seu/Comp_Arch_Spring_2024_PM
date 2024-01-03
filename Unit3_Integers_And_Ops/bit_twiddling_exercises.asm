; Base Authro: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]

; Purpose: showcase examples of bit twiddling

%include "asm_io.inc"

; initialized data
segment .data

; uninitialized data
segment .bss


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	; TODO: add code

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


