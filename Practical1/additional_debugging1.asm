; Author: Megan Avery - Spring 2024
;
; The programmer is attempting to get the hex code for 
; the inverted color the corresponds to the RGB values entered
; by the user, This inverted hex code is to live in the EAX register
; What did the programmer forget to do after calculating the 
; inverted value for each individual color?

%include "asm_io.inc"

; initialized data
segment .data
prompt_red db "Enter a colors red value (0 - 255): ", 0
prompt_green db "Enter a color's green value (0 - 255): ", 0
prompt_blue db "Enter a color's blue value (0 - 255): ", 0

; uninitialized data
segment .bss
red resb 1
green resb 1
blue resb 1

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	mov eax, prompt_red
        call print_string

        call read_int
        mov byte [red], al

        mov eax, prompt_green   
        call print_string
        call read_int
        mov byte [green], al

        mov eax, prompt_blue
        call print_string
        call read_int
        mov byte [blue], al

        xor ebx, ebx
        mov bl, [red]
        xor bl, 0FFH

        xor eax, eax
        mov al, bl

        mov bl, [green]
        xor bl, 0FFH
        or eax, ebx
        
        mov bl, [blue]
        xor bl, 0FFH
        or eax, ebx

        call print_nl
        dump_regs 1
        
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


