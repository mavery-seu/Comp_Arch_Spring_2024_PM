; Sample code analysis for Exam 3 - Spring 2024

; What is the ouput for this piece of code? Explain how the
; string instructions are interacting with the regsiters in
; update letters.

%include "asm_io.inc"

%define CASE_DELTA 32

; initialized data
segment .data
chant db "#1 GoAt!", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        push dword 8
		push chant
        call update_letters
        add esp, 8

        mov eax, chant
        call print_string

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

update_letters:
        push ebp
        mov ebp, esp
        push esi

        xor eax, eax
        mov ecx, [ebp + 12]

        mov esi, [ebp + 8]
        mov edi, [ebp + 8]
loop_point:
        lodsb

        mov ebx, eax

        push eax
        call is_lowercase_letter
        add esp, 4

        cmp eax, 0
        je move_on

        mov eax, ebx
        sub eax, CASE_DELTA

        stosb
        jmp end_of_loop
move_on:
        inc edi
end_of_loop:
        loop loop_point

        pop esi
        pop ebp
        ret

is_lowercase_letter:
        push ebp
        mov ebp, esp

        mov eax, [ebp + 8]

        cmp eax, "a"
        jl no

        cmp eax, "z"
        jg no
        
        mov eax, 1
        jmp end
no:
        mov eax, 0
end:
        pop ebp
        ret
