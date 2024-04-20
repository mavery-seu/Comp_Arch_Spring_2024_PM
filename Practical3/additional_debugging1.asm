; Sample debugging for Exam 3 - Spring 2024

; This code segfaults immediately upon run. What is the programmer
; doing wrong and why is it the wrong thing to do? How would
; they fix it?

%include "asm_io.inc"

; initialized data
segment .data

; uninitialized data
segment .bss

segment .text
        extern print_every_nth_number

%define array dword [ebp + 16]
%define array_len dword [ebp + 12]
%define n dword [ebp + 8]
print_every_nth_number:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, array

    xor edx, edx
    mov eax, array_len
    mov ecx, n 

    div ecx

    mov ecx, 0
loop_point:
    cmp ecx, array_len
    jge end

    mov eax, array

    mov ebx, ecx
    shl ebx, 2

    add eax, ebx
    mov eax, [eax]
    call print_int

    mov eax, " "
    call print_char

    add ecx, n
    jmp loop_point

end:
    pop ebx
    pop ebp
    ret


