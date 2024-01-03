; Author: Megan Avery Spring 2024
;
; Purpose - to showcase using control structures in NASM

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
SECRET_NUMBER equ 67
NUMBER_MAX equ 100
NUMBER_MIN equ 0

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
guess resd 1

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

; CODE START
        mov bh, NUMBER_MAX
        mov bl, NUMBER_MIN

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
        
get_guess:
        call read_int

        mov [guess], eax

        cmp [guess], bh
        jg out_of_range
        cmp [guess], bl
        jl out_of_range
        
        cmp BYTE [guess], SECRET_NUMBER
        je guessed_correctly
        jl guess_too_small

guess_too_big:
        mov bh, [guess]
        dec bh
        mov eax, too_big_prompt
        call print_string
        jmp get_guess

guess_too_small:
        mov bl, [guess]
        inc bl
        mov eax, too_small_prompt
        call print_string
        jmp get_guess

out_of_range:
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

        jmp get_guess

guessed_correctly:
        mov eax, correct_output
        call print_string

; CODE END
                
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
