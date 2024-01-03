; Author: Megan Avery Spring 2024

%include "asm_io.inc"
segment .data
;
; initialized data is put in the data segment here
;
NUMBERS_LENGTH EQU 10
BYTES_IN_INT EQU 4

segment .bss
;
; uninitialized data is put in the bss segment
;


segment .text
        global print_substring, reverse_into_buffer, concatenate_strings, is_palindrome

%define src [ebp + 8]
%define start [ebp + 12]
%define end [ebp + 16]
print_substring:
		enter 0, 0
		push esi

		cld
		xor eax, eax

		mov esi, src
		
		mov ecx, start
		rep lodsb

		mov ecx, end
		sub ecx, start

print_loop:
		lodsb
		call print_char
		loop print_loop

		pop esi
		leave
		ret

%define src [ebp + 8]
%define dest [ebp + 12]
%define size [ebp + 16]
reverse_into_buffer:
		enter 0, 0
		push esi
		push edi

		mov esi, src

		mov edi, dest
		add edi, size

		std
		xor eax, eax
		stosb

		xor eax, eax
		mov ecx, size
rev_loop:
		cld
		lodsb

		std
		stosb

		loop rev_loop

		pop edi
		pop esi
		leave
		ret

%define src1 [ebp + 8]
%define src1_len [ebp + 12]
%define src2 [ebp + 16]
%define src2_len [ebp + 20]
%define dest [ebp + 24]
concatenate_strings:
		enter 0, 0
		push esi
		push edi

		mov esi, src1
		mov edi, dest

		cld
		mov ecx, src1_len
		rep movsb

		mov esi, src2
		mov ecx, src2_len
		rep movsb

		xor eax, eax
		stosb

		pop edi
		pop esi
		leave
		ret

%define src [ebp + 8]
%define len [ebp + 12]
is_palindrome:
		enter 0, 0
		push esi
		push edi

		mov esi, src
		mov edi, src
		add edi, len
		dec edi
	
		mov ecx, len
check_loop:
		mov ah, [esi]
		mov al, [edi]
		cmp ah, al
		jne not_a_palindrome

		inc esi
		dec edi
		loop check_loop

		mov eax, 1
		jmp end_of_subprogram

not_a_palindrome:
		mov eax, [esi]
		call print_char
		mov eax, [edi]
		call print_char
		xor eax, eax

end_of_subprogram:
		pop edi
		pop esi
		leave
		ret

