; Author: Megan Avery Spring 2024

%include "asm_io.inc"
segment .data

;
; initialized data is put in the data segment here
;
SIN dd 1
COS dd 2
TAN dd 3

float_format db "%4f", 0
float_format_normal db "%4f", 10,  0

positive_two dd 2

segment .bss

segment .text
        global  get_float, calculate_hypotenuse, calculate_area, calculate_sohcahtoa, SIN, COS, TAN, get_perimeter
		extern fscanf, printf

; get a floating point from the user
%define file_pointer dword [ebp + 8]
%define double_pointer dword [ebp + 12]
get_float:
		enter 0, 0
		push ebx

		push double_pointer
		push float_format
		push file_pointer
		call fscanf
		add esp, 12

		pop ebx
		leave
		ret


; calculate the hypotenuse based on the given side lengths
%define a dword [ebp + 8]
%define b dword [ebp + 12]
%define hypotenuse_addr dword [ebp + 16]
calculate_hypotenuse:
		enter 0, 0
		push ebx

		fld b		; stack: b
		fld a		; stack: a, b

		fld b		; stack: b, a, b
		fld a		; stack: a, b, a, b

		fmulp st2	; stack: b, a^2, b
		fmulp st2	; stack: a^2, b^2

		faddp st1	; stack: a^2 + b^2
	
		fsqrt		; stack: sqrt(a^2 + b^2)

		mov ebx, hypotenuse_addr
		fstp dword [ebx]	; save top of stack into value for hypotenuse and pop st0

		pop ebx
		leave
		ret

; calculate the area of a triangle
%define base dword [ebp + 8]
%define height dword [ebp + 12]
%define area dword [ebp + 16]
calculate_area:
		enter 0, 0
		push ebx

		fld height		; stack: height
		fld base		; stack: base, height

		fmulp st1		; stack: base * height

		fild dword [positive_two]	; stack: 2, base * height

		fdivp st1		; stack: (base * height) / 2

		mov ebx, area
		fstp dword [ebx] ; update area and pop off st0

		pop ebx
		leave 
		ret

; calucate the sin, cos, or tan 
%define opposite dword [ebp + 8]
%define adjacent dword [ebp + 12]
%define hypotenuse dword [ebp + 16]
%define answer dword [ebp + 20]
%define choice dword [ebp + 24]
calculate_sohcahtoa:
		enter 0, 0
		push ebx

		mov ebx, [SIN]
		cmp choice, ebx
		je sin

		mov ebx, [COS]
		cmp choice, ebx
		je cos

tan:
		fld opposite		; stack: opposite
		fld adjacent		; stack: adjacent, opposite
		jmp calculate

sin:
		fld opposite		; stack: opposite
		fld hypotenuse		; stack: hypoteuse
		jmp calculate		

cos:	
		fld adjacent		; stack: adjacent
		fld hypotenuse		; stack: hypotenuse

calculate:
		fdivp st1			; stack: left / right

		mov ebx, answer
		fstp dword [ebx]	; answer stored and st0 popped off
		
		pop ebx
		leave
		ret

; calculate the perimeter of an isosceles triangle
%define length1 dword [ebp + 8]
%define length2 dword [ebp + 12]
%define perimeter dword [ebp + 16]
get_perimeter:
	push ebp
	mov ebp, esp

	fld length2
	fld length1
	fild dword [positive_two]

	fmulp st1
	faddp st1

	mov eax, perimeter
	fstp dword [eax]


	pop ebp
	ret
