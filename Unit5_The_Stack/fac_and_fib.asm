; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data


; uninitialized data
segment .bss

segment .text
        global factorial, fibonacci     ; make factorial and fibonacci subprograms available outside of this assembly file

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
        ret                             ; pop off the return address adn jump to it

; Subprogram to calcuate the nth fibonacci number
; f(n) = f(n - 1) + f(n - 2)
; 
; Note: nth fibonacci number stored in EAX at the end
;
; Stack Frame:
; ------------
; EBP + 8       parameter 1: n
; EBP + 4       return address 
; EBP           previous EBP
; EBP - 4       local variable 1: f(n - 2)
; EBP - 8       local variable 2: f(n - 1)
fibonacci:                               ; label for the fibonacci subprogram                   
        ; prologue
        push ebp                         ; push the base pointer onto the stack  
	mov ebp, esp                     ; set the base pointer equal to the stack pointer                                                                                
        sub esp, 8                       ; subtract 4 from stack pointer, make space for 1 local variable   

        cmp dword [ebp + 8], 0           ; compare n to 0
        jle zero_case                    ; if n <= 0 jump to zero_case

        cmp dword [ebp + 8], 2           ; compare n to 2      
        jle one_case                     ; if n <= 2 jump to one_case

        mov dword [ebp - 4], 1           ; move 1 into f(n - 2)
        mov dword [ebp - 8], 1           ; move 1 into f(n - 1)

        mov ecx, [ebp + 8]               ; move original n into ECX (loop counter)
        sub ecx, 2                       ; subtract 2 from ECX, loop runs 2 times less than ECX
fibonacci_loop:                          ; label for the top of the for loop
        mov eax, dword [ebp - 4]         ; move f(n - 2) into EAX
        add eax, dword [ebp - 8]         ; add f(n - 1) to eax (making eax f(n))

        mov ebx, [ebp - 8]               ; move the f(n - 1) into EBX
        mov dword [ebp - 4], ebx         ; move EBX into f(n - 2) (making f(n - 2) the previous f(n -1) value)
        mov dword [ebp - 8], eax         ; move EAX into f(n - 1) (making f(n - 1) the previous  f(n) value)

        loop fibonacci_loop              ; decrement ECX then if != 0 jump to the top of the loop

        mov eax, [ebp - 8]               ; move the final f(n) into EAX, the register that holds the return value
        jmp end_fibonacci                ; jump to the end_fibonacci label

zero_case:                               ; the label for the zero case, when n is originally <= 0
        mov eax, 0                       ; move 0 into EAX, the register that holds the return value
        jmp end_fibonacci                ; jump to the end_fibonacci label
one_case:                                ; the label for the one_case, when n is originally 1 or 2
        mov eax, 1                       ; move 1 into EAX, the register that holds the return value

end_fibonacci:                           ; label for the end of the subprogram
        ; epilogue
        mov esp, ebp                     ; move the base pointer into the stack pointer, to get rid of the local variables  
        pop ebp                          ; pop the base pointer off the stack and restore it to the previous value
        ret                              ; pop off the return address from the stack and jump to it



