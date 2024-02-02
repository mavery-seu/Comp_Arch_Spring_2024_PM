; Base Author: Megan Avery Spring 2024
; Exercise Author: [YOUR NAME HERE]
; 
; Purpose - to learn about the following:
;	-  directives (dx, resx, & times)
;	- printing ints and characters
;	- dumping memory
;	- printing strings
;	- reading chars and ints

%include "asm_io.inc" ; directive

age equ 30              ; symbol
%define fav_number 34   ; macro

; initialized data
segment .data
fav_color db "purple 💜", 0 ; string
least_fav_color db "yellow", 0 ; string
letter db "A"   ; character
number dd 95    ; integer
first dd 82     ; integer (ascii for "R")

; general strings
hello_world db "Hello World!", 0
char_prompt db "Enter a character: ", 0
number_prompt db "Enter a number: ", 0

many_numbers times 5 dd 12 ; 5 integers set to 12

many_chars times 5 db "Z"  ; 5 characters set to Z

; uninitialized data
segment .bss
space_for_number resd 1 ; space for 1 integer
space_for_char resb 1 ; space for 1 character

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov dword [number], 116 ; set value of number to 116
        mov eax, [number]       ; eax = 116, the value at number
        dump_regs 1             ; dump the registers
        call print_nl           ; print a newline

        call print_int          ; print number's value in base 10
        call print_nl           ; print a newline

        mov al, [letter]        ; move the value of letter into al
        call print_char         ; print the character whose ascii stored in al
        call print_nl           ; print a newline

        ; print_int & print_char exercise
        mov eax, [first]        ; move the value of first into eax
        call print_int          ; print int in eax (82)
        call print_nl           ; print a newline
        call print_char         ; print char for ascii value 82 ("R")
        call print_nl           ; print a newline

        dump_mem 1, fav_color, 2 ; dump the memory at fav_color plus 2 extra paragraphs
        call print_nl           ; print a newline

        mov eax, fav_color      ; mov address of fav_color into eax
        call print_string       ; print the string ("purple 💜")
        call print_nl           ; print a newline

        ; hello world exercise
        mov eax, hello_world    ; mov address of hello_world into eax
        call print_string       ; print "Hello World!"
        call print_nl           ; print_nl
        dump_mem 1, hello_world, 0 ; dump the memory at hello_world with no extra paragraphs

        ; read char example
        mov eax, char_prompt    ; mov the prompt for getting a char into eax
        call print_string       ; print propmt for getting a character, from eax
        call read_char          ; read a single character from the user
        call print_nl           ; print a newline
        call print_char         ; print the character that was read on line 78
        call print_nl           ; print a newline

        ; what happens when we print an uninitialized integer
        mov eax, [space_for_number] ; mov value at space for number into eax (uninitialized)
        call print_int          ; print the integer in eax
        call print_nl           ; print a newline

        ; read int example
        mov eax, number_prompt  ; mov prompt for getting a number into eax
        call print_string       ; print prompt for getting a nunber, from eax
        call read_int           ; read an integer from the user
        mov dword [space_for_number], eax ; store integer entered by user in space_for_number, dword required

        ; reading a char example, to show that read char consumes a newline character
        mov eax, char_prompt    ; mov prompt for getting a character to eax
        call print_string       ; print the character prompt, from eax
        call read_char          ; read a character
        call print_nl           ; print a newline
        call print_char         ; print the character gotten from the user

        ; moving a character into an unitialized spot
        mov eax, char_prompt    ; mov character prompt into eax
        call print_string       ; print the string in eax
        call read_char          ; get a character from the use
        mov byte [space_for_char], al ; move character in al into byte space in space_for_char

        ; moving an int into an unitialized spot
        call read_int           ; read an integer from the user (no prompt)
        mov dword [space_for_number], eax ; move integer in eax into double word space in space_for_number
        call print_nl           ; print a newline

        ; mem dumps to show that memory dumping aligns on paragraph boundaries
        dump_mem 1, many_chars, 0 ; memory dump many_chars
        call print_nl            ; print a newline      
        dump_mem 2, many_chars + 3, 0 ; memory dump starting at 3 bytes past many_chars

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret