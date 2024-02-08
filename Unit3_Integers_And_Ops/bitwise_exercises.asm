; Base Author: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]

; Purpose - to learn about the following:
;	- AND
;	- TEST
;	- OR
;	- XOR
;	- NOT

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

        ; test - AND numbers and sets flags
        ; doesn't store the answers
        mov eax, 4      ; eax = 4
        mov ebx, 2      ; ebx = 2

        ; do AND on eax and ebx, setting flags and not storing value
        test eax, ebx   ; sets the zero flag
        dump_regs 1     ; dump the registers

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


