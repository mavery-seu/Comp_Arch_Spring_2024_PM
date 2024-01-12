; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
shift_amount dd 4
num_letters dw 27

character_prompt db "character for encodingm: ", 0

encode_message db " encodes to ", 0

; uninitialized data
segment .bss
choice resb 1
character resb 1


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, character_prompt
        call print_string

        mov ebx, character
        mov ecx, $ + 7
        jmp short get_character

        mov ecx, end
        jmp encode

end:
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

get_character:
        xor eax, eax
        call read_char
        mov [ebx], eax

        call read_char

        jmp ecx

encode:
        xor eax, eax
        mov eax, [character]
        add eax, [shift_amount]

        mov ebx, eax

        mov edx, eax
        sub edx, 'z'
        dec edx

        cmp edx, 0
        jl no_wrap

        mov ebx, 'a'
        add ebx, edx

no_wrap:
        xor eax, eax
        mov eax, [character]
        call print_char

        mov eax, encode_message
        call print_string

        mov eax, ebx
        call print_char

        call print_nl

        jmp ecx


