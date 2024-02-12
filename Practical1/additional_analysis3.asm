; Author: Megan Avery - Spring 2024
;
; What is this piece of code doing to the bytes of
; the entered number? What happens if the user enters
; the base 10 version of 0FFFFFFFFH (-1)? 16843009?

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number: ", 0

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

 	mov eax, prompt
        call print_string
        call read_int
        
        dump_regs 1

        mov ebx, eax
        mov ecx, eax
        mov edx, eax

        and eax, 0FFH
        and ebx, 0FF00H
        and ecx, 0FF0000H
        and edx, 0FF000000H

        shr ebx, 8
        shr ecx, 16
        shr edx, 24

        add eax, ebx
        add eax, ecx
        add eax, edx

        call print_nl
        dump_regs 1

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


