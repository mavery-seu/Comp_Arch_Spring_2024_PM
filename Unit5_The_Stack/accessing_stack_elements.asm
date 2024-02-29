; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data

; uninitialized data
segment .bss


segment .text
        global  asm_main
asm_main:
        enter   0,0                     ; setup routine
        pusha

	push dword 1                    ; push 1 onto the stack                              
        push dword 3                    ; push 3 onto the stack
        push dword 4                    ; push 4 onto the stack

        dump_stack 1, 12, -8            ; dump the stack, window around where our added values are

        mov eax, [esp]                  ; move the value at ESP into eax
        call print_int                  ; print the value at ESP
        call print_nl                   ; print a newline 

        mov eax, [esp + 4]              ; move the value at [ESP + 4] (one unit above ESP) into EAX
        call print_int                  ; print value at [ESP + 4]
        call print_nl                   ; print a newline

        mov eax, [esp + 8]              ; move the value at [ESP + 8] (two units above ESP) into EAX
        call print_int                  ; print value at [ESP + 8]
        call print_nl                   ; print a newline

        pop eax                         ; pop off the stack and store it in EAX (4)
        pop eax                         ; pop off the stack and store it in EAX (3)
        pop eax                         ; pop off the stack and store it in EAX (1)

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


