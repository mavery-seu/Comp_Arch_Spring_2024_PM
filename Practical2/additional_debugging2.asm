; Sample debugging for Exam 2 - Spring 2024

; This program has several things wrong with it, all leading up to a segmentation fault.
; What is wrong with this piece of code and what structural changes need to be made to it?

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number: ", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, prompt
        call print_string
        call read_int

        mov ebx, eax

        mov eax, prompt
        call print_string
        call read_int

        push eax
        push ebx
        call do_calculation
        add esp, 4

        call print_int
        
do_calculation:
        push ebp
        mov esp, ebp

        mov eax, [ebp + 8]
        add eax, [ebp + 12]

        pop ebp
        jmp do_calculation

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret




