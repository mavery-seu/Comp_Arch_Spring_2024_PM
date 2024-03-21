; Sample debugging for Exam 2 - Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
message db "BLEAT ", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		mov ecx, 5
loop_point:
        mov ecx, 3
inner_loop_point:
        mov eax, message
        call print_string

        loop inner_loop_point

        call print_nl

        loop loop_point

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


