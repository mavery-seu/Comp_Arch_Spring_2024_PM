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
        ; prologue
        enter   0,0                     ; setup routine
        pusha

        call get_answer_from_input      ; push the return address and jump to get_answer_from_input

        mov eax, message                ; move message into EAX
        call print_string               ; print message
        
        mov eax, [answer]               ; move the final answer into EAX
        call print_int                  ; print the final answer

        ; epilogue
        popa
        mov     eax, 0                  ; return back to C
        leave                     
        ret

; Stack Frame:
; ------------
; ESP       return address
get_answer_from_input:                  ; label for get_answer_from_input subprogram
        mov ebx, answer                 ; move answer (address) into EBX, where to store return value
        call step_6                     ; push ret address onto stack and jump to step_6
        
        ret                             ; pop the return address off the stack and jump to it

; Stack Frame:
; ------------
; ESP       return address
step_6:                                 ; label for step_6 subprogram
        call step_5                     ; push ret address onto stack and jump to step_5

        mov ecx, [answer]               ; move answer from step_5 into ECX
        sub ecx, [initial_input]        ; subtract the initial_input value from answer from step_5

        mov [ebx], ecx                  ; move ECX into value at EBX, the return value

        ret                             ; pop the return address off the stack and jump to it

; Stack Frame:
; ------------
; ESP       return address
step_5:                                 ; label for step_5 subprogram
        call step_4                     ; push ret address onto stack and jump to step_4

        mov ecx, [answer]               ; move answer from step_4 into ECX
        shr ecx, 3                      ; divide answer from step_4 by 9

        mov [ebx], ecx                  ; move ECX into value at EBX, the return value

        ret                             ; pop the return address off the stack and jump to it

; Stack Frame:
; ------------
; ESP       return address
step_4:                                 ; label for step_4 subprogram
        call step_3                     ; push ret address onto stack and jump to step_3             

        mov ecx, [answer]               ; move answer from step_3 into ECX
        add ecx, 16                     ; add 16 to the answer from step_3

        mov [ebx], ecx                  ; mov ECX into value at EBX, the return value

        ret                             ; pop the return address off the stack and jump to it

; Stack Frame:
; ------------
; ESP       return address
step_3:                                 ; label for step_3 subprogram
        call step_2                     ; push ret address onto stack and jump to step_2

        mov ecx, [answer]               ; move answer from step_2 into ECX
        shl ecx, 1                      ; multiply answer from step_2 by 2

        mov [ebx], ecx                  ; mov ECX into value at EBX, the return value

        ret                             ; pop the return address off the stack and jump to it

; Stack Frame:
; ------------
; ESP       return address
step_2:                                 ; label for step_2 subprogram
        call step_1                     ; push ret address onto stack and jump to step_1

        mov ecx, [answer]               ; move answer from step_1 into ECX
        add ecx, 12                     ; add 12 to the answer from step_1

        mov [ebx], ecx                  ; mov ECX into value at EBX, the return value

        ret                             ; pop the return address off the stack and jump to it

; Stack Frame:
; ------------
; ESP       return address
step_1:                                 ; label for step_1 subprogram
        call step_0                     ; push ret address onto stack and jump to step_0

        mov ecx, [initial_input]        ; move answer from step_0 (initial input) into ECX
        shl ecx, 2                      ; multiply the initial input by 4

        mov [ebx], ecx                  ; mov ECX into value at EBX, the return value

        ret                             ; pop the return address off the stack and jump to it

; Stack Frame:
; ------------
; ESP       return address
step_0:
        mov     eax, prompt             ; move prompt into EAX
        call    print_string            ; print prompt

        push ebx                        ; push the original return value address
        mov  ebx, initial_input         ; store address of input1 into ebx
        call get_int                    ; push the return address and jump to get_int
        pop ebx                         ; pop and store the value into EBX (the original EBX value)

        ret                             ; pop the return address off the stack and jump to it

; Stack Frame:
; ------------
; ESP       return address
get_int:                                ; label for get_int subprogram
        call    read_int                ; read an integer from the user
        mov     [ebx], eax              ; store input into memory, the return value
        ret                             ; pop the return address off the stack and jump to it
