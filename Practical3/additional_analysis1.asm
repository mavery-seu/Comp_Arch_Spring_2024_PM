; Sample code analysis for Exam 3 - Spring 2024

; Fully trace the stack for this piece of recursive code whenever the 
; user enters the word "GOAT".

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a word: ", 0
message db "Reversed: %s", 0
str_format db "%15s", 0

user_input times 16 db 0

; uninitialized data
segment .bss

segment .text
		global asm_main
        extern scanf, printf
asm_main:
        enter   0,0               ; setup routine
        pusha

		push dword prompt
		call printf
		pop ecx

		push user_input
		push dword str_format
		call scanf
		add esp, 8

        push user_input
        call strlen
        add esp, 4

        dec eax

        push eax
        push 0
        push user_input
        call rev_word
        add esp, 12

        push user_input
        push message
        call printf
        add esp, 8

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

rev_word:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12]
    cmp eax, [ebp + 16]
    jge end

    mov eax, [ebp + 8]
    add eax, [ebp + 12]

    mov ebx, [eax] ; start

    mov ecx, [ebp + 8]
    add ecx, [ebp + 16]

    mov edx, [ecx] ; end

    mov [eax], dl
    mov [ecx], bl

    mov eax, [ebp + 12]
    inc eax

    mov ebx, [ebp + 16]
    dec ebx

    push ebx
    push eax
    push dword [ebp + 8]
    call rev_word
    add esp, 12
end:
    pop ebp
    ret

; CAN BE IGNORED, WOULDN'T BE SHOWN ON EXAM
strlen:
        enter   0,0
        push    edi

        mov     edi, [ebp + 8]        
        mov     ecx, 0FFFFFFFFh 
        xor     al,al           
        cld

        repnz   scasb           

        mov     eax,0FFFFFFFEh
        sub     eax, ecx          

        pop     edi
        leave
        ret