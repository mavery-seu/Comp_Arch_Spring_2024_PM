; Original Author: Paul Carter
; Updated by: Megan Avery Summer 2023
; 
; Sample debugging for Exam 2, shows multimodule program - Spring 2024

%include "asm_io.inc"

; initialized data
segment .data

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		call alert

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


