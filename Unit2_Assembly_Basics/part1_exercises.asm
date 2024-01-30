; 
; Base Author:  Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]
; 
; Purpose - to learn about the following:
; 	- comments
;	- dumping registers
;	- printing empty lines
;	- instructions: mov, add, sub, inc/dec

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

	; dump_regs 1
        ; call print_nl
        ; dump_regs 2

        ; mov eax, 0
        ; mov ah, 18
        ; mov al, 0BAH
        ; dump_regs 1
        ; call print_nl

        ; mov ax, 4
        ; dump_regs 2

        ; mov eax, 3 ; eax = 3
        ; mov ebx, 4 ; eax = 4
        ; add eax, ebx ; eax += ebx, eax = 7
        ; dump_regs 1

        ; mov eax, 40
        ; dump_regs 1
        ; call print_nl

        ; mov ebx, 2
        ; dump_regs 2
        ; call print_nl

        ; add eax, ebx
        ; dump_regs 3
        ; call print_nl

        ; mov eax, 34
        ; sub eax, 19 ; immediate operand
        ; dump_regs 1

        ; mov eax, -32
        ; dump_regs 2

        ; inc 23 ; ERROR

        ; mov eax, 16
        ; dump_regs 1
        ; call print_nl

        ; sub eax, 4
        ; dump_regs 2
        ; call print_nl

        ; mov ebx, eax
        ; dump_regs 3
        ; call print_nl

        ; inc ebx
        ; dump_regs 4

        ; mov eax, 4
        ; mov ebx, 4
        ; mov ecx, 4

        ; add eax, ebx ; 8
        ; add ebx, ecx ; 8
        ; add ecx, eax ; 12

        ; 8a + 4a = 12a
        mov ebx, 4

        add ebx, ebx ; 2 * 4 = 8 (2a)
        add ebx, ebx ; 2 * 8 = 16 (4a)
        mov ecx, ebx ; ecx = 16 (4a)

        add ebx, ebx ; 2 * 16 = 32 (8a)

        add ebx, ecx ; 16 + 32 = 48 (12a)
        dump_regs 1

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


