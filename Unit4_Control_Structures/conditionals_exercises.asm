; Base Author: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]
;
; Purpose - to learn about conditionals in NASM

%include "asm_io.inc"


segment .data					; initialized data
if_prompt db "Enter a character: ", 0
if_output db "and... your point is?", 0

ifelse_prompt db "Enter a number: ", 0
even db "EVEN", 0
odd db "ODD", 0

emoji_prompt db "Enter an 'eye' character: ", 0
surprised_emoji db "😳", 0
money_tongue_emoji db "🤑", 0
grin_emoji db "😁", 0

number_prompt db "Enter a number: ", 0
amazing db "Amazing!", 0

segment .bss					; uninitialized data
character resb 1

segment .text					; code
        global  asm_main
asm_main:
        enter   0,0            	; setup routine
        pusha

	; IF EXERCISE
        mov eax, if_prompt      ; move if_prompt into EAX
        call print_string       ; print if_prompt       
        call read_char          ; get a character from the user

        cmp eax, "&"            ; compare EAX to &
        jne endif               ; jump if EAX was NOT an &
        mov eax, if_output      ; move if_output inot EAX
        call print_string       ; print if_output
endif:                          ; code label for the end of the conditional
        call read_char          ; consume newline character
        call print_nl           ; print a newline

	; IF/ELSE EXERCISE
        mov eax, ifelse_prompt  ; move ifelse_prompt into EAX
        call print_string       ; print ifelse_prompt
        call read_int           ; read an integer from the user

        and eax, 1              ; get last bit by itself
        cmp eax, 0              ; compare last bit to 0
        je even_block           ; if is even (last bit a 0) jump to even_block
        
        mov eax, odd            ; move odd into EAX (if)
        jmp end_ifelse          ; jump to the end of the structure
even_block:                     ; code label for even block
        mov eax, even           ; move even into EAX (else)
end_ifelse:                     ; code label for th eend of the structure
        call print_string       ; print either even or odd depending on branching above
        call print_nl           ; print a newline character
        call print_nl           ; print a newline character

	; ELIF EXERCISE
        call read_char          ; consume the newline character
        mov eax, emoji_prompt   ; move emoji_prompt into EAX
        call print_string       ; print emoji_prompt
        call read_char          ; read a character from the user

        cmp eax, "@"            ; compare user input to @
        je surprised_block      ; jump to surprised_block if they matched

        cmp eax, "$"            ; compare user input to $
        je money_tongue_block   ; jump to money_tongue_block if they matched
        mov eax, grin_emoji     ; move the grin_emoji into EAX (else)
        jmp emoji_end           ; jump to end of the structure
surprised_block:                ; code label for the surprised_block (if)
        mov eax, surprised_emoji; move surprised_emoji into EAX 
        jmp emoji_end           ; jump to th eend of the structure
money_tongue_block:             ; code label for the money_tongue_block (elif)
        mov eax, money_tongue_emoji ; mov money_tongue_emoji to EAX
emoji_end:                      ; code_label for the end of this if/elif/else structure
        call print_string       ; print the emoji determined above
        call read_char          ; consume the newline character
        call print_nl           ; print a newline
        call print_nl           ; print a newline character

	; AND EXERCISE
        mov eax, number_prompt  ; move number_prompt into EAX
        call print_string       ; print number_prompt
        call read_int           ; read an integer from the user

        cmp eax, -99            ; compare EAX to -99
        jl outside_range        ; if EAX < -99 jump to the outside_range label

        cmp eax, 99             ; compare EAX to 99
        jg outside_range        ; if EAX > 99 jump to the outside_range label

        mov eax, amazing        ; move amazing into EAX
        call print_string       ; print amazing
outside_range:

        popa
        mov     eax, 0        	; return back to C
        leave                     
        ret
