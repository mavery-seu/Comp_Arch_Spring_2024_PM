; Author: Megan Avery Spring 2024 

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
message db "Happy UnBirthday!", 0
flame db "   🔥", 0
candle_body db "   #", 0

cake db "*******", 0

plate db "-------", 0

segment .bss
;
; uninitialized data is put in the bss segment
;


segment .text
        global  asm_main

; BEGIN asm_main subprogram
asm_main:
    	enter   0,0               	; setup routine
       	pusha	

		mov ecx, $ + 7				; move address of line 29 into ECX, where to return to
		jmp short print_candle		; jump to the print_candle subprogram

		mov ecx, post_cake			; move the post_cake label into ECX, where ot return to
		jmp short print_cake		; jump to the print_cake subprogram

post_cake:							; post_cake label
		mov ecx, $ + 7				; move address for line 38 into ECX, where to return to
		jmp short print_plate		; jump to the print_plate subprogram

		call print_nl				; print a newline character
		mov eax, message			; move message into EAX
		call print_string			; print message
		
        popa
        mov     eax, 0    	        ; return back to C
        leave                     
        ret
; END asm_main subprogram

; BEGIN print_candle subprogram
print_candle:						; label for print_candle subprogram
		mov eax, flame				; move flame into EAX
		call print_string			; print flame
		call print_nl				; print a newline

		mov eax, candle_body		; move candle_body into EAX
		call print_string			; print candle_body
		call print_nl				; print a newline
		call print_string			; print candle_body
		call print_nl				; print a newline

		jmp ecx						; jump back to caller, based on address in ECX
; END print_candle subprogram

; BEGIN print_cake subprogram
print_cake:							; label for print_cake subprogram
		mov eax, cake				; move cake in EAX

		mov ebx, ecx				; move ECX to EBX, save off return address

		mov ecx, 3					; move 3 into ECX, how many times the loop will run
print_cake_row:						; label for the print_cake_row loop
		call print_string			; print cake
		call print_nl				; print a newline
		
		loop print_cake_row			; loop back to print_cake_row, dec ECX and jump if ECX != 0

		mov ecx, ebx				; move EBX to ECX, restore the return address
		jmp ecx						; jump back to caller, based on address in ECX
; END print_cake subprogram
	
; BEGIN print_plate subprogram
print_plate:						; label for print_plate subprogram
		mov eax, plate				; move plate into EAX
		call print_string			; print plate
		call print_nl				; print a newline

		jmp ecx						; jump back to caller, based on address in ECX
; END print_plate subprogram
