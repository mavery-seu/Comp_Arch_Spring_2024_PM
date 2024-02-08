; Base Authro: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]

; Purpose: showcase examples of bit twiddling

%include "asm_io.inc"

; initialized data
segment .data

; uninitialized data
segment .bss


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        ; zero out a register
        ; xor with itself
        mov eax, 56     ; eax = 56
        xor eax, eax    ; eax ^ eax -> becomes 0
        call print_int  ; print eax
        call print_nl   ; print a newline  

        ; calculate the 1s complement
        ; not the number

        ; turn on specific bit
        mov ebx, 1      ; ebx = 1 -> 0001
        shl ebx, 2      ; ebx << 2 = 4 (2^2) -> 0100

        mov eax, 11     ; eax = 11 -> 1011
        or eax, ebx     ; eax | ebx = 15 -> 1111

        call print_int  ; print eax
        call print_nl   ; print a newline

        ; turn off a specific bit
        mov ebx, 1      ; ebx = 1 -> 0001
        shl ebx, 3      ; ebx << 3 = 8 (2^3) -> 1000
        not ebx         ; ~ebx = 7 -> 0111

        mov eax, 15     ; eax = 15 -> 1111
        and eax, ebx    ; eax & ebx = 7 -> 0111

        call print_int  ; print eax
        call print_nl   ; print a newline

        ; invert a specific bit
        mov ebx, 1      ; ebx = 1 -> 0001
        shl ebx, 3      ; ebx << 3 -> 1000

        mov eax, 1      ; eax = 1 -> 0001
        xor eax, ebx    ; eax ^ ebx = 9 -> 1001

        call print_int  ; print eax
        call print_nl   ; print a newline

        ; zero out top 16 bits
        mov eax, -1     ; eax = -1 (all 1s or Fs)
        and eax, 0FFFFH ; eax & FFFFH = 0000FFFFH
        dump_regs 1     ; dump the registers

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


