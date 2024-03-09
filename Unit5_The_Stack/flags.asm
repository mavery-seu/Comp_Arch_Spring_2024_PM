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
        ; prologue
        enter   0,0                     ; setup routine
        pusha
        pushf                           ; push flags onto stack

        mov eax, prompt                 ; move prompt into EAX
        call print_string               ; print prompt

        call read_int                   ; read an integer from the user
        mov ebx, eax                    ; move entered integer into EBX

        mov eax, prompt                 ; move prompt into EAX
        call print_string               ; print prompt

        call read_int                   ; read an integer from the user
        
        call print_nl                   ; print a newline

        sub ebx, eax                    ; subtract the 2nd number entered from the 1st number entered, also updates the FLAGS register

        call dump_flags                 ; push the return address onto the stack and jump to dump_flags

        call print_nl                   ; print a newline character
        mov eax, message                ; move message into EAX
        call print_string               ; print message

        mov eax, ebx                    ; move the (first number - second number) answer into EAX
        call print_int                  ; print the answer

        ; epilogue
        popf                      ; pop flags off stack
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

; Dumps all the indicated flags to the screen
;
; Stack Frame:
; ------------
; EBP + 4       return address
; EBP           previous EBP
dump_flags:                             ; label for dump flags subprogram
        ; prologue      
        push    ebp                     ; push the base pointer onto the stack
        mov     ebp, esp                ; update the base pointer to be equal to the stack pointer
        pusha                           ; push a buch of registers to the stack
        pushf                           ; push the FLAGS register value to the stack

        mov eax, separator              ; move separator into EAX
        call print_string               ; print separator
        call print_nl                   ; print a newline

        mov eax, [ebp - 36]             ; move the FLAGS value to EAX       

        push ZF_MASK                    ; push the ZF_MASK macro to the stack
        push zero                       ; push the zero string address to the stack
        push eax                        ; push EAX (the FLAGS value) onto the stack
        call dump_single_flag           ; push the ret address onto the stack and jump to dump_single_flag
        add esp, 12                     ; add 12 to ESP to take the 3 parameters off of the stack

        mov eax, separator              ; move separator into EAX
        call print_string               ; print separator
        call print_nl                   ; print a newline

        mov eax, [ebp - 36]             ; move the FLAGS value to EAX

        push OF_MASK                    ; push the OF_MASK macro to the stack
        push overflow                   ; push the overflow string address to the stack
        push eax                        ; push EAX (the FLAGS value) onto the stack
        call dump_single_flag           ; push the ret address onto the stack and jump to dump_single_flag
        add esp, 12                     ; add 12 to ESP to take the 3 parameters off of the stack

        mov eax, separator              ; move separator into EAX
        call print_string               ; print separator
        call print_nl                   ; print newline

        mov eax, [ebp - 36]             ; move the FLAGS value to EAX

        push SF_MASK                    ; push the SF_MASK macro to the stack
        push sign                       ; push the overflow string address to the stack
        push eax                        ; push EAX (the FLAGS value) onto the stack
        call dump_single_flag           ; push the ret address onto the stack and jump to dump_single_flag
        add esp, 12                     ; add 12 to ESP to take the 3 parameters off of the stack

        mov eax, separator              ; move separator into EAX
        call print_string               ; print separator
        call print_nl                   ; print newline

        mov eax, [ebp - 36]             ; move the FLAGS value to EAX

        push CF_MASK                    ; push the CF_MASK macro to the stack
        push carry                      ; push the carry string address to the stack
        push eax                        ; push EAX (the FLAGS value) onto the stack
        call dump_single_flag           ; push the ret address onto the stack and jump to dump_single_flag
        add esp, 12                     ; add 12 to ESP to take the 3 parameters off of the stack

        mov eax, separator              ; move separator into EAX
        call print_string               ; print separator
        call print_nl                   ; print newline

        ; epilogue
        popf                            ; pop off the FLAGS register value and restore it
        popa                            ; pop off all the registers that were pushed before and restore them
        pop     ebp                     ; pop the base pointer off the stack and restore it to its previous value
        ret                             ; pop the return address off of the stack and jump to it

; Subprogram to dump a single flag to the screen
;
; Stack Frame:
; ------------
; EBP + 16      parameter 3: mask for  flag
; EBP + 12      parameter 2: string for flag output
; EBP + 8       parameter 1: FLAGS value
; EBP + 4       return address
; EBP           previous EBP
dump_single_flag:                       ; label for the dump single flag subprogram
        ; prologue
        push    ebp                     ; push the base pointer onto the stack
        mov     ebp, esp                ; set the base pointer to the stack pointer

        mov eax, [ebp + 12]             ; move param 2 (string for output) into EAX
        call print_string               ; print the string for output

        mov eax, [ebp + 8]              ; move param 1 (the FLAGS value) into EAX
        mov ebx, [ebp + 16]             ; move param 3 (mask for flag) into EBX

        test eax, ebx                   ; test eax and ebx (perform AND to toggle FLAGS but don't store answer

        jz flag_off                     ; if result of test is 0, jump to flag_off label
        mov eax, on                     ; move on into EAX
        jmp after_flag                  ; jump to after_flag label

flag_off:                               ; flags_off label
        mov eax, off                    ; move off into EAX

after_flag:
        call print_string               ; print on/off depending on previous calculations
        call print_nl                   ; print a newline

        ; epilogue
        pop     ebp                     ; pop the base pointer off the stack and restore it's previous value
        ret                             ; pop the ret addr off the stack and jump to it

