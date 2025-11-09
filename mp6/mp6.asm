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
    mov edx, %3
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
%endmacro

section .data
    RESERVE_BYTE_SIZE equ 256
    newln db 10 
    newln_len equ $ - newln
    cls db 27, '[2J', 27, '[H'
    clsLen equ $ - cls

    filename db "file.txt", 0

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

    whatIfText db "Next is your what ifs!", 10, 0
    whatIfTextLen equ $ - whatIfText
    powerPrompt db "What if you had a superpower. What would that be? ", 0
    powerPromptLen equ $ - powerPrompt
    timeTrvPrompt db "What if you could time travel. When would you go? ", 0
    timeTrvPromptLen equ $ - timeTrvPrompt
    meetAnyPrompt db "What if you could meet anyone. Who would that be? ", 0
    meetAnyPromptLen equ $ - meetAnyPrompt

    topThreeText db "Let's find out about your top 3's", 10, 0
    topThreeTextLen equ $ - topThreeText
    t3SongsPrompt db "Top 3 songs on repeat right now? ", 0
    t3SongsPromptLen equ $ - t3SongsPrompt
    t3ThingsPrompt db "Top 3 things you can't live without? ", 0
    t3ThingsPromptLen equ $ - t3ThingsPrompt
    t3CountriesPrompt db "Top 3 dream countries? ", 0
    t3CountriesPromptLen equ $ - t3CountriesPrompt

    ambitionsText db "Lastly, let's find out about your ambitions!", 10, 0
    ambitionsTextLen equ $ - ambitionsText
    dreamPrompt db "What is your dream? ", 0
    dreamPromptLen equ $ - dreamPrompt
    mottoPrompt db "What is your motto in life? ", 0
    mottoPromptLen equ $ - mottoPrompt

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
    power resb RESERVE_BYTE_SIZE
    timeTrv resb RESERVE_BYTE_SIZE
    meetAny resb RESERVE_BYTE_SIZE
    t3Songs resb RESERVE_BYTE_SIZE
    t3Things resb RESERVE_BYTE_SIZE
    t3Countries resb RESERVE_BYTE_SIZE
    dream resb RESERVE_BYTE_SIZE
    motto resb RESERVE_BYTE_SIZE

section .text
    global _start

_start:
    call promptInput

    mov dword [contentLength], 0

    call constructContent
    ; setup the input into one var 
    ; insert the input into a file
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
    PRINTLN whatIfText, whatIfTextLen
    GETINPUT powerPrompt, powerPromptLen, power
    GETINPUT timeTrvPrompt, timeTrvPromptLen, timeTrv
    GETINPUT meetAnyPrompt, meetAnyPromptLen, meetAny

    call clearScreen
    PRINTLN topThreeText, topThreeTextLen
    GETINPUT t3SongsPrompt, t3SongsPromptLen, t3Songs
    GETINPUT t3ThingsPrompt, t3ThingsPromptLen, t3Things
    GETINPUT t3CountriesPrompt, t3CountriesPromptLen, t3Countries

    call clearScreen
    PRINTLN ambitionsText, ambitionsTextLen
    GETINPUT dreamPrompt, dreamPromptLen, dream
    GETINPUT mottoPrompt, mottoPromptLen, motto

    ret
appendString:
    pusha 
    mov edi, contentBuffer
    mov ecx, [contentLength]
    add edi, ecx
    mov esi, eax                ;eax holds the pointer for the input string

copyLoop:
    mov al, [esi]
    cmp al, 0
    je doneCopying

    mov [edi], al
    inc edi
    inc esi
    inc dword [contentLength]
    jmp copyLoop

doneCopying:
    mov al, [newln] 
    mov [edi], al
    inc dword [contentLength] 

    popa
    ret
constructContent:
    mov eax,

    ret

clearScreen:
    STDOUT cls, clsLen
    ret
    
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
