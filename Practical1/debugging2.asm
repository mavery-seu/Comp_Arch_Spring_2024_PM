; Author: Megan Avery - Spring 2024
;
; The programmer would have expected the 
; output to this code to be D, instead they 
; got what appears to be no output. What 
; important property of AL did the 
; programmer forget when writing their code?    
; How would you fix this code?

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

        mov al, "A"

        mov eax, prompt
        call print_string
        call read_int

        mov ebx, eax
        add al, bl

        call print_char

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


