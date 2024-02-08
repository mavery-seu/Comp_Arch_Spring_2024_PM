; Base Author: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]

; Purpose - to learn the following:
; 	- logical shifts
;	- arithmetic shifts
;	- rotate shifts

%include "asm_io.inc"

; initialized data
segment .data
left_prompt db "Shift left by: ", 0

; uninitialized data
segment .bss


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        ; shifting to the left - multiplying
        mov eax, 10     ; eax = 10
        shl eax, 3      ; eax << 3, multiply by 8 (2^3)
        call print_int  ; print eax (80)
        call print_nl   ; print a newline

        ; shifting left - sign bit falls off
        mov eax, 080000045H ; eax = large negative number 
        call print_int  ; print large number
        call print_nl   ; print a newline
        shl eax, 1      ; eax << 1
        call print_int  ; print eax <- sign will be switched
        call print_nl   ; print a newline

        ; INCORRECT - can only use CL as the shift amount
        ; mov ebx, 3    ; ebx = 3
        ; mov eax, 20   ; eax = 20
        ; shl eax, ebx  ; attempt to shift eax left by 3 (DOENS'T WORK)
        ; call print_int; print eax

        ; shifting right - dividing
        mov eax, 23     ; eax = 23
        shr eax, 2      ; eax >> 2, divide by 4 (2^2) -> 5
        call print_int  ; print eax

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret




