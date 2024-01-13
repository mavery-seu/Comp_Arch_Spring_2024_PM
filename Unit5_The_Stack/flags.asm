; Author: Megan Avery Spring 2024

%include "asm_io.inc"

%define ZF_MASK 00000040h
%define OF_MASK 00000800h
%define SF_MASK 00000080h
%define CF_MASK 00000001h

; initialized data
segment .data
prompt db "Enter a number: ", 0
separator db "-------------", 0
on db "✅", 0
off db "❌", 0
message db "The difference is: ", 0

zero db     "    ZERO: ", 0
overflow db "OVERFLOW: ", 0
sign db     "    SIGN: ", 0
carry db    "   CARRY: ", 0

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
        pushf                     ; push flags onto stack

        mov eax, prompt
        call print_string

        call read_int
        mov ebx, eax

        mov eax, prompt
        call print_string

        call read_int
        
        call print_nl

        sub ebx, eax

        call dump_flags

        call print_nl
        mov eax, message
        call print_string

        mov eax, ebx
        call print_int

        popf                      ; pop flags off stack
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

dump_flags:
        push    ebp
        mov     ebp, esp
        pusha
        pushf

        mov eax, separator
        call print_string
        call print_nl

        mov eax, [esp]

        push ZF_MASK
        push zero
        push eax
        call dump_single_flag
        add esp, 12

        mov eax, separator
        call print_string
        call print_nl

        mov eax, [esp]

        push OF_MASK
        push overflow
        push eax
        call dump_single_flag
        add esp, 12

        mov eax, separator
        call print_string
        call print_nl

        mov eax, [esp]

        push SF_MASK
        push sign
        push eax
        call dump_single_flag
        add esp, 12

        mov eax, separator
        call print_string
        call print_nl

        mov eax, [esp]

        push CF_MASK
        push carry
        push eax
        call dump_single_flag
        add esp, 12

        mov eax, separator
        call print_string
        call print_nl

        popf 
        popa
        pop     ebp
        ret

dump_single_flag:
        push    ebp
        mov     ebp, esp

        mov eax, [ebp + 12]
        call print_string

        mov eax, [ebp + 8]
        mov ebx, [ebp + 16]

        test eax, ebx

        jz flag_off
        mov eax, on
        call print_string
        jmp after_flag

flag_off:
        mov eax, off
        call print_string

after_flag:
        call print_nl

        pop     ebp
        ret

