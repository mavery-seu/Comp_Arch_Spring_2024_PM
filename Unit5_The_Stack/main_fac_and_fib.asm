; Author: Megan Avery Spring 2024

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
        extern  factorial, fibonacci            ; mark these subprograms as being in other files
asm_main:
        ; prologue
        enter   0,0                             ; setup routine
        pusha
        sub esp, 4                              ; subtract 4 from the stack pointer, room for 1 local variable

        mov eax, prompt                         ; move prompt into EAX
        call print_string                       ; print prompt

        call read_int                           ; read an integer from the user and store it in EAX
        call print_nl                           ; print a newline

        mov dword [ebp - 36], eax                ; move EAX into the local variable, n

        push dword [ebp - 36]                    ; push n onto the stack
        call factorial                          ; push the return address onto the stack and jump to factorial
        add esp, 4                              ; add 4 to the stack pointer to get rid of the parameter

        mov ebx, eax                            ; move the factorial answer into EBX
        mov eax, factorial_message              ; move factorial_message into EAX
        call print_string                       ; print factorial_message
        mov eax, ebx                            ; move the factorial answer back into EAX
        call print_int                          ; print the factorial answer
        call print_nl                           ; print a newline

        push dword [ebp - 36]                    ; push the original n onto the stack
        call fibonacci                          ; push the return address onto the stack and jump to fibonacci
        add esp, 4                              ; add 4 to the stack pointer to get rid of the parameter

        mov ebx, eax                            ; move the fibonacci answer into EBX
        mov eax, fibonacci_message              ; move fibonacci_message into EAX
        call print_string                       ; print fibonacci_message
        mov eax, ebx                            ; move the fibonacci answer back into EAX
        call print_int                          ; print the fibonacci answer

        ; epilogue
        add esp, 4                              ; add 4 to the stack pointer to get rid of the local variable
        popa    
        mov     eax, 0            ; return back to C
        leave                     
        ret


