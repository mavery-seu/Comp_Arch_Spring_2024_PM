; Author: Megan Avery Spring 2024 

%include "asm_io.inc"

segment .text
        global  binary_to_base10, count_ones

; function to convert a "binary" number into base 10
;
; int binary_to_base10(int binary_number)
binary_to_base10:
	; prologue
	push ebp
	mov ebp, esp
	sub esp, 8					; make room for 2 local variables
	push ebx

	pusha

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

	popa
	mov eax, [ebp - 8]			; move final answer into EAX

	pop ebx
	; epilogue
	mov esp, ebp
	pop ebp
	ret

; function to count the number of 1s in the
; binary representation of a decimal number
;
; int count_ones(int decimal_number)
count_ones:
	; prologue
	push ebp
	mov ebp, esp
	sub esp, 4
	push ebx

	pusha

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

	popa
	mov eax, [ebp - 4]			; move final count into EAX

	pop ebx
	; epilogue
	mov esp, ebp
	pop ebp
	ret

