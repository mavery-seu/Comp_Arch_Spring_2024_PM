; Sample debugging for Exam 2 - Spring 2024

%include "asm_io.inc"

segment .data
message  db  "DANGER WILL ROBINSON!", 0

segment .bss

segment .text
        global  alert

alert:
        mov eax, message
        call print_string

        ret                        ; jump back to caller







