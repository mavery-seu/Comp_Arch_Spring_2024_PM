; Base Author: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]

; Purpose - to learn the following:
; 	- logical shifts
;	- arithmetic shifts
;	- rotate shifts

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

	; mov eax, 10
        ; shl eax, 3
        ; call print_int
        
        ; mov ebx, 2
        ; shl eax, ebx

        ; mov eax, 080000045H
        ; call print_int
        ; call print_nl

        ; shl eax, 1
        ; call print_int

        ; mov eax, 23
        ; shr eax, 2
        ; call print_int

        ; mov eax, 4 ; 0100
        ; mov ebx, 2 ; 0010
        ; test eax, ebx
        ; dump_regs 1

        ; zero out register
        ; shift until empty
        ; mov eax, 190
        ; shl eax, 100
        ; call print_int
        ; mov eax, 13
        ; xor eax, eax
        ; call print_int

        ; mov ebx, 1
        ; shl ebx, 2

        ; mov eax, 11
        ; or eax, ebx
        ; call print_int

        ; mov ebx, 1
        ; shl ebx, 3
        ; not ebx

        ; mov eax, 15
        ; and eax, ebx
        ; call print_int

        mov ebx, 00000FFFFH
        mov eax, -1

        and eax, ebx
        dump_regs 1

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


