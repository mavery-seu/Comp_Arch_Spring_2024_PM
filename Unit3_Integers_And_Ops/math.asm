

;
; file: math.asm
; This program demonstrates how the integer multiplication and division
; instructions work.
;
; To create executable:
; nasm -f coff math.asm
; gcc -o math math.o driver.c asm_io.o

%include "asm_io.inc"

segment .data
;
; Output strings
;
prompt          db    "Enter a number: ", 0
square_msg      db    "Square of input is ", 0
cube_msg        db    "Cube of input is ", 0
cube25_msg      db    "Cube of input times 25 is ", 0
quot_msg        db    "Quotient of cube/100 is ", 0
rem_msg         db    "Remainder of cube/100 is ", 0
neg_msg         db    "The negation of the remainder is ", 0

segment .bss
input   resd 1


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, prompt     ; setup prompt to be printed
        call    print_string    ; print prompt

        call    read_int        ; reading number (int) from user
        mov     [input], eax    ; moving number into [input]

        imul    eax             ; edx:eax = eax * eax
        mov     ebx, eax        ; save answer in ebx
        mov     eax, square_msg ; setup square message
        call    print_string    ; print square message
        mov     eax, ebx        ; eax = ebx
        call    print_int       ; print eax (number ^ 2)
        call    print_nl        ; print newline

        mov     ebx, eax        ; ebx = eax -> (number ^ 2)
        imul    ebx, [input]    ; ebx *= [input] -> (number ^ 3)
        mov     eax, cube_msg   ; move cube message into eax 
        call    print_string    ; print the cube message
        mov     eax, ebx        ; eax = ebx -> (number ^ 3)
        call    print_int       ; print out number ^ 3
        call    print_nl        ; print a newline

        imul    ecx, ebx, 25    ; ecx = ebx * 25
        mov     eax, cube25_msg ; move cube25 message into eax
        call    print_string    ; print cube25 message
        mov     eax, ecx        ; eax = ecx -> (number ^ 3) * 25
        call    print_int       ; print (number ^ 3) * 25
        call    print_nl        ; print a newline

        mov     eax, ebx        ; eax = ebx -> (number ^ 3)
        cdq                     ; initialize edx by sign extension (all 0s)
        mov     ecx, 100        ; can't divide by immediate value so ecx = 100
        idiv    ecx             ; edx:eax / ecx -> (number ^ 3) / 100
        mov     ecx, eax        ; save quotient into ecx
        mov     eax, quot_msg   ; move quotient message into eax
        call    print_string    ; print quotient message
        mov     eax, ecx        ; eax = ecx -> quotient
        call    print_int       ; print the quotient
        call    print_nl        ; print a newline
        mov     eax, rem_msg    ; move remainder message into eax
        call    print_string    ; print remainder message
        mov     eax, edx        ; eax = edx -> remainder
        call    print_int       ; print the remainder
        call    print_nl        ; print a newline
        
        neg     edx             ; negate edx (the remainder)
        mov     eax, neg_msg    ; move negate message into eax
        call    print_string    ; print negate message
        mov     eax, edx        ; eax = edx (the negation of the remainder)
        call    print_int       ; print the negation of the remainder
        call    print_nl        ; print a newline

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret






