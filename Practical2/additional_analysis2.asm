; Sample analysis for Exam 2 - Spring 2024

; Trace the stack for this piece of code, the number of numbers must be at least 2.

%include "asm_io.inc"

; initialized data
segment .data
prompt db "How many numbers: ", 0
number_prompt db "Enter a number: ", 0
sum_message db "And the sum is: ", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, prompt
        call print_string
        call read_int

        mov ebx, eax

        mov ecx, eax
get_nums:
        mov eax, number_prompt
        call print_string
        call read_int

        push eax

        loop get_nums

        push ebx
        call get_sum
        pop ebx

        shl ebx, 2
        add esp, ebx

        mov ebx, eax
        call print_nl
        mov eax, sum_message
        call print_string
        mov eax, ebx
        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

get_sum:
    push ebp
    mov ebp, esp
    sub esp, 8
    
    mov dword [ebp - 4], 12
    mov dword [ebp - 8], 0

    mov ecx, [ebp + 8]
    
for:
    mov ebx, ebp
    add ebx, [ebp - 4]

    mov eax, [ebp - 8]
    add eax, [ebx]

    mov [ebp - 8], eax

    add dword [ebp - 4], 4
    loop for

    

    mov esp, ebp
    pop ebp
    ret

