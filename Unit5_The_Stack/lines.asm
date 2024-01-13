; Original Author: Paul Carter
; Updated by: Megan Avery Summer 2023
; 
; Purpose: skeleton file for writing an assembly program

%include "asm_io.inc"

%define RED 0
%define ORANGE 1
%define YELLOW 2
%define GREEN 3
%define BLUE 4
%define PURPLE 5

%define NL 10

; initialized data
segment .data
; color_header db "\x1b[32mPick a color: ", 10, 0
color_header db "Choose a line color:", NL, 0  ; ANSI escape sequences for color
flag_chooser db "Choose 6 colors for your flag:", NL, 0

red db ") red ", NL, 0
orange db ") orange ", NL, 0
yellow db ") yellow ", NL, 0
green db ") green ", NL, 0
blue db ") blue ", NL, 0
purple db ") purple ", NL, 0
color_input db "Choice: ", 0

red_emoji db "🟥", 0
orange_emoji db "🟧", 0
yellow_emoji db "🟨", 0
green_emoji db "🟩", 0
blue_emoji db "🟦", 0
purple_emoji db "🟪", 0

; uninitialized data
segment .bss

segment .text
        global pick_color, draw_line, draw_flag

draw_flag:
        push ebp
        mov ebp, esp

        ; intentially left blank

        pop ebp
        ret

draw_line:
        push ebp
	mov ebp, esp

        mov eax, [ebp + 12]
        cmp eax, -1
        
        jne have_color_code
        call pick_color
        call print_nl

have_color_code:
        push eax
        call translate_color
        add esp, 4

        mov ecx, [ebp + 8]
draw_loop:
        call print_string

        loop draw_loop

        pop ebp
        ret

pick_color:
        push ebp
	mov ebp, esp

        mov eax, color_header
        call print_string

        mov eax, RED
        call print_int
        mov eax, red
        call print_string

        mov eax, ORANGE
        call print_int
        mov eax, orange
        call print_string

        mov eax, YELLOW
        call print_int
        mov eax, yellow
        call print_string

        mov eax, GREEN
        call print_int
        mov eax, green
        call print_string

        mov eax, BLUE
        call print_int
        mov eax, blue
        call print_string

        mov eax, PURPLE
        call print_int
        mov eax, purple
        call print_string

        mov eax, color_input
        call print_string

        call read_int

        pop ebp
        ret

translate_color:
        push ebp
	mov ebp, esp

        mov eax, [ebp + 8]

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

        jmp end_switch

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

end_switch:
        pop ebp
        ret


