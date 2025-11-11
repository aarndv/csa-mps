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
    cls db 27, '[2J', 27, '[H'
    clsLen equ $ - cls

    menuTitle db "[ <-=-=- Main Menu -=-=-> ]", 10, 0
    menuTitleLen equ $ - menuTitle

    opt1 db "[1] Determine Zodiac", 10, 0
    opt1Len equ $ - opt1

    opt2 db "[2] Exit", 10, 0
    opt2Len equ $ - opt2

    promptChoice db "Enter your choice: ", 0
    promptChoiceLen equ $ - promptChoice

    tryAgainMsg db "Do you want to run the program again? (y/n): ", 0
    tryAgainMsgLen equ $ - tryAgainMsg

    invalidMsg db "Invalid choice. Please try again.", 10, 0
    invalidMsgLen equ $ - invalidMsg

    bdayPrompt db "Enter birthday (MM-DD-YYYY): ", 0
    bdayPromptLen equ $ - bdayPrompt

    msgDone db "Parsing complete!", 10, 0
    msgDoneLen equ $ - msgDone

    outputTxt db "You are an ", 0
    outputTxtLen equ $ - outputTxt

    savedTxt db "Output successfully saved in zodiac.txt. Check it out for more information about your zodiac sign!", 0
    savedTxtLen equ $ - savedTxt

    aries db "Aries", 0
    ariesLen equ $ - aries
    taurus db "Taurus", 0
    taurusLen equ $ - taurus
    gemini db "Gemini", 0
    geminiLen equ $ - gemini
    cancer db "Cancer", 0
    cancerLen equ $ - cancer
    leo db "Leo", 0
    leoLen equ $ - leo
    virgo db "Virgo", 0
    virgoLen equ $ - virgo
    libra db "Libra", 0
    libraLen equ $ - libra
    scorpio db "Scorpio", 0
    scorpioLen equ $ - scorpio
    sagittarius db "Sagittarius", 0
    sagittariusLen equ $ - sagittarius
    capricorn db "Capricorn", 0
    capricornLen equ $ - capricorn
    aquarius db "Aquarius", 0
    aquariusLen equ $ - aquarius
    pisces db "Pisces", 0
    piscesLen equ $ - pisces
    
    ; TODO: Separate the sentences into individual ones. At least 3
    ariesInfo db "Aries is the student who raises their hand first, even if they're not 100% sure of the answer. They're the competitive one who turns every group project into a race and will probably organize the study group (and the party afterward).", 0
    taurusInfo db "Taurus is the super-reliable study buddy who always has the best snacks. They'll work methodically on a project all night, but good luck trying to get them to change their thesis statement once they've decided on it. They definitely know the most comfortable study spot in the library.", 0
    geminiInfo db "Gemini is that student who seems to be in five different clubs and knows everyone on campus. They'll ace the class presentation with their charm and quick wit, but they probably started it an hour before class after changing their topic three times.", 0
    cancerInfo db "Cancer is the "parent" of the study group, always making sure everyone has eaten and is feeling okay before a big exam. They are super intuitive and just know which topics to focus on. They might get a little overwhelmed during finals week, so they appreciate a quiet, cozy study space.", 0
    leoInfo db "Leo is the student who volunteers to present the group project and probably ends up directing it, too. They have a flair for the dramatic and aren't afraid of the spotlight, making them a natural class leader. They're also surprisingly generous and will happily share their (brilliant) notes.Leo", 0
    virgoInfo db "Virgo is the student with the perfectly color-coded notes and a planner that's organized down to the minute. They're the one who asks the professor a question that clarifies the entire lesson for everyone. You absolutely want them to proofread your paper before you submit it.", 0
    libraInfo db "Libra is the diplomat of every group project, making sure everyone is getting along and the workload is fair. They have a natural charm that professors love, but they might spend more time debating which font to use than actually writing the paper.", 0
    scorpioInfo db "Scorpio is the focused, intense student who sits in the back and misses nothing. They are a research master who will dig up obscure facts for a term paper that impress the professor. Don't even bother asking for their grades; they're a well-kept secret.", 0
    sagittariusInfo db "Sagittarius is the student who asks the big, philosophical question that sends the whole lecture on an interesting tangent. They're always optimistic about passing finals, even if they "studied" by watching a documentary. They are the most likely to sign up for a study abroad program just for the adventure.", 0
    capricornInfo db "Capricorn is the student who already has a five-year career plan and an internship lined up in their first year. They're incredibly disciplined, always the last to leave the library, and will create a detailed spreadsheet for the group project. They aren't just here to pass; they're here to be top of the class.", 0
    aquariusInfo db "Aquarius is the student who comes up with a brilliantly original idea for the final project that no one else thought of. They're a bit of a "lone wolf" in their study habits but also the first to organize a campus-wide movement for a good cause. They're always thinking about the big picture, not just the test.", 0
    piscesInfo db "Pisces is the creative, day-dreamy student who connects the course material to art, music, or philosophy. They are incredibly empathetic and the best person to talk to if you're stressed about an exam. They might seem like they're not paying attention, but they're intuitively absorbing all the information.", 0

    ; TODO: Continue pasting the art
    ariesArt1 db " .-.   .-. ", 0
    ariesArt2 db "(_ \\ // _)", 0
    ariesArt3 db "    \|/    ", 0
    ariesArt4 db "     |     ", 0

    

    zodiacs dd aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces
    zodiacsLen db ariesLen, taurusLen, geminiLen, cancerLen, leoLen, virgoLen, libraLen, scorpioLen, sagittariusLen, capricornLen, aquariusLen, piscesLen

    newln db 10
    newlnLen equ $ - newln
    

section .bss
    bdayBuffer resb 32

    month resd 1
    day resd 1
    year resd 1

    menuChoice resb 2
    againChoice resb 2
    zodiacInt resb 1

section .text
    global _start

_start:
    call clearScreen

outerLoop:
    STDOUT menuTitle, menuTitleLen
    STDOUT opt1, opt1Len
    STDOUT opt2, opt2Len
    STDOUT promptChoice, promptChoiceLen
    
    STDIN menuChoice, 2

    cmp byte [menuChoice], '1'
    je handleZodiac

    cmp byte [menuChoice], '2'
    je exit

    STDOUT invalidMsg, invalidMsgLen
    jmp outerLoop

handleZodiac:
    GETINPUT bdayPrompt, bdayPromptLen, bdayBuffer
    call parseBirthday
    call determineZodiac
    call outputZodiac
    ;say the txt is saved in the file

    jmp askTryAgain

outputZodiac:
    STDOUT outputTxt, outputTxtLen
    movzx eax, byte [zodiacInt]
    dec eax

    mov ebx, eax
    movzx edx, byte [zodiacsLen + ebx] 

    shl eax, 2
    mov ecx, [zodiacs + eax]
    STDOUT ecx, edx
    STDOUT newln, newlnLen
    STDOUT newln, newlnLen

    ret
determineZodiac:
    movzx eax, byte [month]
    movzx ebx, byte [day]
    mov ecx, 0

    cmp eax, 1
    jne .checkFeb
    cmp ebx, 20
    jl .isCapricorn
    jmp .isAquarius
.checkFeb:
    cmp eax, 2
    jne .checkMar
    cmp ebx, 19
    jl .isAquarius
    jmp .isPisces
.checkMar:
    cmp eax, 3
    jne .checkApr
    cmp ebx, 21
    jl .isPisces
    jmp .isAries
.checkApr:
    cmp eax, 4
    jne .checkMay
    cmp ebx, 20
    jl .isAries
    jmp .isTaurus
.checkMay:
    cmp eax, 5
    jne .checkJun
    cmp ebx, 21
    jl .isTaurus
    jmp .isGemini
.checkJun:
    cmp eax, 6
    jne .checkJul
    cmp ebx, 22
    jl .isGemini
    jmp .isCancer
.checkJul:
    cmp eax, 7
    jne .checkAug
    cmp ebx, 23
    jl .isCancer
    jmp .isLeo
.checkAug:
    cmp eax, 8
    jne .checkSep
    cmp ebx, 23
    jl .isLeo
    jmp .isVirgo
.checkSep:
    cmp eax, 9
    jne .checkOct
    cmp ebx, 23
    jl .isVirgo
    jmp .isLibra
.checkOct:
    cmp eax, 10
    jne .checkNov
    cmp ebx, 24
    jl .isLibra
    jmp .isScorpio
.checkNov:
    cmp eax, 11
    jne .checkDec
    cmp ebx, 22
    jl .isScorpio
    jmp .isSagittarius
.checkDec:
    cmp eax, 12
    jne .storeResult
    cmp ebx, 22
    jl .isSagittarius
    jmp .isCapricorn
.isAries:
    mov ecx, 1
    jmp .storeResult
.isTaurus:
    mov ecx, 2
    jmp .storeResult
.isGemini:
    mov ecx, 3
    jmp .storeResult
.isCancer:
    mov ecx, 4
    jmp .storeResult
.isLeo:
    mov ecx, 5
    jmp .storeResult
.isVirgo:
    mov ecx, 6
    jmp .storeResult
.isLibra:
    mov ecx, 7
    jmp .storeResult
.isScorpio:
    mov ecx, 8
    jmp .storeResult
.isSagittarius:
    mov ecx, 9
    jmp .storeResult
.isCapricorn:
    mov ecx, 10
    jmp .storeResult
.isAquarius:
    mov ecx, 11
    jmp .storeResult
.isPisces:
    mov ecx, 12
    jmp .storeResult    
.storeResult:
    mov [zodiacInt], cl 
    ret
askTryAgain:
    STDOUT tryAgainMsg, tryAgainMsgLen
    STDIN againChoice, 2

    cmp byte [againChoice], 'y'
    je outerLoop

    cmp byte [againChoice], 'n'
    je exit 

    STDOUT invalidMsg, invalidMsgLen
    jmp askTryAgain

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

clearScreen:
    STDOUT cls, clsLen
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80