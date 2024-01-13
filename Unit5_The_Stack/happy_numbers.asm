; Author: Megan Avery

%include "asm_io.inc"

; initialized data
segment .data
initial_prompt db "Enter a happy number: ", 0
error_message db "Oops, that's not right, try again: ", 0
success_message db "You did it! 🥳", 0

base_happy_number dd 1
base_unhappy_number dd 4

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	mov eax, initial_prompt
        call print_string
        
validation_loop:
        call read_int

        push eax
        call check_happy
        add esp, 4

        cmp eax, 1
        je validation_end

        mov eax, error_message,
        call print_string

        jmp validation_loop

validation_end:
        call print_nl
        mov eax, success_message
        call print_string

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

check_happy:
        ; prologue
	push ebp
	mov ebp, esp
        sub esp, 4

        mov eax, dword [ebp + 8]

check_happy_loop:
        mov dword [esp - 4], eax

        push dword [esp - 4]
        call sum_digits_squares
        add esp, 4

        cmp eax, [base_happy_number]
        je is_happy

        cmp eax, [base_unhappy_number]
        je is_unhappy

        jmp check_happy_loop

is_happy:
        mov eax, 1
        jmp check_happy_end
is_unhappy:
        mov eax, 0
        jmp check_happy_end

check_happy_end:
        ; epilogue
	mov esp, ebp
	pop ebp
	ret

sum_digits_squares:
        ; prologue
	push ebp
	mov ebp, esp
	sub esp, 8

        mov dword [ebp - 4], 0 ; sum

        mov eax, dword [ebp + 8]
        mov dword [ebp - 8], eax ; intermediate number
        
summation:
        cmp dword [ebp - 8], 0
        je post_summation

        mov ebx, 10
        mov eax, [ebp - 8]

        xor edx, edx
        div ebx

        imul edx, edx

        add [ebp - 4], edx
        mov [ebp - 8], eax

        jmp summation

post_summation:
        mov eax, [ebp - 4]

        ; epilogue
	mov esp, ebp
	pop ebp
	ret