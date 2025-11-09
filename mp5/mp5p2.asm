%macro STDOUT 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro STDIN 2
    mov eax, 3
    xor ebx, ebx
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

section .data
    h1 db "Module 4 Cosmic Console - daily horoscope sampler", 10, 0
    h1_len equ $ - h1
    h2 db "Pick a number between 1 and 9 (or q to exit) to reveal a vibe.", 10, 0
    h2_len equ $ - h2
    h3 db "Choose one of the nine cosmic archetypes:", 10, 0
    h3_len equ $ - h3

    c1 db "  (1) Solstice Spark", 10, 0
    c1_len equ $ - c1 
    c2 db "  (2) Lunar Listener", 10, 0
    c2_len equ $ - c2 
    c3 db "  (3) Tidal Dreamer", 10, 0
    c3_len equ $ - c3 
    c4 db "  (4) Terra Builder", 10, 0
    c4_len equ $ - c4 
    c5 db "  (5) Sky Trailblazer", 10, 0
    c5_len equ $ - c5 
    c6 db "  (6) Ember Guardian", 10, 0
    c6_len equ $ - c6 
    c7 db "  (7) Zephyr Inventor", 10, 0
    c7_len equ $ - c7 
    c8 db "  (8) Thunder Visionary", 10, 0
    c8_len equ $ - c8 
    c9 db "  (9) Starlit Sage", 10, 0
    c9_len equ $ - c9

    input_text db "Enter 1-9 for a reading, or q to exit: "
    input_text_len equ $ - input_text

    invalid_text db "Invalid input."
    invalid_text_len equ $ - invalid_text

    o1 db "Solstice Spark: Action planets align around you today.", 10, "Lead with courage; even small launches can light the way.", 10, 0
    o1_len equ $ - o1
    o2 db "Lunar Listener: Gentle tides bring intuitive clarity.", 10, "Lean into quiet check-ins before making big moves.", 10, 0
    o2_len equ $ - o2
    o3 db "Tidal Dreamer: Creativity swells like a new moon tide.", 10, "Sketch ideas quickly so they do not drift away.", 10, 0
    o3_len equ $ - o3
    o4 db "Terra Builder: Grounded focus restores your momentum.", 10, "Stack progress with routines that feel sustainable", 10, 0
    o4_len equ $ - o4
    o5 db "Sky Trailblazer: Horizons widen; scout the next adventure.", 10, "Share your findings - collaboration amplifies sparks. ", 10, 0
    o5_len equ $ - o5
    o6 db "Ember Guardian: Warm resilience keeps team supported.", 10, "Protect downtime so the fire in you keeps glowing.", 10, 0
    o6_len equ $ - o6
    o7 db "Zephyr Inventor: A breeze of insight swirls around obstacles.", 10, "Prototype boldly and iterate with playful curiosity.", 10, 0
    o7_len equ $ - o7
    o8 db "Thunder Visionary: Momentum rolls like distant thunder.", 10, "Announce your plans clearly; others are ready to rally.", 10, 0
    o8_len equ $ - o8
    o9 db "Starlit Sage: Wisdom settles in patterns you recognize.", 10, "Archive lessons learned and mentor a fellow traveler.", 10, 0
    o9_len equ $ - o9

    newln db 10
    newln_len equ $ - newln

    loop_prompt db "Would you like for another reading? (y/n): ", 0
    loop_prompt_len equ $ - loop_prompt

section .bss
    answer_buf resb 1

section .text
    global _start
_start:
    call headers
    call choices
    call getInput
    call getOutput
    call triggerLoop
    call exit

headers:
    STDOUT h1, h1_len
    STDOUT h2, h2_len
    STDOUT newln, newln_len
    STDOUT h3, h3_len
    ret
choices:
    STDOUT c1, c1_len
    STDOUT c2, c2_len
    STDOUT c3, c3_len
    STDOUT c4, c4_len
    STDOUT c5, c5_len
    STDOUT c6, c6_len
    STDOUT c7, c7_len
    STDOUT c8, c8_len
    STDOUT c9, c9_len
    STDOUT newln, newln_len
    ret
getInput:
    STDOUT input_text, input_text_len
    STDIN answer_buf, 2
    STDOUT newln, newln_len
    ret
getOutput:
    cmp [answer_buf], byte '1'
    je ch1
    cmp [answer_buf], byte '2'
    je ch2
    cmp [answer_buf], byte '3'
    je ch3
    cmp [answer_buf], byte '4'
    je ch4
    cmp [answer_buf], byte '5'
    je ch5
    cmp [answer_buf], byte '6'
    je ch6
    cmp [answer_buf], byte '7'
    je ch7
    cmp [answer_buf], byte '8'
    je ch8
    cmp [answer_buf], byte '9'
    je ch9
    cmp [answer_buf], byte 'q'
    je exit

    mov edi, invalid_text
    mov esi, invalid_text_len

displayText:
    STDOUT edi, esi
    STDOUT newln, newln_len
    ret
ch1:
    mov edi, o1
    mov esi, o1_len
    jmp displayText
ch2:
    mov edi, o2
    mov esi, o2_len
    jmp displayText
ch3:
    mov edi, o3
    mov esi, o3_len
    jmp displayText
ch4:
    mov edi, o4
    mov esi, o4_len
    jmp displayText
ch5:
    mov edi, o5
    mov esi, o5_len
    jmp displayText
ch6:
    mov edi, o6
    mov esi, o6_len
    jmp displayText
ch7:
    mov edi, o7
    mov esi, o7_len
    jmp displayText
ch8:
    mov edi, o8
    mov esi, o8_len
    jmp displayText
ch9:
    mov edi, o9
    mov esi, o9_len
    jmp displayText
triggerLoop:
    STDOUT loop_prompt, loop_prompt_len
    STDIN answer_buf, 2
    cmp [answer_buf], byte 'n'
    je exit
    jmp _start
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80