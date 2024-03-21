; Sample analysis for Exam 2 - Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a lowercase letter: ", 0
error_message db "Oops, incorrect input", 0
in_order_message db "Yay! Entered in order", 0
out_of_order_message db "Sad, not in order", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		mov eax, prompt
        call print_string

        call read_char
        mov ebx, eax

        call read_char

        mov eax, prompt
        call print_string
        call read_char

        push eax
        push ebx
        call check_in_order
        add esp, 8

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

check_in_order:
    push ebp
    mov ebp, esp

    push dword [ebp + 8]
    call check_letter
    pop ecx

    cmp eax, 0
    je not_letter

    push dword [ebp + 12]
    call check_letter
    pop ecx

    cmp eax, 0
    je not_letter

    mov eax, [ebp + 8]
    cmp eax, [ebp + 12]
    jg out_of_order

    mov eax, in_order_message
    
    jmp end
not_letter:
    mov eax, error_message
    jmp end
out_of_order:
    mov eax, out_of_order_message
end:
    call print_string

    pop ebp
    ret

check_letter:
    push ebp
    mov ebp, esp

    cmp dword [ebp + 8], 'a'
    jl fail

    cmp dword [ebp + 8], 'z'
    jg fail

    mov eax, 1
    jmp check_end
fail:
    mov eax, 0

check_end:
    pop ebp
    ret