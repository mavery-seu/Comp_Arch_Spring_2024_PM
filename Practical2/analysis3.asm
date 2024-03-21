; Sample analysis for Exam 2 - Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
start_prompt db "Starting max: ", 0
number_prompt db "Enter a positive number: ", 0
max_message db "Overall max: ", 0

; uninitialized data
segment .bss

segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		mov eax, start_prompt
        call print_string
        call read_int

        push eax
        call overall_max
        add esp, 4

        mov ebx, eax
        mov eax, max_message
        call print_string

        mov eax, ebx
        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

overall_max:
        push ebp
        mov ebp, esp
        sub esp, 4

        mov eax, [ebp + 8]
        mov [ebp - 4], eax

loop_start:
        mov eax, number_prompt
        call print_string
        call read_int

        cmp eax, 0
        jle loop_end

        push eax
        push dword [ebp - 4]
        call max
        add esp, 8

        mov [ebp - 4], eax
        
        jmp loop_start

loop_end:
        mov eax, [ebp - 4]

        mov esp, ebp
        pop ebp
        ret

max:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    cmp eax, [ebp + 12]
    jg max_end

update_max:
    mov eax, [ebp + 12]

max_end:
    pop ebp
    ret

