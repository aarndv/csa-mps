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
    newln db 10 
    newln_len equ $ - newln
    cls db 27, '[2J', 27, '[H'
    clsLen equ $ - cls

    newln2 db 10, 0

    filename db "mp6.txt", 0

    detailsText db "Let's get your details!", 10, 0
    detailsTextLen equ $ - detailsText
    namePrompt db "What's your name? ", 0
    namePromptLen equ $ - namePrompt
    emailPrompt db "Enter your email? ", 0
    emailPromptLen equ $ - emailPrompt
    agePrompt db "How old are you? ", 0
    agePromptLen equ $ - agePrompt

    firstsText db "Let's move on to your firsts!", 10, 0
    firstsTextLen equ $ - firstsText
    riskPrompt db "First risk you ever took? ", 0
    riskPromptLen equ $ - riskPrompt
    happyPrompt db "Last time you felt completely happy? ", 0
    happyPromptLen equ $ - happyPrompt

    favesText db "Let's move on towards your favorites!", 10, 0
    favesTextLen equ $ - favesText
    colorPrompt db "Favorite color? ", 0
    colorPromptLen equ $ - colorPrompt
    genrePrompt db "Favorite music genre? ", 0
    genrePromptLen equ $ - genrePrompt
    bandPrompt db "Favorite band? ", 0
    bandPromptLen equ $ - bandPrompt
    songPrompt db "Favorite song? ", 0
    songPromptLen equ $ - songPrompt
    foodPrompt db "Favorite food? ", 0
    foodPromptLen equ $ - foodPrompt
    drinkPrompt db "Favorite drink? ", 0
    drinkPromptLen equ $ - drinkPrompt

    hobbiesText db "Let's get to know your hobbies!", 10, 0
    hobbiesTextLen equ $ - hobbiesText
    actPrompt db "What's your go-to activity? ", 0
    actPromptLen equ $ - actPrompt
    gamePrompt db "What's your go-to game? ", 0
    gamePromptLen equ $ - gamePrompt
    bookPrompt db "What's your go-to book? ", 0
    bookPromptLen equ $ - bookPrompt
    showPrompt db "What's your go-to show? ", 0
    showPromptLen equ $ - showPrompt
    moviePrompt db "What's your go-to movie? ", 0
    moviePromptLen equ $ - moviePrompt
    placePrompt db "What's your go-to place? ", 0
    placePromptLen equ $ - placePrompt

    ambitionsText db "Lastly, let's find out about your ambitions!", 10, 0
    ambitionsTextLen equ $ - ambitionsText
    dreamPrompt db "What is your dream? ", 0
    dreamPromptLen equ $ - dreamPrompt
    mottoPrompt db "What is your motto in life? ", 0
    mottoPromptLen equ $ - mottoPrompt
    
    details db " [ -- DETAILS -- ] ", 0
    firsts db " [ -- FIRSTS! -- ] ", 0
    faves db " [ -- FAVORITES! -- ] ", 0
    hobbies db " [ -- HOBBIES -- ] ", 0
    ambitions db " [ -- AMBITIONS -- ] ", 0

    nameAns db " (*)  Name: ", 0
    emailAns db " (*)  Email: ", 0
    ageAns db " (*)  Age: ", 0
    riskAns db " (*)  First risk you ever took? ", 0
    happyAns db " (*)  Last time you felt happy? ", 0
    colorAns db " (*)  Color: ", 0
    colorAnsLen equ $ - colorAns
    genreAns db " (*)  Music Genre: ", 0
    genreAnsLen equ $ - genreAns
    bandAns db " (*)  Band: ", 0
    bandAnsLen equ $ - bandAns
    songAns db " (*)  Song: ", 0
    songAnsLen equ $ - songAns
    foodAns db " (*)  Food: ", 0
    foodAnsLen equ $ - foodAns
    drinkAns db " (*)  Drink: ", 0
    drinkAnsLen equ $ - drinkAns
    actAns db " (*)  Activity: ", 0
    actAnsLen equ $ - actAns
    gameAns db " (*)  Game: ", 0
    gameAnsLen equ $ - gameAns
    bookAns db " (*)  Book: ", 0
    bookAnsLen equ $ - bookAns
    showAns db " (*)  Show: ", 0
    showAnsLen equ $ - showAns
    movieAns db " (*)  Movie: ", 0
    movieAnsLen equ $ - movieAns
    placeAns db " (*)  Place: ", 0
    placeAnsLen equ $ - placeAns
    dreamAns db " (*)  Dream: ", 0
    dreamAnsLen equ $ - dreamAns
    mottoAns db " (*)  Motto: ", 0
    mottoAnsLen equ $ - mottoAns

section .bss
    contentBuffer resb 2048
    contentLength resd 1
    
    name resb RESERVE_BYTE_SIZE
    email resb RESERVE_BYTE_SIZE
    age resb RESERVE_BYTE_SIZE
    risk resb RESERVE_BYTE_SIZE
    happy resb RESERVE_BYTE_SIZE
    color resb RESERVE_BYTE_SIZE
    genre resb RESERVE_BYTE_SIZE
    band resb RESERVE_BYTE_SIZE
    song resb RESERVE_BYTE_SIZE
    food resb RESERVE_BYTE_SIZE
    drink resb RESERVE_BYTE_SIZE
    act  resb RESERVE_BYTE_SIZE
    game resb RESERVE_BYTE_SIZE
    book resb RESERVE_BYTE_SIZE
    show resb RESERVE_BYTE_SIZE
    movie resb RESERVE_BYTE_SIZE
    place resb RESERVE_BYTE_SIZE
    dream resb RESERVE_BYTE_SIZE
    motto resb RESERVE_BYTE_SIZE

section .text
    global _start

_start:
    call promptInput
    mov dword [contentLength], 0
    call constructContent
    FILEIN filename, contentBuffer, contentLength
    call exit

promptInput:
    call clearScreen
    PRINTLN detailsText, detailsTextLen
    GETINPUT namePrompt, namePromptLen, name
    GETINPUT emailPrompt, emailPromptLen, email
    GETINPUT agePrompt, agePromptLen, age

    call clearScreen
    PRINTLN firstsText, firstsTextLen
    GETINPUT riskPrompt, riskPromptLen, risk
    GETINPUT happyPrompt, happyPromptLen, happy

    call clearScreen
    PRINTLN favesText, favesTextLen
    GETINPUT colorPrompt, colorPromptLen, color
    GETINPUT genrePrompt, genrePromptLen, genre
    GETINPUT bandPrompt, bandPromptLen, band
    GETINPUT songPrompt, songPromptLen, song
    GETINPUT foodPrompt, foodPromptLen, food
    GETINPUT drinkPrompt, drinkPromptLen, drink

    call clearScreen
    PRINTLN hobbiesText, hobbiesTextLen
    GETINPUT actPrompt, actPromptLen, act
    GETINPUT gamePrompt, gamePromptLen, game
    GETINPUT bookPrompt, bookPromptLen, book
    GETINPUT showPrompt, showPromptLen, show
    GETINPUT moviePrompt, moviePromptLen, movie
    GETINPUT placePrompt, placePromptLen, place

    call clearScreen
    PRINTLN ambitionsText, ambitionsTextLen
    GETINPUT dreamPrompt, dreamPromptLen, dream
    GETINPUT mottoPrompt, mottoPromptLen, motto

    ret
constructContent:
    mov eax, details
    call appendString

    mov eax, nameAns
    mov ebx, name
    call appendStringPair

    mov eax, emailAns
    mov ebx, email
    call appendStringPair

    mov eax, ageAns
    mov ebx, age
    call appendStringPair

    mov eax, newln2
    call appendString

    mov eax, firsts
    call appendString

    mov eax, riskAns
    mov ebx, risk
    call appendStringPair

    mov eax, happyAns
    mov ebx, happy
    call appendStringPair

    mov eax, newln2
    call appendString

    mov eax, faves
    call appendString

    mov eax, colorAns
    mov ebx, color
    call appendStringPair

    mov eax, genreAns
    mov ebx, genre
    call appendStringPair

    mov eax, bandAns
    mov ebx, band
    call appendStringPair

    mov eax, songAns
    mov ebx, song
    call appendStringPair

    mov eax, foodAns
    mov ebx, food
    call appendStringPair

    mov eax, drinkAns
    mov ebx, drink
    call appendStringPair

    mov eax, newln2
    call appendString

    mov eax, hobbies
    call appendString

    mov eax, actAns
    mov ebx, act
    call appendStringPair

    mov eax, gameAns
    mov ebx, game
    call appendStringPair

    mov eax, bookAns
    mov ebx, book
    call appendStringPair

    mov eax, showAns
    mov ebx, show
    call appendStringPair

    mov eax, movieAns
    mov ebx, movie
    call appendStringPair

    mov eax, placeAns
    mov ebx, place
    call appendStringPair

    mov eax, newln2
    call appendString

    mov eax, ambitions
    call appendString

    mov eax, dreamAns
    mov ebx, dream
    call appendStringPair

    mov eax, mottoAns
    mov ebx, motto
    call appendStringPair

    ret
appendString:
    mov edi, contentBuffer
    mov ecx, [contentLength]
    add edi, ecx
    mov esi, eax                ;eax holds the pointer for the input string
.copyLoop:
    mov al, [esi]
    cmp al, 0
    je .doneCopying

    mov [edi], al
    inc edi
    inc esi
    inc ecx
    jmp .copyLoop
.doneCopying:
    mov al, [newln] 
    mov [edi], al
    inc ecx

    mov [contentLength], ecx
    ret
    
appendStringPair:
    mov edi, contentBuffer
    mov ecx, [contentLength]
    add edi, ecx
    mov esi, eax
.copyFirst:
    mov al, [esi]
    cmp al, 0
    je .copySecond

    mov [edi], al
    inc edi
    inc esi
    inc ecx
    jmp .copyFirst
.copySecond:
    mov esi, ebx
.copySecondLoop:
    mov al, [esi]
    cmp al, 0
    je .doneBoth

    mov [edi], al
    inc edi
    inc esi
    inc ecx
    jmp .copySecondLoop
.doneBoth:
    mov al, [newln]
    mov [edi], al
    inc ecx

    mov [contentLength], ecx
    ret

clearScreen:
    STDOUT cls, clsLen
    ret
    
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
