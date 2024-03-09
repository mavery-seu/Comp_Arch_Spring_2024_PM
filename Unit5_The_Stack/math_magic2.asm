; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter number between 1 and 100: ", 0
error_message db "Not in range, try again: ", 0
answer_message db "Your new number is: ", 0

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        ; prologue
        enter  0,0              ; setup routine
        pusha

        call get_number         ; push the return address onto the stack and jump to get_number

        push eax                ; push EAX, the user's input, onto the stack
        call do_magic           ; push the return address onto the stack and jump to do_magic
        pop ebx                 ; pop off the stack and store it in EBX (the original user's input)

        mov ebx, eax            ; move EAX into EBX, the value returned by do_magic

        mov eax, answer_message ; move answer_message into EAX
        call print_string       ; print answer_message

        mov eax, ebx            ; move EBX into EAX
        call print_int          ; print the final answer

        ; epilogue
        popa
        mov     eax, 0          ; return back to C
        leave                     
        ret

; Get a number from the user
;
; Note: EAX will be the user's input
;
; Stack Frame:
; ------------
; EBP + 4       return address
; EBP           previous EBP
get_number:
        ; prologue
        push    ebp             ; push the base pointer onto the stack
        mov     ebp, esp        ; move the stack pointer into the base pointer
        
        mov eax, prompt         ; move prompt into EAX
        call print_string       ; print prompt
        
get_int:                        ; label for get_int loop
        call read_int           ; read an integer from the user into EAX

        cmp eax, 1              ; compare the user's input to 1
        jl invalid_number       ; if < 1 jump to invalid_number

        cmp eax, 100            ; compare the user's input to 100
        jg invalid_number       ; if > 100 jump to invalid_number

        jmp valid_number        ; jump to valid_number

invalid_number:                 ; label for invalid number
        mov eax, error_message  ; move error_message to EAX
        call print_string       ; print error_message

        jmp get_int             ; jump back to the top of the get int loop

valid_number:                   ; label for valid number
        pop     ebp             ; pop to restore the base pointer
        ret                     ; pop the return address off the stack and jump to it

; Perform magic on the number, will always end in the number being 13
;
; Note: the answer after magic is performed will be saved in EAX
;
; Stack Frame:
; ------------
; EBP + 8       the original number
; EBP + 4       return address
; EBP           previous EBP
do_magic:                       ; label for do_magic subprogram 
        ; prologue
        push    ebp             ; push the base pointer onto the stack
        mov     ebp, esp        ; move the stack pointer into the base pointer

        mov eax, [ebp + 8]      ; move the original number into EAX
        shl eax, 1              ; multiply the original number by 2

        push 15                 ; push 15 onto the stack
        push eax                ; push the original number * 2 onto the stack
        call add                ; push the return address onto the stack and jump to add
        add esp, 8              ; add 8 to the stack pointer to get rid of the 2 parameters

        push 3                  ; push 3 onto the stack
        push eax                ; push (og number * 2) + 15 onto the stack
        call multiply           ; push the return address onto the stack and jump to multiply
        add esp, 8              ; add 8 to the stack pointer to get rid of the 2 parameters

        push 33                 ; push 33 onto the stack
        push eax                ; push ((og number * 2) + 15) * 3 onto the stack
        call add                ; push the return address onto the stack and jump to add
        add esp, 8              ; add 8 to the stack pointer to get rid of the 2 parameters

        push 6                  ; push 6 onto the stack
        push eax                ; push (((og number * 2) + 15) * 3) + 33 onto the stack
        call divide             ; push the return address onto the stack and jump to divide
        add esp, 8              ; add 8 to the stack pointer to get rid of the 2 parameters

        push dword [ebp + 8]    ; push the og number onto the stack
        push eax                ; push ((((og number * 2) + 15) * 3) + 33) / 6) onto the stack
        call subtract           ; push the return address onto the stack and jump to subtract
        add esp, 8              ; add 8 to the stack pointer to get rid of the 2 parameters

        ; epilogue
        pop     ebp             ; pop and restore the base pointer to its previous value
        ret                     ; pop off the return address and jump to it

; Add 2 numbers together
;
; Stack Frame:
; ------------
; EBP + 12      right operand
; EBP + 8       left operand
; EBP + 4       return address
; EBP           previous EBP
add:    
        ; prologue
        push    ebp             ; push the base pointer onto the stack
        mov     ebp, esp        ; move the stack pointer onto the base pointer

        mov eax, [ebp + 8]      ; move the left operand into EAX
        add eax, [ebp + 12]     ; add the right operand to the left operand

        ; epilogue
        pop     ebp             ; pop and restore the base pointer to its previous value
        ret                     ; pop off the return address and jump to it     

; Multiply 2 numbers together
;
; Stack Frame:
; ------------
; EBP + 12      right operand
; EBP + 8       left operand
; EBP + 4       return address
; EBP           previous EBP
multiply:
        ; prologue
        push    ebp             ; push the base pointer onto the stack
        mov     ebp, esp        ; move the stack pointer onto the base pointer

        mov eax, [ebp + 8]      ; move the left operand into EAX
        imul eax, [ebp + 12]    ; multiply the left operand by the right operand

        ; epilogue
        pop     ebp             ; pop and restore the base pointer to its previous value
        ret                     ; pop off the return address and jump to it     

; Divide one number by another
;
; Stack Frame:
; ------------
; EBP + 12      denominator
; EBP + 8       numerator
; EBP + 4       return address
; EBP           previous EBP
divide:
        ; prologue
        push    ebp             ; push the base pointer onto the stack
        mov     ebp, esp        ; move the stack pointer onto the base pointer

        mov eax, [ebp + 8]      ; move the numerator into EAX
        mov ebx, [ebp + 12]     ; move the denominator into EBX

        div bl                  ; divide EAX by BL and save the quotient in AL and the remainder in AH

        and eax, 255            ; zero out everything in EAX except AL (the quotient)

        ; epilogue
        pop     ebp             ; pop and restore the base pointer to its previous value
        ret                     ; pop off the return address and jump to it  

; Subtract one number from another
;
; Stack Frame:
; ------------
; EBP + 12      right operand
; EBP + 8       left operand
; EBP + 4       return address
; EBP           previous EBP
subtract:
        ; prologue
        push    ebp             ; push the base pointer onto the stack
        mov     ebp, esp        ; move the stack pointer onto the base pointer

        mov eax, [ebp + 8]      ; move the left operand into EAX
        sub eax, [ebp + 12]     ; subtract the right operand from the left operand

        ; epilogue
        pop     ebp             ; pop and restore the base pointer to its previous value
        ret                     ; pop off the return address and jump to it  


