; Author: Megan Avery Spring 2024
;
; Used for tracing in class

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
prompt db "Calculate which fibonacci number? ", 0


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

		mov eax, prompt
		call print_string
		call read_int

	 	push eax
		call fib
		pop ebx

		call print_nl
		call print_int
       
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

fib:
	push ebp
	mov ebp, esp
	sub esp, 4

	cmp dword [ebp + 8], 0
	jle zero

	cmp dword [ebp + 8], 1
	je one

	mov ebx, [ebp + 8]
	dec ebx

	push ebx
	call fib
	pop ecx

	mov [ebp - 4], eax

	mov ebx, [ebp + 8]
	sub ebx, 2
	push ebx
	call fib
	pop ecx

	add eax, [ebp - 4]
	jmp end

zero:
	mov eax, 0
	jmp end

one:
	mov eax, 1

end:

	mov esp, ebp
	pop ebp
	ret
