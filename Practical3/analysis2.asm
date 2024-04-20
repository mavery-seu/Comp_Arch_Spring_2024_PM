; Sample analysis for Exam 3 - Spring 2024

; The floating point operations are as described in the comments in the code. 
; Trace out what happens when the parameters are baseA = 2.5, baseB = 3.5 and 
; then height = 4.0. What does the coprocessor stack look like at each step and 
; what is the final answer?

; initialized data
segment .data
float_format db "%f", 0
message_format db "Area: %f", 0

positive_two dd 2

; uninitialized data
segment .bss
area_global resd 1

segment .text
		global get_float, get_trapezoid_area
        extern scanf, printf, fscanf

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

%define baseA dword [ebp + 8]
%define baseB dword [ebp + 12]
%define height dword [ebp + 16]
%define area dword [ebp + 20]
get_trapezoid_area:
get_trapezoid_area:
    push ebp
    mov ebp, esp
    push ebx

    fld baseA ; push baseA onto the stack
    fld baseB ; push baseB onto the stack

    ; ST1 += ST0 and pop ST0
    faddp st1 

    ; push height onto the stack
    fld height 

    ; ST1 *= ST0 and pop ST0
    fmulp st1

    ; push the integer 2 onto the stack
    fild dword [positive_two]

    ; ST1 /= ST0 and pop ST0
    fdivp st1

    mov ebx, area

    ; pop ST0 and store in [EBX]
    fstp dword [ebx]	

    pop ebx
    pop ebp
    ret
