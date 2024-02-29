; Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
length_prompt db "How long is the string? ", 0
string_prompt db "Enter your string: ", 0

; uninitialized data
segment .bss
string_length resd 1

segment .text
        global  asm_main
asm_main:
        enter   0,0                     ; setup routine
        pusha

        mov eax, length_prompt          ; move length_prompt into EAX       
        call print_string               ; print length_prompt

        call read_int                   ; read user input integer into EAX

        mov [string_length], eax        ; move EAX into the value at string_length
        mov ecx, [string_length]        ; move value at string_length into ECX, the loop counter

        call read_char                  ; read a character into EAX, consuming the newline character
        mov eax, string_prompt          ; move string_prompt into EAX
        call print_string               ; print string_prompt

; read in 1 character at a time and push each character onto the stack
input_loop:                             ; label for top of the input_loop
        call read_char                  ; read a single character
        push eax                        ; push EAX onto the stack 
        
        loop input_loop                 ; loop back to input_loop, dec ECX and jump if ECX != 0

        ; push dword "!" ; causes segfault because of the extra push

        call print_nl                   ; print a newline 
        mov ecx, [string_length]        ; move the value at string_length into ECX, the loop counter
; pop every character back off the stack and print it to the screen
remove_loop:                            ; label for the top of the remove_loop
        pop eax                         ; pop off the stack and save it into EAX
        call print_char                 ; print the character in AL

        loop remove_loop                ; loop back to remove_loop, dec ECX and jump if ECX != 0

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


