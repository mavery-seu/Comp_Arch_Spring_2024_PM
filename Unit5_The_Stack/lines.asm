; Author: Megan Avery Spring 2024

%include "asm_io.inc"

; macros for number codes
%define RED 0
%define ORANGE 1
%define YELLOW 2
%define GREEN 3
%define BLUE 4
%define PURPLE 5
%define PINK 6
%define BABY_BLUE 7
%define WHITE 8

; macro for a newline character
%define NL 10

; initialized data
segment .data
; color_header db "\x1b[32mPick a color: ", 10, 0
color_header db "Choose a line color:", NL, 0  ; ANSI escape sequences for color
flag_chooser db "Choose 6 colors for your flag:", NL, 0

; strings for color menu
red db ") red ", NL, 0
orange db ") orange ", NL, 0
yellow db ") yellow ", NL, 0
green db ") green ", NL, 0
blue db ") blue ", NL, 0
purple db ") purple ", NL, 0
pink db ") pink", NL, 0
baby_blue db ") baby blue", NL, 0
white db ") white", NL, 0
color_input db "Choice: ", 0

; "color" strings
red_emoji db "🟥", 0
orange_emoji db "🟧", 0
yellow_emoji db "🟨", 0
green_emoji db "🟩", 0
blue_emoji db "🟦", 0
purple_emoji db "🟪", 0
pink_emoji db "🌸", 0
baby_blue_emoji db "🩵 ", 0
white_emoji db "⬜️", 0

; uninitialized data
segment .bss

segment .text
        global pick_color, draw_line, draw_flag         ; make these subprograms accessible outside of this file

; Draw a flag to the screen, based on user color choices
;
; Stack Frame:
; ------------
; EBP + 8       param 1: the width of the flag
; EBP + 4       return address
; EBP           previous EBP
; EBP - 4       local variable 1: color input 1
; EBP - 8       local variable 2: color input 2
; EBP - 12      local variable 3: color input 3
; EBP - 16      local variable 4: color input 4
; EBP - 20      local variable 5: color input 5
; EBP - 24      local variable 6: color input 6
draw_flag:
        ; prologue
        push ebp                                        ; push the base pointer onto the stack
        mov ebp, esp                                    ; move the stack pointer into the base pointer
        sub esp, 24                                     ; subtract 24 from the stack pointer, space for 6 local variables

        mov eax, flag_chooser                           ; move flag_chooser into EAX
        call print_string                               ; print flag_chooser

        ; loop to pick all the colors for the flag
        mov ecx, 1                                      ; move 1 into ECX, the loop counter
pick_color_loop:                                        ; label for the top of the do while loop
        call pick_color                                 ; push the return address onto the stack and jump to pick_color
        call print_nl                                   ; print a newline

        mov ebx, ebp                                    ; move the base pointer into EBX
        mov edx, ecx                                    ; move the loop counter into EDX
        shl edx, 2                                      ; multiply the loop counter by 4

        sub ebx, edx                                    ; subtract EDX from EBX, getting us to the correct local variable spot
        mov [ebx], eax                                  ; move the value in EAX (the color code chosen) into the calculated local variable

        inc ecx                                         ; increment ECX, the loop counter
        cmp ecx, 6                                      ; compare the loop counter to 6
        jle pick_color_loop                             ; if the loop counter is <= 6 jump to pick_color_loop

        ; loop to print all the colors of the flag, a line per color
        mov ecx, 1                                      ; move 1 into ECX, the loop counter                                   
draw_flag_lines_loop:                                   ; label for the draw_flag_lines_loop
        mov ebx, ebp                                    ; move the base pointer into EBX
        mov edx, ecx                                    ; move ECX, the loop counter, into EDX
        shl edx, 2                                      ; multiply the loop counter by 4

        sub ebx, edx                                    ; subtract EDX from EBX, getting us to the correct local variable spot
        mov eax, [ebx]                                  ; move the value in the local variable (a color code) into EAX

        push ecx                                        ; push ECX onto the stack, this isn't a parameter but a way to save ECX's value for later
        push eax                                        ; push EAX, the current color code, onto the stack
        push dword [ebp + 8]                            ; push the width of the flag onto the stack
        call draw_line                                  ; push the return address onto the stack and jump to draw_line
        add esp, 8                                      ; add 8 to the stack pointer to get rid of the parameters
        pop ecx                                         ; restore ECX from the stack

        call print_nl                                   ; print a newline

        inc ecx                                         ; increment ECX, the loop counter
        cmp ecx, 6                                      ; compare ECX to 6
        jle draw_flag_lines_loop                        ; if ECX <= 6 jump to draw_flag_lines_loop

        ; epilogue
        mov esp, ebp                                    ; move the base pointer into the stack pointer to get rid of local variables                     
        pop ebp                                         ; pop the base pointer and restore the value of the base pointer
        ret                                             ; pop the return address and jump to that address

; Draw a single line of color
;
; Stack Frame:
; ------------
; EBP + 12      the color code for the line
; EBP + 8       the width of the flag
; EBP + 4       return address
; EBP           previous EBP
draw_line:                                              ; label for the draw_line subprogram
        ; prologue
        push ebp                                        ; push the base pointer onto the stack
	mov ebp, esp                                    ; move the stack pointer into the base pointer

        mov eax, [ebp + 12]                             ; move the color code into EAX
        cmp eax, -1                                     ; compare the color code to -1
        
        ; check if color was provided or not
        jne have_color_code                             ; if the color code isn't negative 1 jump to have_color_code
        call pick_color                                 ; push the return address onto the stack and jump to pick_color
        call print_nl                                   ; print a newline

have_color_code:                                        ; label for when the color code is in EAX
        push eax                                        ; push the color code onto the stack
        call translate_color                            ; push a return address onto the staack and jump to translate_color
        add esp, 4                                      ; add 4 to the stack pointer to get rid of the parameter

        mov ecx, [ebp + 8]                              ; move the width into ECX
draw_loop:                                              ; label for the top of draw_loop for loop
        call print_string                               ; print a single color string

        loop draw_loop                                  ; decrement ECX and if it is != 0 jump to draw_loop

        pop ebp                                         ; pop the base pointer and restore its value
        ret                                             ; pop the return address and jump to that address

; pick a color
;
; Note: EAX will hold the color code of the color picked
;
; Stack Frame:
; ------------
; EBP + 4       return address
; EBP           previous EBP
pick_color:
        ; prologue
        push ebp                        ; push the base pointer onto the stack
	mov ebp, esp                    ; move the stack pointer into the base pointer

        mov eax, color_header           ; move color_header into EAX
        call print_string               ; print the color_header

        ; print red prompt line
        mov eax, RED
        call print_int
        mov eax, red
        call print_string

        ; print orange prompt line
        mov eax, ORANGE
        call print_int
        mov eax, orange
        call print_string

        ; print yellow prompt line
        mov eax, YELLOW
        call print_int
        mov eax, yellow
        call print_string

        ; print green prompt line
        mov eax, GREEN
        call print_int
        mov eax, green
        call print_string

        ; print blue prompt line
        mov eax, BLUE
        call print_int
        mov eax, blue
        call print_string

        ; print purple prompt line
        mov eax, PURPLE
        call print_int
        mov eax, purple
        call print_string

        ; print pink prompt line
        mov eax, PINK
        call print_int
        mov eax, pink
        call print_string

        ; print baby blue prompt line
        mov eax, BABY_BLUE
        call print_int
        mov eax, baby_blue
        call print_string

        ; print white prompt line
        mov eax, WHITE
        call print_int
        mov eax, white
        call print_string

        mov eax, color_input            ; move color_input into EAX
        call print_string               ; print color_input

        call read_int                   ; read the color code from the user

        ; epilogue
        pop ebp                         ; pop the base pointer and restore its previous value
        ret                             ; pop the return address off the stack and jump to it


; Take in a color code and translate it to a color string
;
;
; Stack Frame:
; ------------
; EBP + 8       the color code
; EBP + 4       return address
; EBP           previous EBP
translate_color:
        push ebp                        ; push the base pointer onto the stack
	mov ebp, esp                    ; move the stack pointer into the base pointer

        mov eax, [ebp + 8]              ; move the color code into EAX

        ; switch case for the color codes
        cmp eax, RED                    
        je red_case

        cmp eax, ORANGE
        je orange_case

        cmp eax, YELLOW
        je yellow_case

        cmp eax, GREEN
        je green_case

        cmp eax, BLUE
        je blue_case

        cmp eax, PURPLE
        je purple_case

        cmp eax, PINK
        je pink_case

        cmp eax, BABY_BLUE
        je baby_blue_case

        cmp eax, WHITE
        je white_case

        jmp end_switch                     ; end of the switch case

; cases for the switch case, moving the correct emoji into EAX
red_case:
        mov eax, red_emoji
        jmp end_switch
orange_case:
        mov eax, orange_emoji
        jmp end_switch
yellow_case:
        mov eax, yellow_emoji
        jmp end_switch
green_case:
        mov eax, green_emoji
        jmp end_switch
blue_case:
        mov eax, blue_emoji
        jmp end_switch
purple_case:
        mov eax, purple_emoji
        jmp end_switch
pink_case:
        mov eax, pink_emoji
        jmp end_switch
baby_blue_case:
        mov eax, baby_blue_emoji
        jmp end_switch
white_case:
        mov eax, white_emoji

end_switch:                             ; end of switch part of switch case
        pop ebp                         ; pop and restore the base pointer
        ret                             ; pop the return address and jump to it


