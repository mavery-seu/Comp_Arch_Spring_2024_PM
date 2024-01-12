; Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
length_prompt db "How long is the string? ", 0
string_prompt db "Enter your string: ", 0

; uninitialized data
segment .bss
string_length resd 1

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, length_prompt
        call print_string

        call read_int

        mov [string_length], eax
        mov ecx, [string_length]

        call read_char
        mov eax, string_prompt
        call print_string

input_loop:
        call read_char
        push eax
        
        loop input_loop

        call print_nl
        mov ecx, [string_length]
remove_loop:
        pop eax
        call print_char

        loop remove_loop

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


