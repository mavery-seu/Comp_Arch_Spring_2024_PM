; Author: Megan Avery

%include "asm_io.inc"

; initialized data
segment .data
initial_prompt db "Enter a happy number: ", 0
error_message db "Oops, that's not right, try again: ", 0
success_message db "You did it! 🥳", 0

base_happy_number dd 1
base_unhappy_number dd 4

; uninitialized data
segment .bss

segment .text
        global  asm_main
asm_main:
        ; prologue
        enter   0,0                     ; setup routine
        pusha

	mov eax, initial_prompt         ; move initial_prompt into EAX                
        call print_string               ; print initial_prompt
        
validation_loop:                        ; label for top of validation while loop
        call read_int                   ; read an integer from the user

        push eax                        ; push user input onto the stack
        call check_happy                ; push a ret addr onto the stack and jump to check_happy label
        add esp, 4                      ; add 4 to esp to take parameter off the stack

        cmp eax, 1                      ; compare EAX (the value returned from check_happy) to 1 (true)
        je validation_end               ; if true was returned jump to validation_end label

        mov eax, error_message,         ; move error_message into EAX
        call print_string               ; print error_message

        jmp validation_loop             ; jump to the top of the loop

validation_end:                         ; label for the end of the validation loop
        call print_nl                   ; print a newilne
        mov eax, success_message        ; move success_message into EAX
        call print_string               ; print success_message

        ; epilogue
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

; Checks if a number is happy or not
;
; Note: a "boolean" is stored in EAX, 1 for true and 0 for false
;
; Stack Frame:
; ------------
; EBP + 8       param 1: number to check
; EBP + 4       return address
; EBP           previous EBP
check_happy:                            ; label for check_happy subprogram
        ; prologue
	push ebp                        ; push the base pointer to the stack
	mov ebp, esp                    ; move the stack pointer into the base pointer
        sub esp, 4                      ; subtract 4 from the stack pointer, space for 1 local variable

        mov eax, dword [ebp + 8]        ; move the number to check into EAX

check_happy_loop:                       ; label for check_happy loop
        mov dword [ebp - 4], eax        ; mov eax into the local variable, the intermediate value

        push dword [ebp - 4]            ; push the local variable onto the stack
        call sum_digits_squares         ; push the return address onto the stack and jump to sum_digits_squares
        add esp, 4                      ; reclaim stack space for parameter

        cmp eax, [base_happy_number]    ; compare EAX to 1
        je is_happy                     ; if EAX is 1 jump to is_happy

        cmp eax, [base_unhappy_number]  ; compare EAX to 4
        je is_unhappy                   ; if EAX is 4 jump to is_unhappy

        jmp check_happy_loop            ; jump back to the top of the loop

is_happy:                               ; label for is_happy condition block
        mov eax, 1                      ; move 1 (true) into EAX, which holds the return value
        jmp check_happy_end             ; jump to the end of the subprogram
is_unhappy:                             ; label for is_unhappy condition block
        mov eax, 0                      ; move 0 (false) into EAX, which holds the return value

check_happy_end:                        ; label for the end of the subprogram
        ; epilogue
	mov esp, ebp                    ; move the base pointer into the stack pointer to reclaim local variables
	pop ebp                         ; pop the base pointer off the stack and restore its old value
	ret                             ; pop the return address off of the stack and jump to that address

; Takes in a number and sums the squares of its digits
;
; Note: the answer is stored in EAX at the end of the subprogram
; 
; Stack Frame:
; ------------
; EBP + 8       the the number whose sum of its digits squared is being calculated
; EBP + 4       return address
; EBP           previous EBP
; EBP - 4       the sum of the digits squares
; EBP - 8       the intermediate value, the number as it is whittled down, a digit at a time
sum_digits_squares:                     ; label for the sum_digit_squares subprogram
        ; prologue
	push ebp                        ; push the base pointer onto the stack
	mov ebp, esp                    ; move the stack pointer into the base pointer
	sub esp, 8                      ; subtract 8 from the stack pointer, space for 2 local variables

        mov dword [ebp - 4], 0          ; initialize the sum of the squares of the digits to 0

        mov eax, dword [ebp + 8]        ; move the original number into EAX
        mov dword [ebp - 8], eax        ; move EAX into the intermediate number local variable
        
summation:                              ; the label for the summation loop
        cmp dword [ebp - 8], 0          ; compare the intermediate number to 0
        je post_summation               ; if the intermediate number is 0 jump to post_summation

        mov ebx, 10                     ; move 10 into EBX (the denominator)
        mov eax, [ebp - 8]              ; move the intermediate value into EAX (the numerator)

        xor edx, edx                    ; 0 out EDX because the numerator is actually EDX:EAX
        div ebx                         ; divide the intermediate value by 10, quotient into EAX and remainder into EDX

        imul edx, edx                   ; square the remainder (the far right digit)

        add [ebp - 4], edx              ; add the rightmost digit squared to the sum local variable
        mov [ebp - 8], eax              ; update the intermediate value to be the quotient, the previous number without its rightmost digit

        jmp summation                   ; jump to the top of the summation loop

post_summation:                         ; the end of the summation loop
        mov eax, [ebp - 4]              ; move the sum into EAX, which holds the return value

        ; epilogue
	mov esp, ebp                    ; move the base pointer into the stack pointer, reclaiming the local variables
	pop ebp                         ; pop the base pointer and restore its value into the base pointer
	ret                             ; pop the return address and jump to it