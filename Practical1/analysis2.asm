; Author: Megan Avery - Spring 2024
;
; Explain what each line of this code is doing. 
; Choose an input for it’s code and indicate what 
; it’s output will be.


%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number from 1 - 8: ", 0

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

        add eax, eax 
        imul eax, 5 
        sub eax, 5 
        add eax, 7 

        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


