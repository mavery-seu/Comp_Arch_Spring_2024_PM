C; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
shift_amount dd 4
num_letters dw 27

character_prompt db "character for encoding: ", 0

encode_message db " encodes to ", 0

; uninitialized data
segment .bss
choice resb 1
character resb 1


segment .text
        global  asm_main
asm_main:
        enter   0,0                     ; setup routine
        pusha

        mov eax, character_prompt       ; move character_prompt into EAX
        call print_string               ; print character_prompt

        mov ebx, character              ; move character into EBX (where to store the return value)
        mov ecx, $ + 7                  ; move address of line 33 into ECX (the return address)
        jmp short get_character         ; jump to get_character subprogram

        mov ecx, end                    ; move end label into ECX (the return address)
        jmp encode                      ; jump to encode subprogram

end:
        popa
        mov     eax, 0                  ; return back to C
        leave                     
        ret

; get a single character from the user with a prompt
get_character:                          ; label for get_character subprogram    
        xor eax, eax                    ; clearing out EAX      
        call read_char                  ; read a character from the user
        mov [ebx], eax                  ; mov EAX into EBX, the return address

        call read_char                  ; call read_char to consume the newline character

        jmp ecx                         ; jump back to caller, based on ECX return address

; take a character and encode it using a shift cipher
encode:                                 ; label for encode subprogram
        xor eax, eax    
        mov eax, [character]            ; move character value into EAX
        add eax, [shift_amount]         ; add shift_amount value to EAX

        mov ebx, eax                    ; move EAX into EBX

        mov edx, eax                    ; move EAX into EDX
        sub edx, 'z'                    ; EDX -= lowercase z
        dec edx                         ; decrement EDX by 1

        cmp edx, 0                      ; compare EDX to 0
        jl no_wrap                      ; if EDX < 0 jump to no_wrap label

        mov ebx, 'a'                    ; mov a into EBX
        add ebx, edx                    ; add EBX += EDX

no_wrap:                                ; label for no_wrap segment of code
        xor eax, eax                    ; clear out EAX
        mov eax, [character]            ; move the character into EAX
        call print_char                 ; print the original character

        mov eax, encode_message         ; move encoded_message into EAX
        call print_string               ; print encoded_message

        mov eax, ebx                    ; move EBX into EAX
        call print_char                 ; print the shifted character

        call print_nl                   ; print a newline 

        jmp ecx                         ; jump back to the caller, dependent on ECX


