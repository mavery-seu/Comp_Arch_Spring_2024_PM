; Original Author: Paul Carter
; Updated by: Megan Avery Summer 2023
; 
; Purpose: skeleton file for writing an assembly program

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number for the calculations: ", 0
factorial_message db "Factorial: ", 0
fibonacci_message db "Fibonacci: ", 0

; uninitialized data
segment .bss


segment .text
        global  asm_main
        extern  factorial, fibonacci
asm_main:
        enter   0,0               ; setup routine
        pusha
        sub esp, 4

        mov eax, prompt
        call print_string

        call read_int
        call print_nl

        mov dword [ebp - 4], eax

        push dword [ebp - 4]
        call factorial
        add esp, 4

        mov ebx, eax
        mov eax, factorial_message
        call print_string
        mov eax, ebx
        call print_int
        call print_nl

        push dword [ebp - 4]
        call fibonacci
        add esp, 4

        mov ebx, eax
        mov eax, fibonacci_message
        call print_string
        mov eax, ebx
        call print_int        

        add esp, 4
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


