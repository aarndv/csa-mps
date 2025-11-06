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

%macro GET_ANSWER 4
    STDOUT %1, %2 
    STDIN %3, %4
%endmacro 

section .data
    num_questions equ 9

    answer_key db "b", "a", "b", "b", "a", "c", "b", "b", "a"

    correct db "Correct!", 10, 0
    correct_len equ $ - correct
    incorrect db "Incorrect!", 10, 0
    incorrect_len equ $ - incorrect
    finalscore db "Final score: ", 0
    finalscore_len equ $ - finalscore

    q1 db "Q1) What is the capital of France?", 10, "    a) Berlin", 10, "    b) Paris", 10, "    c) Madrid", 10, 0
    q1_len equ $ - q1
    q2 db "Q2) Which planet is known as the Red Planet?", 10, "    a) Mars", 10, "    b) Venus", 10, "    c) Jupiter", 10, 0
    q2_len equ $ - q2
    q3 db "Q3) What do plants need for photosynthesis?", 10, "    a) Oxygen", 10, "    b) Carbon dioxide", 10, "    c) Nitrogen", 10, 0
    q3_len equ $ - q3
    q4 db "Q4) Which animal is known as the king of the jungle?", 10, "    a) Elepanth", 10, "    b) Lion", 10, "    c) Tiger", 10, 0
    q4_len equ $ - q4
    q5 db "Q5) What shrinks when it's old and tall when it's young?", 10, "    a) Candle", 10, "    b) Person", 10, "    c) Coyote", 10, 0
    q5_len equ $ - q5
    q6 db "Q6) Which ocean is the largest?", 10, "    a) Atlantic Ocean", 10, "    b) Indian Ocean", 10, "    c) Pacific Ocean", 10, 0
    q6_len equ $ - q6
    q7 db "Q7) What gas do humans breathe in to survive?", 10, "    a) Carbon dioxide", 10, "    b) Oxygen", 10, "    c) Hydrogen", 10,0 
    q7_len equ $ - q7
    q8 db "Q8) Which shape has three sides?", 10, "    a) Square", 10, "    b) Triangle", 10, "    c) Circle", 10, 0
    q8_len equ $ - q8
    q9 db "Q9) What color do you get when you mix red and blue?", 10, "    a) Purple", 10, "    b) Green", 10, "    c) Orange", 10, 0
    q9_len equ $ - q9

    q_list dd q1, q2, q3, q4, q5, q6, q7, q8, q9 
    q_len_list dd q1_len, q2_len, q3_len, q4_len, q5_len, q6_len, q7_len, q8_len, q9_len

    select_answer db "Select (a/b/c): ", 0
    select_answer_len equ $ - select_answer 

    newln db 10
    newln_len equ $ - newln
    
    score db 0

    r1 db "Rank: Quiz master - flawless victory!"
    r1_len equ $ - r1
    r2 db "Rank: Skilled scholar - strong command!"
    r2_len equ $ - r2
    r3 db "Rank: Beginner braniac - progress unlocked!"
    r3_len equ $ - r3
    r4 db "Rank: Noob explorer - keep practicing!"
    r4_len equ $ - r4

section .bss
    answer_buf resb 1

section .text
    global _start
_start:
    call program_loop
    call exit

program_loop:
    mov ecx, num_questions   
    mov edi, q_list         
    mov esi, q_len_list     
    call question_loop

    STDOUT newln, newln_len
    STDOUT finalscore, finalscore_len
    call display_score  
    ret

question_loop:
    push ecx

    mov edx, [esi] 
    mov ecx, [edi]
    STDOUT ecx, edx

    STDOUT select_answer, select_answer_len
    STDIN answer_buf, 2

    pop ecx
    call check_answer

    sub ecx, 1
    add esi, 4
    add edi, 4

    cmp ecx, 0

    pusha
    STDOUT newln, newln_len
    popa

    jne question_loop

    ret
check_answer:
    mov eax, num_questions
    sub eax, ecx
    movzx edx, byte [answer_key + eax] 
    push ecx

    movzx ebx, byte [answer_buf]
    cmp bl, dl 
    jne wrong_answer

    STDOUT correct, correct_len
    inc byte [score]

    pop ecx
    ret

wrong_answer:
    STDOUT incorrect, incorrect_len

    pop ecx
    ret
display_score:
    call calculate_rank
    mov eax, [score]
    add eax, '0'
    mov [score], eax
    STDOUT score, 1
    STDOUT newln, newln_len
    STDOUT edi, esi
    ret
calculate_rank:
    cmp [score], byte 9
    jge quiz_master
    cmp [score], byte 6
    jge skilled_scholar
    cmp [score], byte 3
    jge beginner_brainiac
    jmp noob_explorer
    ret
quiz_master:
    mov edi, r1
    mov esi, r1_len
    ret
skilled_scholar:
    mov edi, r2
    mov esi, r2_len
    ret
beginner_brainiac:
    mov edi, r3
    mov esi, r3_len
    ret
noob_explorer:
    mov edi, r4
    mov esi, r4_len
    ret
exit:       
    mov eax, 1 
    xor ebx, ebx
    int 0x80