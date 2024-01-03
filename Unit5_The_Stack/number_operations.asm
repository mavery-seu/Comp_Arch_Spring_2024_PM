; Author: Megan Avery Spring 2024 
; 
; Purpose: showcase the stack through operations on a binary number

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
; prompts and output messages
prompt db "Enter a binary number: ", 0

base10_msg db "Number in base 10: ", 0
count_msg db "Number of 1s: ", 0

segment .bss
;
; uninitialized data is put in the bss segment
;
; will hold return values from the subprograms
base10_answer resd 1
count_answer resd 1

 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

		; print initial prompt
		mov eax, prompt
		call print_string
		call read_int
		
		push base10_answer			; push where to hold base 10 version		
		push eax					; push user entered binary numbers
		call binary_to_base10		; call subprogram to convert to base 10
		add esp, 8					; remove the parameters from the stack

		; printing new base 10 number
		call print_nl
		mov eax, base10_msg		
		call print_string
		mov eax, [base10_answer]
		call print_int
		call print_nl

		push count_answer	   		; push where to hold count of 1s
		push dword [base10_answer]	; push number to count 1s in
		call count_ones				; call subprogram to count 1s
		add esp, 8					; remove the parameters from the stack

		; printing count of ones
		mov eax, count_msg
		call print_string
		mov eax, [count_answer]
		call print_int

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

; function to convert a "binary" number into base 10
;
; binary_to_base10(int binary_number, int* answer)
binary_to_base10:
	; prologue
	push ebp
	mov ebp, esp
	sub esp, 8					; make room for 2 local variables

	mov dword [ebp - 4], 0   	; power 
	mov dword [ebp - 8], 0   	; final answer

	mov ebx, [ebp + 8]			; binary number into EBX
binary_loop:
	cmp ebx, 0					; end loop when EBX is 0
	je binary_ending	

	xor edx, edx				; clear EDX, getting ready for divison
	mov eax, ebx				; move EBX into EAX, getting ready for division
	mov ecx, 10					; move 10 into ECX (denominator)

	div ecx						; divide EDX:EAX by ECX			

	mov ebx, eax				; move quotient into EBX			

	mov eax, edx				; move remainder into EAX, will be either 1 or 0
	
	mov cl, [ebp - 4]			; move power into CL	
	shl eax, cl					; multiple EAX by 2^CL

	add [ebp - 8], eax			; add EAX to the final answer
	inc dword [ebp - 4]			; increment the power

	jmp binary_loop				; start binary loop over again

binary_ending:
	mov eax, [ebp - 8]			; move final answer into EAX
	
	mov ebx, [ebp + 12]			; move address of return variable into EBX
	mov [ebx], eax				; set the value of EBX to EAX (the final answer)

	; epilogue
	mov esp, ebp
	pop ebp
	ret

; function to count the number of 1s in the
; binary representation of a decimal number
;
; count_ones(int decimal_number, int* answer)
count_ones:
	; prologue
	push ebp
	mov ebp, esp
	sub esp, 4

	mov dword [ebp - 4], 0   	; count of 1s

	mov eax, [ebp + 8]			; move decimal number into EAX
	xor ebx, ebx				; zero out EBX
count_loop:
	cmp eax, 0					; stop loop if EAX is 0
	je count_ending

	shr eax, 1					; shift of right most bit of EAX
	setc bl						; set BL based on the carry flag

	add [ebp - 4], ebx			; add 1 or 0 to the final answer

	jmp count_loop				; start count loop over again

count_ending:
	mov eax, [ebp - 4]			; move final count into EAX

	mov ebx, [ebp + 12]			; move return variable address into EBX
	mov [ebx], eax				; set value at EBX to the final count of 1s

	; epilogue
	mov esp, ebp
	pop ebp
	ret

