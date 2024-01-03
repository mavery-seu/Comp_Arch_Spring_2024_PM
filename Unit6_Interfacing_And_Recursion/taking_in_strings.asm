; Author: Megan Avery Spring 2024

%define NL 10

segment .data

; prompts
first_name_prompt db  "First Name: ", 0       ; don't forget null terminator
last_name_prompt db  "Last Name: ", 0
hometown_prompt db "Hometown: ", 0

; string formats
str_format db "%15s", 0
final_output_format db "Welcome! %s %s from %s!", 0

; create the "empty" strings to hold user input
first_name times 16 db 0
last_name times 16 db 0
home_town times 16 db 0

segment .bss


segment .text
        global  asm_main
		extern scanf, printf, putchar
asm_main:
        enter   0,0               ; setup routine
        pusha

		; print out 1st prompt
		push dword first_name_prompt
		call printf
		pop ecx

		; get first name
		push first_name
		push dword str_format
		call scanf
		add esp, 8
		
		; print out 2nd prompt
		push dword last_name_prompt
		call printf
		pop ecx
		
		; get last name
		push last_name
		push dword str_format
		call scanf
		add esp, 8

		; print out 3rd prompt
		push dword hometown_prompt
		call printf
		pop ecx

		; get hometown
		push home_town
		push dword str_format
		call scanf
		add esp, 8

		; print an empty line
		; beware: changes EAX
		push dword NL
		call putchar
		pop ecx

		; print out full welcome message
		push home_town
		push last_name
		push first_name
		push final_output_format
		call printf
		add esp, 16

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
