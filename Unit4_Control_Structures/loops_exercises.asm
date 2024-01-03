; Base Author: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]
;
; Purpose - to learn about loops in NASM

%include "asm_io.inc"
segment .data						; initialized data


segment .bss						; uninitialized data


segment .text						; code
        global  asm_main
asm_main:
        enter   0,0               	; setup routine
        pusha

		; TODO: FOR EXERCISE

		; TODO: WHILE EXERCISE

		; TODO: DO WHILE EXERCISE

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
