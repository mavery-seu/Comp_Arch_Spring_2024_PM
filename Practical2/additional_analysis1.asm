; Sample analysis for Exam 2 - Spring 2024

; Describe what this code is doing. What are the parameters for the subprogram?
; When does the while loop in the main stop running?

%include "asm_io.inc"

%define TARGET 10
%define LIMIT 100

; initialized data
segment .data
factor_prompt db "Enter a factor: ", 0
base_number_prompt db "Enter a base number: ", 0
success_message db "Nice! You were able to reach the target!", 0
fail_message db "Oh... you were never successfull", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, factor_prompt
        call print_string
        call read_int

        mov ebx, eax
        mov eax, base_number_prompt
        call print_string
        call read_int

        mov ecx, 0
while:
        cmp eax, TARGET
        je success_end

        cmp ecx, LIMIT
        jge fail_end

        push eax
        push ebx
        call additive_increase_multiplicative_decrease
        pop ebx
        add esp, 4
        
        inc ecx
        jmp while

success_end:
        mov eax, success_message
        jmp while_end
fail_end:
        mov eax, fail_message
while_end:
        call print_string

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

additive_increase_multiplicative_decrease:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12]

    cmp eax, TARGET
    jg decrease

    add eax, [ebp + 8]
    jmp end

decrease:
    xor edx, edx
    mov ebx, [ebp + 8]
    div ebx

end:
    pop ebp
    ret

