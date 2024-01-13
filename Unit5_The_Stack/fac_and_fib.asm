; Author: Megan Avery Spring 2024

%include "asm_io.inc"

%define NL 10

; initialized data
segment .data


; uninitialized data
segment .bss

segment .text
        global factorial, fibonacci

factorial:
        push ebp
	mov ebp, esp
        sub esp, 4

        mov dword [ebp - 4], 1

        cmp dword [ebp + 8], 0
        jle end_factorial

        mov ecx, dword [ebp + 8]
factorial_loop:
        mov eax, dword [ebp + 8]
        sub eax, ecx
        add eax, 1

        mov ebx, [ebp - 4]
        mul ebx
        mov [ebp - 4], eax

        loop factorial_loop

end_factorial:
        mov eax, [ebp - 4]

        mov esp, ebp
        pop ebp
        ret

fibonacci:
        push ebp
	mov ebp, esp
        sub esp, 8

        cmp dword [ebp + 8], 0
        jle zero_case

        cmp dword [ebp + 8], 1
        je one_case

        mov dword [ebp - 4], 0
        mov dword [ebp - 8], 1

        mov ecx, [ebp + 8]
        sub ecx, 2
fibonacci_loop:
        mov eax, dword [ebp - 4]
        add eax, dword [ebp - 8]

        mov ebx, [ebp - 8]
        mov dword [ebp - 4], ebx
        mov dword [ebp - 8], eax

        loop fibonacci_loop

        mov eax, [ebp - 8]
        jmp end_fibonacci

zero_case:
        mov eax, 0
        jmp end_fibonacci
one_case:
        mov eax, 1

end_fibonacci:
        mov esp, ebp
        pop ebp
        ret



