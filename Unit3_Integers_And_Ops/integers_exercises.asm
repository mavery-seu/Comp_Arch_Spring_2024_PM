; Base Author: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]
;
; Purpose - to learn about the following:
;	- sign extension, decreasing/ increasing data size
;	- two's complement addition & subtraction
;	- integer multiplication
;	- integer division
;	- the neg instruction

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

	; mov eax, -34
        ; dump_regs 1

        ; incorrect extension
        ; mov eax, 0
        ; mov al, 0DEH
        ; call print_int
        ; call print_nl

        ; correct extension
        ; mov eax, -1
        ; mov al, 0DEH
        ; call print_int

        ; incorrect extension
        mov eax, -1
        mov al, 00CH
        call print_int
        call print_nl

        ; correct
        mov eax, 0
        mov al, 00CH
        call print_int

        mov eax, -1
        mov ax, 045H
        dump_regs 1
        call print_nl

        movzx eax, ax
        dump_regs 2

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


