; Sample analysis for Exam 2 - Spring 2024

%include "asm_io.inc"

; initialized data
segment .data
prompt db "Enter a number: ", 0
wrong_message db "Too bad, so sad!", 0
right_message db "You did it!", 0

; uninitialized data
segment .bss


segment .text
		global asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		mov eax, prompt
        call print_string

        call read_int

        xor ecx, ecx
        mov ebx, eax
        shl ebx, 1
        setc cl
        
        cmp ecx, 1
        je else

        mov ebx, eax
        and ebx, 1
        jz else

        mov eax, right_message
        
        jmp end
else:
        mov eax, wrong_message
end:
        call print_string
        
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


