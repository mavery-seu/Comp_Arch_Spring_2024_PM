; Author: Megan Avery - Spring 2024
;
; What are the values (in hex) of EAX, EBX, and ECX 
; when the registers get dumped at line 44? 


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

        mov ecx, 0
        mov ch, 0B4H
        mov cl, 07AH

        mov ebx, 0CAFE0000H

        mov eax, ebx
        mov ah, cl
        mov al, ch

        dump_regs 1

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


