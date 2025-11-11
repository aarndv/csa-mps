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

%macro FILEIN 3
    mov eax, 8
    mov ebx, %1
    mov ecx, 0777
    int 0x80

    mov ebx, eax
    mov eax, 4
    mov ecx, %2
    mov edx, [%3]
    int 0x80

    mov eax, 6
    int 0x80
%endmacro

%macro PRINTLN 2
    STDOUT %1, %2
    STDOUT newln, newln_len
%endmacro

%macro GETINPUT 3
    STDOUT %1, %2
    STDIN %3, RESERVE_BYTE_SIZE

    dec eax
    mov byte [%3 + eax], 0
%endmacro

section .data
    RESERVE_BYTE_SIZE equ 256

    bdayPrompt db "Enter birthday (MM-DD-YYYY): ", 0
    bdayPromptLen equ $ - bdayPrompt

    msgDone db "Parsing complete!", 10, 0
    msgDoneLen equ $ - msgDone

    msgMonth db "Month: ", 0
    msgMonthLen equ $ - msgMonth
    msgDay db "Day: ", 0
    msgDayLen equ $ - msgDay
    msgYear db "Year: ", 0
    msgYearLen equ $ - msgYear

    newln db 10
    newlnLen equ $ - newln
    

section .bss
    bdayBuffer resb 32

    month resd 1
    day resd 1
    year resd 1
    
    numBuffer resb 16

section .text
    global _start

_start:
    GETINPUT bdayPrompt, bdayPromptLen, bdayBuffer
    call parseBirthday

    ; Print Month
    STDOUT msgMonth, msgMonthLen
    mov eax, [month]        ; Load the number
    call printNumber
    STDOUT newln, newlnLen

    ; Print Day
    STDOUT msgDay, msgDayLen
    mov eax, [day]          ; Load the number
    call printNumber
    STDOUT newln, newlnLen

    ; Print Year
    STDOUT msgYear, msgYearLen
    mov eax, [year]         ; Load the number
    call printNumber
    STDOUT newln, newlnLen    
    STDOUT msgDone, msgDoneLen

    mov eax, 1
    xor ebx, ebx
    int 0x80

parseBirthday:
    mov esi, bdayBuffer
    xor ebx, ebx        ; EBX = number accumulator
    xor ecx, ecx        ; ECX = state (0=m, 1=d, 2=y)
.parseLoop:
    mov al, [esi]
    cmp al, 0
    je .parseDone

    cmp al, '-'
    je .foundDelimiter

    sub al, '0'
    movzx edx, al 

    mov eax, ebx
    push edx
    mov edx, 10
    mul edx
    pop edx

    add eax, edx
    mov ebx, eax

    inc esi
    jmp .parseLoop

.foundDelimiter:
    cmp ecx, 0
    je .saveMonth

    cmp ecx, 1
    je .saveDay
.saveMonth:
    mov [month], ebx
    inc ecx
    xor ebx, ebx
    inc esi
    jmp .parseLoop
.saveDay:
    mov [day], ebx
    inc ecx
    xor ebx, ebx
    inc esi
    jmp .parseLoop
.parseDone: 
    mov [year], ebx
    ret

printNumber:
    pusha

    mov edi, numBuffer + 15
    mov byte [edi], 0
    dec edi

    mov ebx, 10
    mov ecx, 0

    cmp eax, 0
    jne .conversionLoop

    mov byte [edi], '0'
    inc ecx
    jmp .print
.conversionLoop:
    xor edx, edx
    div ebx

    add dl, '0'

    mov [edi], dl
    dec edi
    inc ecx

    cmp eax, 0
    jne .conversionLoop

.print:
    inc edi
    mov eax, 4
    mov ebx, 1

    push ecx
    mov ecx, edi
    pop edx
    int 0x80

    popa
    ret