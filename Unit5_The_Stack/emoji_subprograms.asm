; Author: Megan Avery Spring 2024 

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
		; prologue
        enter   0,0               	; setup routine
        pusha

		call print_2_rows			; push return address and jump print_2_rows subprogram
		call print_nl				; print a newline						

		call print_3_rows			; push return address and jump print_3_rows subprogram
		call print_nl				; print a newline 

		call print_4_rows			; push return address and jump print_4_rows subprogram
		call print_nl				; print a newline

		mov eax, done_message		; move done_message into EAX
		call print_string			; print done_message

		; epilogue
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

print_2_rows:  			 	 	; subprogram that prints 1st 2 rows of structure
	; debugging	
	; dump_stack 2, 12, -6
	; call print_nl

	mov eax, blossom			; move blossom into EAX
	call print_string			; print blossom
	call print_nl				; print a newline

	mov eax, daisy				; move daisy into EAX

	; print out 2 daisies
	mov ecx, 2					; move 2 into ECX (loop counter)
print_daisy:					; label for top of the for loop
	call print_string			; print daisy
	loop print_daisy			; decrement ECX, if it is != 0 then jump to print_daisy label

	call print_nl				; print a newline 

	ret							; return back to the caller (pop off ret addr and jump to it)

print_3_rows:					; subprogram that prints 1st 3 rows of structure
	; debbuing
	; dump_stack 3, 12, -5
	; call print_nl

	call print_2_rows			; push return address and jump print_2_rows subprogram

	mov eax, rose				; move rose into EAX

	; print 3 roses 
	mov ecx, 3					; move 3 into ECX (loop counter)
print_rose:						; label for top of the for loop
	call print_string			; print rose
	loop print_rose				; decrement ECX, if it is != 0 then jump to the print_rose label

	call print_nl				; print a newline

	ret							; return back to the caller (pop off ret addr and jump to it)

print_4_rows:	; subprogram that prints all 4 rows of the structure
	; debugging
	; dump_stack 4, 12, -4
	; call print_nl

	call print_3_rows			; push return address and jump print_3_rows subprogram

	mov eax, goat				; move goat into EAX

	; print 4 goats
	mov ecx, 4					; move 4 into EAX (loop counter)
print_goat:						; label for the top of the for loop
	call print_string			; print goat
	loop print_goat				; decrement ECX, if it is != 0 then jump to the print_goat label

	call print_nl				; print a newline

	ret							; return back to the caller (pop off ret addr and jump to it)

