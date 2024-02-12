; Original Author: Paul Carter
; Updated by: Megan Avery Summer 2023
; 
; Explain what this piece of code is doing. 
; What is the output for the input 13? The input 12? 
; Show all your work.

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

        mov ebx, eax
        and ebx, 1
        mov ecx, ebx

        ror ebx, 1
        sar ebx, 31

        xor eax, ebx
        add eax, ecx

        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


