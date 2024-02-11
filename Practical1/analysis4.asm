; Author: Megan Avery - Spring 2024
;
; What is this piece of code doing to the number 
; entered by the user? Show your thought process. 
; What topic discussed in class is this reminiscent of?

%include "asm_io.inc"

; initialized data
segment .data
number_prompt db "Enter a number: ", 0

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, number_prompt
        call print_string

        call read_int

        mov ebx, eax
        shr ebx, 16

        mov cl, al
        shr eax, 8
        mov ah, cl

        shl eax, 16

        mov ah, bl
        mov al, bh

        dump_regs 1

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


