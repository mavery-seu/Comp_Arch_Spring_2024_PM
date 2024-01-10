

;
; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
blossom db "🌸", 0
daisy db "🌼", 0
rose db "🌹", 0
goat db "🐐", 0

done_message db "DONE! 🥳", 0

segment .bss
;
; uninitialized data is put in the bss segment
;

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
       pusha

;
; code is put in the text segment. Do not modify the code before
; or after this comment.
;
		call print_2_rows
		call print_nl			

		call print_3_rows
		call print_nl

		call print_4_rows
		call print_nl

		mov eax, done_message
		call print_string

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

print_2_rows:  			 	; subprogram that prints 1st 2 rows of structure
	; dump_stack 2, 12, -8
	; call printnl

	mov eax, blossom
	call print_string
	call print_nl

	mov eax, daisy

	mov ecx, 2
print_daisy:
	call print_string
	loop print_daisy

	call print_nl
	
	ret

print_3_rows:				; subprogram that prints 1st 3 rows of structure
	; dump_stack 3, 12, -8
	; call print_nl

	call print_2_rows

	mov eax, rose

	mov ecx, 3
print_rose:
	call print_string
	loop print_rose

	call print_nl

	ret
print_4_rows:	; subprogram that prints all 4 rows of the structure
	; dump_stack 4, 12, -8
	; call print_nl

	call print_3_rows

	mov eax, goat

	mov ecx, 4
print_goat:
	call print_string
	loop print_goat

	call print_nl

	ret

