; Sample analysis for Exam 2 - Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter n for factorial: ", 0
factorial_message db "Factorial: ", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0                             ; setup routine
        pusha

		mov eax, prompt                         ; move prompt into EAX
        call print_string                       ; print prompt

        call read_int                           ; read an integer from the user and store it in EAX
        call print_nl                           ; print a newline

        push eax                                ; push n onto the stack
        call factorial                          ; push the return address onto the stack and jump to factorial
        add esp, 4                              ; add 4 to the stack pointer to get rid of the parameter

        mov ebx, eax                            ; move the factorial answer into EBX
        mov eax, factorial_message              ; move factorial_message into EAX
        call print_string                       ; print factorial_message
        mov eax, ebx                            ; move the factorial answer back into EAX
        call print_int                          ; print the factorial answer
        call print_nl                           ; print a newline

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

; Subprogram to calculate the nth factorial
; f(n) = n * f(n - 1)
;
; Note: nth factorial stored in EAX at the end
;
; Stack Frame:
; ------------
; EBP + 8       paremter 1: n
; EBP + 4       return address
; EBP           previous EBP
; EBP - 4       local variable 1: the intermediate answer to the factorial calculation
factorial:                              ; label for factorial subprogram
        ; prologue                      
        push ebp                        ; push the base pointer onto the stack
	mov ebp, esp                    ; set the base pointer equal to the stack pointer
        sub esp, 4                      ; subtract 4 from stack pointer, make space for 1 local variable

        mov dword [ebp - 4], 1          ; move 1 into the local variable, keeping track of the intermediate answer

        cmp dword [ebp + 8], 0          ; compare the 1st parameter to 0
        jle end_factorial               ; if first parameter <= 0 jump to the end of the factorial calculation

        mov ecx, dword [ebp + 8]        ; move the 1st parameter into ECX (loop variable)
factorial_loop:                         ; label for top of the for loop
        mov eax, ecx                    ; move ECX into EAX, get ready for this stage of the multiplication

        mov ebx, [ebp - 4]              ; move the intermediate calculation into EBX
        mul ebx                         ; multiply EAX * EBX and save into EDX:EAX
        mov [ebp - 4], eax              ; move new product into the intermedicat calculation local variable

        loop factorial_loop             ; decrement ECX then if != 0 jump to factorial_loop

end_factorial:                          ; label for the end of the factorial calculation
        mov eax, [ebp - 4]              ; move the local variable, the final answer, into EAX (the return value)

        ; epilogue
        mov esp, ebp                    ; get rid of local variable by moving stack pointer into the base pointer
        pop ebp                         ; pop the base pointer and restore its old value
        ret     

