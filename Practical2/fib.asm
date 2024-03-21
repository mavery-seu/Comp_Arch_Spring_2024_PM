; Sample analysis for Exam 2 - Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter n for factorial: ", 0
fibonacci_message db "Factorial: ", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov eax, prompt                         ; move prompt into EAX
        call print_string                       ; print prompt

        call read_int                           ; read an integer from the user and store it in EAX
        call print_nl                           ; print a newline

		push dword eax                          ; push the n onto the stack
        call fibonacci                          ; push the return address onto the stack and jump to fibonacci
        add esp, 4                              ; add 4 to the stack pointer to get rid of the parameter

        mov ebx, eax                            ; move the fibonacci answer into EBX
        mov eax, fibonacci_message              ; move fibonacci_message into EAX
        call print_string                       ; print fibonacci_message
        mov eax, ebx                            ; move the fibonacci answer back into EAX
        call print_int                          ; print the fibonacci answer

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

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



