; Author: Megan Avery Spring 2024

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

	push dword 1
        push dword 3
        push dword 4

        mov eax, [esp]
        call print_int
        call print_nl

        mov eax, [esp + 4]
        call print_int
        call print_nl

        mov eax, [esp + 8]
        call print_int
        call print_nl

        pop eax
        pop eax
        pop eax

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


