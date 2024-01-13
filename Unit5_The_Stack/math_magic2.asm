; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter number between 1 and 100: ", 0
error_message db "Not in range, try again: ", 0
answer_message db "Your new number is: ", 0

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	; number between 1 - 100
        call get_number

        push eax
        call do_magic
        pop ebx

        mov ebx, eax

        mov eax, answer_message
        call print_string

        mov eax, ebx
        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

get_number:
        push    ebp
        mov     ebp, esp
        
        mov eax, prompt
        call print_string
        
get_int:
        call read_int

        cmp eax, 1
        jl invalid_number

        cmp eax, 100
        jg invalid_number

        jmp valid_number

invalid_number:
        mov eax, error_message
        call print_string

        jmp get_int        

valid_number:
        pop     ebp
        ret

do_magic:
        push    ebp
        mov     ebp, esp

        mov eax, [ebp + 8]
        shl eax, 1

        push 15
        push eax
        call add
        add esp, 8

        push 3
        push eax
        call multiply
        add esp, 8

        push 33
        push eax
        call add
        add esp, 8

        push 6
        push eax
        call divide
        add esp, 8

        push dword [ebp + 8]
        push eax
        call subtract
        add esp, 8

        pop     ebp
        ret

add:
        push    ebp
        mov     ebp, esp

        mov eax, [ebp + 8]
        add eax, [ebp + 12]

        pop     ebp
        ret

multiply:
        push    ebp
        mov     ebp, esp

        mov eax, [ebp + 8]
        imul eax, [ebp + 12]

        pop     ebp
        ret

divide:
        push    ebp
        mov     ebp, esp

        mov eax, [ebp + 8]
        mov ebx, [ebp + 12]

        div bl

        and eax, 255

        pop     ebp
        ret

subtract:
        push    ebp
        mov     ebp, esp

        mov eax, [ebp + 8]
        sub eax, [ebp + 12]

        pop     ebp
        ret


