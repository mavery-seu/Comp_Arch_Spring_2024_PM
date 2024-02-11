; Author: Megan Avery - Spring 2024
;
; What is this piece of code doing to the number entered?
; Show all the steps and register values for the input 42.

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number between 1 - 99: ", 0

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

        xor edx, edx
        mov ecx, 10
        div ecx      ; divide EDX:EAX by ECX

        imul edx, 10 ; EDX holds the remainder
        add edx, eax ; EAX holds the quotient

        mov eax, edx

        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


