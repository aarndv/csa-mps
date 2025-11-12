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

    bdayTxt db "Birthday: ", 0

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
    ariesInfo1       db "Aries is the student who raises their hand first, even if", 0
    ariesInfo2       db "they're not 100% sure of the answer. They're the competitive", 0
    ariesInfo3       db "one who turns every group project into a race and will", 0
    ariesInfo4       db "probably organize the study group (and the party afterwards)."

    taurusInfo1      db "Taurus is the super-reliable study buddy who always has the", 0
    taurusInfo2      db "best snacks. They'll work methodically on a project all night,", 0
    taurusInfo3      db "but good luck trying to get them to change their thesis state-", 0
    taurusInfo4      db "ment once they've decided on it. They definitely know the most", 0
    taurusInfo5      db "comfortable study spot in the library.", 0

    geminiInfo1      db "Gemini is that student who seems to be in five different clubs", 0
    geminiInfo2      db "and knows everyone on campus. They'll ace the class presentation", 0
    geminiInfo3      db "with their charm and quick wit, but they probably started it an", 0
    geminiInfo4      db "hour before class after changing their topic three times.", 0

    cancerInfo1      db "Cancer is the 'parent' of the study group, always making sure", 0
    cancerInfo2      db "everyone has eaten and is feeling okay before a big exam. They", 0
    cancerInfo3      db "are super intuitive and just know which topics to focus on. They", 0
    cancerInfo4      db "They might get a little overwhelmed during finals week, so they", 0
    cancerInfo5      db "appreciate a quiet, cozy study space.", 0

    leoInfo1         db "Leo is the student who volunteers to present the group project and", 0
    leoInfo2         db "probably ends up directing it, too. They have a flair for the", 0
    leoInfo3         db "dramatic and aren't afraid of the spotlight, making them a natural", 0
    leoInfo4         db "class leader. They're also surprisingly generous and will happily", 0
    leoInfo5         db "share their (brilliant) notes.", 0

    virgoInfo1       db "Virgo is the student with the perfectly color-coded notes and a", 0
    virgoInfo2       db "planner that's organized down to the minute. They're the one who", 0
    virgoInfo3       db "asks the professor a question that clarifies the entire lesson", 0
    virgoInfo4       db "for everyone. You absolutely want them to proofread your paper", 0
    virgoInfo5       db "before you sumbit it.", 0

    libraInfo1       db "Libra is the diplomat of every group project, making sure everyone", 0
    libraInfo2       db "is getting along and the workload is fair. They have a natural", 0
    libraInfo3       db "charm that professors love, but they might spend more time debating", 0
    libraInfo4       db "which font to use than actually writing the paper.", 0

    scorpioInfo1     db "Scorpio is the focused, intense student who sits in the back and", 0
    scorpioInfo2     db "misses nothing. They are a research master who will dig up obscure", 0
    scorpioInfo3     db "facts for a term paper that impress the professor. Don't even", 0
    scorpioInfo4     db "bother asking for their grades; they're a well-kept secret.", 0

    sagittariusInfo1 db "Sagittarius is the student who asks the big, philosophical question", 0
    sagittariusInfo2 db "that sends the whole lecture on an interesting tangent. They're", 0
    sagittariusInfo3 db "always optimistic about passing finals, even if they 'studied' by", 0
    sagittariusInfo4 db "watching a documentary. They are the most likely to sign up", 0
    sagittariusInfo5 db "for a study abroad program just for the adventure.", 0

    capricornInfo1   db "Capricorn is the student who already has a five-year career plan", 0
    capricornInfo2   db "and an internship lined up in their first year. They're incredibly", 0
    capricornInfo3   db "disciplined, always the last to leave the library, and will create", 0
    capricornInfo4   db "a detailed spreadsheet for the group project. They aren't", 0
    capricornInfo5   db "just here to pass; they're here to be top of the class.", 0

    aquariusInfo1    db "Aquarius is the student who comes up with a brilliantly original", 0
    aquariusInfo2    db "idea for the final project that no one else thought of. They're a", 0
    aquariusInfo3    db "bit of a 'lone wolf' in their study habits but also the first to", 0
    aquariusInfo4    db "organize a campus-wide movement for a good cause. They're always", 0
    aquariusInfo5    db "thinking about the big picture, not just the test.", 0

    piscesInfo1      db "Pisces is the creative, day-dreamy student who connects the course", 0
    piscesInfo1      db "material to art, music, or philosophy. They are incredibly empathe-", 0
    piscesInfo1      db "tic and the best person to talk to if you're stressed about an", 0
    piscesInfo1      db "exam. They might seem like they're not paying", 0
    piscesInfo1      db "attention, but they're intuitively absorbing all the information.", 0

    ; aries 
    ariesArt1 db " .-.   .-. ", 0
    ariesArt2 db "(_ \\ // _)", 0
    ariesArt3 db "    \|/    ", 0
    ariesArt4 db "     |     ", 0

    ; taurus
    taurusArt1 db ".-.       .-.", 0
    taurusArt2 db "  \.     ./  ", 0
    taurusArt3 db "    \___/    ", 0
    taurusArt4 db "   .'   '.   ", 0
    taurusArt5 db "  :       :  ", 0
    taurusArt6 db "  :       :  ", 0
    taurusArt7 db "   '.___.'   ", 0

    ; gemini
    geminiArt1 db "'--.__.--'", 0
    geminiArt2 db "    ||    ", 0
    geminiArt3 db "    ||    ", 0 
    geminiArt4 db "    ||    ", 0
    geminiArt5 db ".--'  '--.", 0

    ; cancer
    cancerArt1 db "  ..---.  ", 0
    cancerArt2 db "  //   _`.", 0
    cancerArt3 db " (*}  {*) ", 0
    cancerArt4 db "'.    //  ", 0
    cancerArt5 db "  `---''  ", 0

    ; leo
    leoArt1 db "  .-'-. ", 0
    leoArt2 db " (.   ')", 0
    leoArt3 db "(*)   / ", 0
    leoArt4 db " '   (' ", 0
    leoArt5 db "     '-.", 0

    ; virgo
    virgoArt1 db "' `:--.__.  ", 0
    virgoArt2 db "   |  |  ;_.", 0 
    virgoArt3 db "   (  (. ( )", 0 
    virgoArt4 db "   |  |  |/", 0 
    virgoArt5 db "   '  '  '  (J", 0 

    ; libra
    libraArt1 db "    _--_      ", 0
    libraArt2 db "   (    )   ", 0
    libraArt3 db "__/      \__", 0
    libraArt4 db "=====--=====", 0
    libraArt5 db "'`        `'", 0
    
    ; scorpio
    scorpioArt1 db "`:--.--.        ", 0 
    scorpioArt2 db " |  |  |        ", 0 
    scorpioArt3 db " |  |  |        ", 0 
    scorpioArt4 db " |  :  |\   ./\,", 0 
    scorpioArt5 db "         `==)|| ", 0 
    
    ; sagittarius
    sagittariusArt1 db "      --.", 0 
    sagittariusArt2 db "      .'|", 0
    sagittariusArt3 db "    .'   ", 0
    sagittariusArt4 db "`..'     ", 0 
    sagittariusArt5 db ".'`.     ", 0

    ; capricorn
    capricornArt1 db "        _  ", 0
    capricornArt2 db "\      /_) ", 0
    capricornArt3 db "|\    /\_  ", 0
    capricornArt4 db " \\  /   \;", 0
    capricornArt5 db "  \\/ -_.' ", 0

    ; aquarius
    aquariusArt1 db "   _   _   _   ", 0
    aquariusArt2 db "_./ \./ \./ \._", 0 
    aquariusArt3 db "'  .   .   .  '", 0
    aquariusArt4 db "_./ \./ \./ \._", 0
    aquariusArt5 db "'             '", 0

    ; pisces
    piscesArt1 db "`-.    .-'", 0
    piscesArt2 db "   :  :   ", 0
    piscesArt3 db " --:--:-- ", 0
    piscesArt4 db "   :  :   ", 0
    piscesArt5 db ".-'    `-.", 0

    zodiacs dd aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces
    zodiacsLen db ariesLen, taurusLen, geminiLen, cancerLen, leoLen, virgoLen, libraLen, scorpioLen, sagittariusLen, capricornLen, aquariusLen, piscesLen

    newln db 10
    newlnLen equ $ - newln
    

section .bss
    contentBuffer resb 4096
    contentLength resd 1
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
    call saveToFile
    STDOUT savedTxt, savedTxtLen


    jmp askTryAgain

saveToFile:
    mov eax, bdayTxt
    mov ebx, bdayBuffer
    call appendStringPair
    ret

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

appendString:
    mov edi, contentBuffer
    mov ecx, [contentLength]
    add edi, ecx
    mov esi, eax
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