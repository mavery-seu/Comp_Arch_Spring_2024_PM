; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number between 1 and 100: ", 0
message db "Your new number is: ", 0

; uninitialized data
segment .bss
initial_input resd 1
answer resd 1

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        call get_answer_from_input

        mov eax, message
        call print_string
        
        mov eax, [answer]
        call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

get_answer_from_input:
        mov ebx, answer
        call step_6
        
        ret

step_6:
        call step_5

        mov ecx, [answer]
        sub ecx, [initial_input]

        mov [ebx], ecx

        ret

step_5:
        call step_4

        mov ecx, [answer]
        shr ecx, 3

        mov [ebx], ecx

        ret

step_4:
        call step_3

        mov ecx, [answer]
        add ecx, 16

        mov [ebx], ecx

        ret

step_3:
        call step_2

        mov ecx, [answer]
        shl ecx, 1

        mov [ebx], ecx

        ret
step_2:
        call step_1

        mov ecx, [answer]
        add ecx, 12

        mov [ebx], ecx

        ret

step_1:
        call step_0

        mov ecx, [initial_input]
        shl ecx, 2

        mov [ebx], ecx

        ret

step_0:
        mov     eax, prompt      ; print out prompt
        call    print_string

        mov     ebx, answer       ; store address of input1 into ebx
        call    get_int 

        ret

get_int:
        call    read_int
        mov     [ebx], eax         ; store input into memory
        ret   
