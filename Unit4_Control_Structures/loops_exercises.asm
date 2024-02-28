; Base Author: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]
;
; Purpose - to learn about loops in NASM

%include "asm_io.inc"
segment .data
rocket db "🚀!", 0

perfect_prompt db "Enter a power of 2: ", 0
perfect db "PERFECT", 0
another_perfect_prompt db "Again! ", 0

fear_the_goat db "Fear the 🐐!", 0
reaction db "Reaction? ", 0

segment .bss						; uninitialized data


segment .text						; code
        global  asm_main
asm_main:
        enter   0,0               	; setup routine
        pusha

	; FOR LOOP EXERCISE
        mov ecx, 5              ; indicates loop should run 5 times
for:                            ; label for "top" of for loop
        mov eax, ecx            ; move ecx into eax
        call print_int          ; print eax
        call print_nl           ; print a newline so each int on its own line

        ; if update ecx inside loop like this will get an infinite loop
        ; mov ecx, 5    

        loop for                ; decrement ecx, if ecx != 0 jump back to for label     

        mov eax, rocket         ; move rocket into eax
        call print_string       ; print rocket
        call print_nl           ; print a newline
        call print_nl           ; print a newline
	
        ; WHILE EXERCISE

        ; setup
        mov eax, perfect_prompt ; move perfect_prompt into eax
        call print_string       ; print perfect_prompt
        call read_int           ; read and integer from the user
while:                          ; label for the "top" of the while loop
        mov ebx, eax            ; move eax into ebx
        dec ebx                 ; decrement ebx, now ebx = eax - 1
        and eax, ebx            ; and eax with ebx, store result in eax
        cmp eax, 0              ; compare eax to 0
        
        ; if missing causes aninfinite loop
        jnz endwhile            ; if zero flag is NOT set skip over body of loop          

        mov eax, perfect        ; move perfect into eax
        call print_string       ; print perfect
        call print_nl           ; print a newline
        
        ; update - if missing from while loop get an infinite loop
        mov eax, another_perfect_prompt ; move another_perfect_prompt into eax
        call print_string       ; print another_perfect_prompt
        call read_int           ; read an integer from the user

        jmp while               ; unconditionally jump to the while label
endwhile:                       ; label for the end of the while loop
        call print_nl           ; print a newline

	;DO WHILE EXERCISE
do:                             ; label for the "top" of the do while loop
        call read_char          ; read a character, to consume newline characters
        mov eax, fear_the_goat  ; move fear_the_goat into eax
        call print_string       ; print fear_the_goat
        call print_nl           ; print a newline

        mov eax, reaction       ; move reaction into eax
        call print_string       ; print reaction
        call read_char          ; read a character from the user

        cmp eax, "!"            ; compare the character to !
        jne do                  ; conditonally jump if eax and ! are NOT equal


        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
