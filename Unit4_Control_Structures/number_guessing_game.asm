; Author: Megan Avery Spring 2024
;
; Purpose - to showcase using control structures in NASM

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
; constants
SECRET_NUMBER equ 67
NUMBER_MAX equ 100
NUMBER_MIN equ 0

; strings
guess_prompt db "Guess a number between ", 0
and_prompt   db " and ", 0
colon_prompt db ": ", 0
too_small_prompt db "Oops, too small. Try again: ", 0
too_big_prompt db "Oops, too big. Try again: ", 0
correct_output db "Nice! You guessed correctly!", 0
out_of_range_output db "Not in range! Must be between ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;
guess resd 1                    ; variable to hold user's guess

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

; CODE BEGIN

        ; starting points for boundaries of guesses
        mov bh, NUMBER_MAX      ; move the NUMBER_MAX into bh (higher 8 bits of AX)
        mov bl, NUMBER_MIN      ; move the NUMBER_MIN ito bl (lower 8 bits of AX/EAX)

        ; print out "Enter a number between {NUMBER_MIN} and {NUMBER_MAX}"
        mov eax, guess_prompt
        call print_string
        mov eax, NUMBER_MIN
        call print_int
        mov eax, and_prompt
        call print_string
        mov eax, NUMBER_MAX
        call print_int
        mov eax, colon_prompt
        call print_string
        ; end of print block
        
get_guess:                      ; label for the "top" of the elongated while loop
        call read_int           ; read an integer from the user

        mov [guess], eax        ; move the user's input into guess variable

        cmp [guess], bh         ; compare the user's input to to the higher boundary
        jg out_of_range         ; if greater than the higher boundary jump to out_of_range
        cmp [guess], bl         ; compare user's input to the lower boundary
        jl out_of_range         ; if less than the lower boundary jump to out_of_range
        
        cmp BYTE [guess], SECRET_NUMBER ; compare the user's input to the SECRET_NUMBER
        je guessed_correctly    ; if user guessed the secret number jump to guessed_correctly
        jl guess_too_small      ; if user's guess is less than the SECRET_NUMBER jump to guess_to_small

guess_too_big:                  ; label for guess_to_big, only here for show, fall through to this point
        ; if the user guessed is too big know that any number >= that number isn't a possiblity
        ; update the higher boundary of the guesses
        mov bh, [guess]         ; move the user's guess into bh (the higher boundary)
        dec bh                  ; decrement the higher boundary
       
        mov eax, too_big_prompt ; move too_big_prompt into eax
        call print_string       ; print too_big_prompt
        jmp get_guess           ; unconditionally jump to get_guess/loop back to the top

guess_too_small:                ; label for guess_too_small
        ; if the user guessed is too small know that any number <= that number isn't a possiblity
        ; update the lower boundary of the guesses
        mov bl, [guess]         ; move user's guess into bl (the lower boundary)
        inc bl                  ; increment the lower boundary
        mov eax, too_small_prompt ; move too_small_prompt into eax
        call print_string       ; print too_small_prompt
        jmp get_guess           ; unconditionally jump to get_guess/loop back to the top

out_of_range:                   ; label for out_of_range
        ; print out "Not in range! Must be between {bl} and {bh}:"
        mov eax, out_of_range_output 
        call print_string
        mov eax, 0
        mov al, bl
        call print_int
        mov eax, and_prompt
        call print_string
        mov eax, 0
        mov al, bh
        call print_int
        mov eax, colon_prompt
        call print_string
        ; end of print block

        jmp get_guess           ; unconditionally jump back to get_guess/loop back to the top

guessed_correctly:              ; label for guessed_correct
        mov eax, correct_output ; move correct_output into eax
        call print_string       ; print_correct_output
        ; no jump back to get_guess because this is outside of the while loop

; CODE END
                
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
