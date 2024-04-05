; Original Author: Paul Carter
; Updated by: Megan Avery Summer 2023
; 
; Purpose: skeleton file for writing an assembly program

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a positive number: ", 0
message db "Number of digits: ", 0

; uninitialized data
segment .bss


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        ; print out prompt
		mov eax, prompt
        call print_string
        call read_int

        push eax            ; put user input onto the stack (parameter)
        call count          ; call to subprogram count
        add esp, 4          ; take parameter back off the stack

        call print_nl       ; print a newline

        mov ebx, eax        ; save off return value

        ; print off message
        mov eax, message
        call print_string

        mov eax, ebx        ; restore value of EAX
        call print_int      ; print final answer 

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

; subprogram to recursively count the number of digits in a number
;
; Pseudocode:
; count(number)
;   if number < 10:
;      return 1
;   
;   return count(number - 1) + 1
;
; Stack Frame (for each recursive call)
; -------------------------------------
; EBP + 8       param 1: number to count digits of
; EBP + 4       return address
; EBP           previous EBP
count:
    ; prologue
    push ebp
    mov ebp, esp

    ; base case
    cmp dword [ebp + 8], 10 ; compare the parameter to 10
    jb termination          ; if less than 10 jump to termination

    mov eax, [ebp + 8]      ; move parameter into EAX
    xor edx, edx            ; 0 out EDX
    mov ebx, 10             ; move 10 into ebx, will be the denominator for the division
    div ebx                 ; divide EDX:EAX by 10, quotient to EAX, remainder to EDX

    push eax                ; push EAX onto the stack, the parameter for the next layer of recursion
    call count              ; recursively call count
    add esp, 4              ; remove the parameter from the stack

    inc eax                 ; increment EAX, which is the return value from the previous recursive call

    jmp end                 ; jump to the end to skip the termination stuff

termination:                ; label for the base case 
    mov eax, 1              ; move 1 into EAX

end:                        ; label for the final end of the subprogram
    ; epilogue
    pop ebp
    ret

