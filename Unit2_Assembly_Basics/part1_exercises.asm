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

        ; dumping registers
	dump_regs 1     ; dump registers
        call print_nl   ; print a newline
        dump_regs 2     ; dump registers
        call print_nl   ; print newline

        ; MOV examples
        mov eax, 0      ; eax = 0       
        mov ah, 18      ; ah = 18 (base 10)
        mov al, 0BAH    ; al = BA (base 16)
        dump_regs 3     ; dump registers
        call print_nl   ; print newline

        mov ax, 4       ; ax = 4 (base 10)
        dump_regs 4     ; dump registers
        call print_nl   ; print newline

        ; ADD example
        mov eax, 3      ; eax = 3
        mov ebx, 4      ; eax = 4
        add eax, ebx    ; eax += ebx, eax = 7
        dump_regs 5     ; dump registers
        call print_nl   ; print newline

        ; ADD exercise  
        mov eax, 40     ; eax = 40
        dump_regs 6     ; dump registers
        call print_nl   ; print newline

        mov ebx, 2      ; ebx = 2
        dump_regs 7     ; dump registers
        call print_nl   ; print newline

        add eax, ebx    ; eax += ebx, eax = 42
        dump_regs 8     ; dump registers
        call print_nl   ; print newline

        ; SUB example
        mov eax, 34     ; eax = 34
        sub eax, 19     ; immediate operand, eax -= 19, eax = 15
        dump_regs 0     ; dump registers
        call print_nl   ; print newline

        ; negative number example
        mov eax, -32    ; eax = 32 (base 10)
        dump_regs 10     ; dump registers
        call print_nl   ; print newline

        ; inc 23 ; ERROR, cannot increment an immediate operand

        ; SUB exercise
        mov eax, 16     ; eax = 16
        dump_regs 11     ; dump registers
        call print_nl   ; print newline

        sub eax, 4      ; eax -= 4, eax = 12
        dump_regs 12     ; dump registers        
        call print_nl   ; print newline

        mov ebx, eax    ; ebx = eax, ebx = 12
        dump_regs 13     ; dump registers
        call print_nl   ; print newline

        inc ebx         ; ebx++, ebx = 13
        dump_regs 14     ; dump registers
        call print_nl

        ; attempting 4 * 12 with as few instructions as possible
        ; 8a + 4a = 12a
        mov ebx, 4      ; ebx = 4 (a)

        add ebx, ebx    ; 2 * 4 = 8 (2a)
        add ebx, ebx    ; 2 * 8 = 16 (4a)
        mov ecx, ebx    ; ecx = 16 (4a)

        add ebx, ebx    ; 2 * 16 = 32 (8a)

        add ebx, ecx    ; 16 + 32 = 48 (12a)
        dump_regs 15     ; dump registers 

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


