; Author: Megan Avery - Spring 2024
;
; What rule for mov did this program 
; violate? What is a way that this error 
; could be fixed?


%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number: ", 0

; uninitialized data
segment .bss
number resw 1

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, prompt
        call print_string
        call read_int

        mov word [number], eax
        add word [number], 4
                        
        mov eax, dword [number]
        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


