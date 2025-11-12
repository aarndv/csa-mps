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

    outputTxt db "Your zodiac sign is: ", 0
    outputTxtLen equ $ - outputTxt

    savedTxt db "Output successfully saved in zodiac.txt. Check it out for more information about your zodiac sign!", 10, 0
    savedTxtLen equ $ - savedTxt

    bdayTxt db "Birthday: ", 0
    bdayTxtLen equ $ - bdayTxt

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
    ariesInfo1Len equ $ - ariesInfo1
    ariesInfo2       db "they're not 100% sure of the answer. They're the competitive", 0
    ariesInfo2Len equ $ - ariesInfo2
    ariesInfo3       db "one who turns every group project into a race and will", 0
    ariesInfo3Len equ $ - ariesInfo3
    ariesInfo4       db "probably organize the study group (and the party afterwards)."
    ariesInfo4Len equ $ - ariesInfo4

    taurusInfo1      db "Taurus is the super-reliable study buddy who always has the", 0
    taurusInfo1Len equ $ - taurusInfo1Len 
    taurusInfo2      db "best snacks. They'll work methodically on a project all night,", 0
    taurusInfo2Len equ $ - taurusInfo2Len 
    taurusInfo3      db "but good luck trying to get them to change their thesis state-", 0
    taurusInfo3Len equ $ - taurusInfo3Len 
    taurusInfo4      db "ment once they've decided on it. They definitely know the most", 0
    taurusInfo4Len equ $ - taurusInfo4Len 
    taurusInfo5      db "comfortable study spot in the library.", 0
    taurusInfo5Len equ $ - taurusInfo5Len 

    geminiInfo1      db "Gemini is that student who seems to be in five different clubs", 0
    geminiInfo1Len equ $ - geminiInfo1
    geminiInfo2      db "and knows everyone on campus. They'll ace the class presentation", 0
    geminiInfo2Len equ $ - geminiInfo2
    geminiInfo3      db "with their charm and quick wit, but they probably started it an", 0
    geminiInfo3Len equ $ - geminiInfo3
    geminiInfo4      db "hour before class after changing their topic three times.", 0
    geminiInfo4Len equ $ - geminiInfo4

    cancerInfo1      db "Cancer is the 'parent' of the study group, always making sure", 0
    cancerInfo1Len equ $ - cancerInfo1
    cancerInfo2      db "everyone has eaten and is feeling okay before a big exam. They", 0
    cancerInfo2Len equ $ - cancerInfo2
    cancerInfo3      db "are super intuitive and just know which topics to focus on. They", 0
    cancerInfo3Len equ $ - cancerInfo3
    cancerInfo4      db "They might get a little overwhelmed during finals week, so they", 0
    cancerInfo4Len equ $ - cancerInfo4
    cancerInfo5      db "appreciate a quiet, cozy study space.", 0
    cancerInfo5Len equ $ - cancerInfo5

    leoInfo1         db "Leo is the student who volunteers to present the group project and", 0
    leoInfo1Len equ $ - leoInfo1
    leoInfo2         db "probably ends up directing it, too. They have a flair for the", 0
    leoInfo2Len equ $ - leoInfo2
    leoInfo3         db "dramatic and aren't afraid of the spotlight, making them a natural", 0
    leoInfo3Len equ $ - leoInfo3
    leoInfo4         db "class leader. They're also surprisingly generous and will happily", 0
    leoInfo4Len equ $ - leoInfo4
    leoInfo5         db "share their (brilliant) notes.", 0
    leoInfo5Len equ $ - leoInfo5

    virgoInfo1       db "Virgo is the student with the perfectly color-coded notes and a", 0
    virgoInfo1Len equ $ - virgoInfo1
    virgoInfo2       db "planner that's organized down to the minute. They're the one who", 0
    virgoInfo2Len equ $ - virgoInfo2
    virgoInfo3       db "asks the professor a question that clarifies the entire lesson", 0
    virgoInfo3Len equ $ - virgoInfo3
    virgoInfo4       db "for everyone. You absolutely want them to proofread your paper", 0
    virgoInfo4Len equ $ - virgoInfo4
    virgoInfo5       db "before you sumbit it.", 0
    virgoInfo5Len equ $ - virgoInfo5

    libraInfo1       db "Libra is the diplomat of every group project, making sure everyone", 0
    LibraInfo1Len equ $ - LibraInfo1
    libraInfo2       db "is getting along and the workload is fair. They have a natural", 0
    1ibraInfo2Len equ $ - LibraInfo2
    libraInfo3       db "charm that professors love, but they might spend more time debating", 0
    LibraInfo3Len equ $ - LibraInfo3
    libraInfo4       db "which font to use than actually writing the paper.", 0
    LibraInfo4Len equ $ - LibraInfo4

    scorpioInfo1     db "Scorpio is the focused, intense student who sits in the back and", 0
    scorpioInfo1Len equ $ - scorpioInfo1
    scorpioInfo2     db "misses nothing. They are a research master who will dig up obscure", 0
    scorpioInfo2Len equ $ - scorpioInfo2
    scorpioInfo3     db "facts for a term paper that impress the professor. Don't even", 0
    scorpioInfo3Len equ $ - scorpioInfo3
    scorpioInfo4     db "bother asking for their grades; they're a well-kept secret.", 0
    scorpioInfo4Len equ $ - scorpioInfo4

    sagittariusInfo1 db "Sagittarius is the student who asks the big, philosophical question", 0
    sagittariusInfo1Len $ - sagittariusInfo1
    sagittariusInfo2 db "that sends the whole lecture on an interesting tangent. They're", 0
    sagittariusInfo2Len $ - sagittariusInfo2
    sagittariusInfo3 db "always optimistic about passing finals, even if they 'studied' by", 0
    sagittariusInfo3Len $ - sagittariusInfo3
    sagittariusInfo4 db "watching a documentary. They are the most likely to sign up", 0
    sagittariusInfo4Len $ - sagittariusInfo4
    sagittariusInfo5 db "for a study abroad program just for the adventure.", 0
    sagittariusInfo5Len $ - sagittariusInfo6

    capricornInfo1   db "Capricorn is the student who already has a five-year career plan", 0
    capricornInfo1Len equ $ - capricornInfo1
    capricornInfo2   db "and an internship lined up in their first year. They're incredibly", 0
    capricornInfo2Len equ $ - capricornInfo2
    capricornInfo3   db "disciplined, always the last to leave the library, and will create", 0
    capricornInfo3Len equ $ - capricornInfo3
    capricornInfo4   db "a detailed spreadsheet for the group project. They aren't", 0
    capricornInfo4Len equ $ - capricornInfo4
    capricornInfo5   db "just here to pass; they're here to be top of the class.", 0
    capricornInfo5Len equ $ - capricornInfo5

    aquariusInfo1    db "Aquarius is the student who comes up with a brilliantly original", 0
    aquariusInfo1Len equ $ - aquariusInfo1
    aquariusInfo2    db "idea for the final project that no one else thought of. They're a", 0
    aquariusInfo2Len equ $ - aquariusInfo2
    aquariusInfo3    db "bit of a 'lone wolf' in their study habits but also the first to", 0
    aquariusInfo3Len equ $ - aquariusInfo3
    aquariusInfo4    db "organize a campus-wide movement for a good cause. They're always", 0
    aquariusInfo4Len equ $ - aquariusInfo4
    aquariusInfo5    db "thinking about the big picture, not just the test.", 0
    aquariusInfo5Len equ $ - aquariusInfo5

    piscesInfo1      db "Pisces is the creative, day-dreamy student who connects the course", 0
    piscesInfo1Len equ $ - piscesInfo1
    piscesInfo2      db "material to art, music, or philosophy. They are incredibly empathe-", 0
    piscesInfo2Len equ $ - piscesInfo2
    piscesInfo3      db "tic and the best person to talk to if you're stressed about an", 0
    piscesInfo3Len equ $ - piscesInfo3
    piscesInfo4      db "exam. They might seem like they're not paying", 0
    piscesInfo4Len equ $ - piscesInfo4
    piscesInfo5      db "attention, but they're intuitively absorbing all the information.", 0
    piscesInfo5Len equ $ - piscesInfo5

    ; aries
    ariesArt1 db " .-.   .-. ", 0
    ariesArt1Len equ $ - ariesArt1
    ariesArt2 db "(_ \\ // _)", 0
    ariesArt2Len equ $ - ariesArt2
    ariesArt3 db "    \|/    ", 0
    ariesArt3Len equ $ - ariesArt3
    ariesArt4 db "     |     ", 0
    ariesArt4Len equ $ - ariesArt4

    ; taurus
    taurusArt1 db ".-.       .-.", 0
    taurusArt1Len equ $ - taurusArt1
    taurusArt2 db "  \.     ./  ", 0
    taurusArt2Len equ $ - taurusArt2
    taurusArt3 db "    \___/    ", 0
    taurusArt3Len equ $ - taurusArt3
    taurusArt4 db "   .'   '.   ", 0
    taurusArt4Len equ $ - taurusArt4
    taurusArt5 db "  :       :  ", 0
    taurusArt5Len equ $ - taurusArt5
    taurusArt6 db "  :       :  ", 0
    taurusArt6Len equ $ - taurusArt6
    taurusArt7 db "   '.___.'   ", 0
    taurusArt7Len equ $ - taurusArt7

    ; gemini
    geminiArt1 db "'--.__.--'", 0
    geminiArt1Len equ $ - geminiArt1
    geminiArt2 db "    ||    ", 0
    geminiArt2Len equ $ - geminiArt2
    geminiArt3 db "    ||    ", 0 
    geminiArt3Len equ $ - geminiArt3
    geminiArt4 db "    ||    ", 0
    geminiArt4Len equ $ - geminiArt4
    geminiArt5 db ".--'  '--.", 0
    geminiArt5Len equ $ - geminiArt5

    ; cancer
    cancerArt1 db "  ..---.  ", 0
    cancerArt1Len equ $ - cancerArt1
    cancerArt2 db "  //   _`.", 0
    cancerArt2Len equ $ - cancerArt2
    cancerArt3 db " (*}  {*) ", 0
    cancerArt3Len equ $ - cancerArt3
    cancerArt4 db "'.    //  ", 0
    cancerArt4Len equ $ - cancerArt4
    cancerArt5 db "  `---''  ", 0
    cancerArt5Len equ $ - cancerArt5

    ; leo
    leoArt1 db "  .-'-. ", 0
    leoArt1Len equ $ - leoArt1
    leoArt2 db " (.   ')", 0
    leoArt2Len equ $ - leoArt2
    leoArt3 db "(*)   / ", 0
    leoArt3Len equ $ - leoArt3
    leoArt4 db " '   (' ", 0
    leoArt4Len equ $ - leoArt4
    leoArt5 db "     '-.", 0
    leoArt5Len equ $ - leoArt5

    ; virgo
    virgoArt1 db "' `:--.__.  ", 0
    virgoArt1Len equ $ - virgoArt1
    virgoArt2 db "   |  |  ;_.", 0 
    virgoArt2Len equ $ - virgoArt2
    virgoArt3 db "   (  (. ( )", 0 
    virgoArt3Len equ $ - virgoArt3
    virgoArt4 db "   |  |  |/", 0 
    virgoArt4Len equ $ - virgoArt4
    virgoArt5 db "   '  '  '  (J", 0 
    virgoArt5Len equ $ - virgoArt5555

    ; libra
    libraArt1 db "    _--_    ", 0
    libraARt1Len equ $ - libraArt1
    libraArt2 db "   (    )   ", 0
    libraARt2Len equ $ - libraArt2
    libraArt3 db "__/      \__", 0
    libraARt3Len equ $ - libraArt3
    libraArt4 db "=====--=====", 0
    libraARt4Len equ $ - libraArt4
    libraArt5 db "'`        `'", 0
    libraARt5Len equ $ - libraArt5
    
    ; scorpio
    scorpioArt1 db "`:--.--.        ", 0 
    scorpioArt1Len equ $ - scorpioArt1 
    scorpioArt2 db " |  |  |        ", 0 
    scorpioArt2Len equ $ - scorpioArt2 
    scorpioArt3 db " |  |  |        ", 0 
    scorpioArt3Len equ $ - scorpioArt3 
    scorpioArt4 db " |  :  |\   ./\,", 0 
    scorpioArt4Len equ $ - scorpioArt4 
    scorpioArt5 db "         `==)|| ", 0 
    scorpioArt5Len equ $ - scorpioArt5 
    
    ; sagittarius
    sagittariusArt1 db "      --.", 0 
    sagittariusArt1Len equ $ - sagittariusArt1
    sagittariusArt2 db "      .'|", 0
    sagittariusArt2Len equ $ - sagittariusArt2
    sagittariusArt3 db "    .'   ", 0
    sagittariusArt3Len equ $ - sagittariusArt3
    sagittariusArt4 db "`..'     ", 0 
    sagittariusArt4Len equ $ - sagittariusArt4
    sagittariusArt5 db ".'`.     ", 0
    sagittariusArt5Len equ $ - sagittariusArt5

    ; capricorn
    capricornArt1 db "        _  ", 0
    capricornArt1Len equ $ - capricornArt1 
    capricornArt2 db "\      /_) ", 0
    capricornArt2Len equ $ - capricornArt2 
    capricornArt3 db "|\    /\_  ", 0
    capricornArt3Len equ $ - capricornArt3 
    capricornArt4 db " \\  /   \;", 0
    capricornArt4Len equ $ - capricornArt4 
    capricornArt5 db "  \\/ -_.' ", 0
    capricornArt5Len equ $ - capricornArt5 

    ; aquarius
    aquariusArt1 db "   _   _   _   ", 0
    aquariusArt1Len equ $ - aquariusArt1
    aquariusArt2 db "_./ \./ \./ \._", 0 
    aquariusArt2Len equ $ - aquariusArt2
    aquariusArt3 db "'  .   .   .  '", 0
    aquariusArt3Len equ $ - aquariusArt3
    aquariusArt4 db "_./ \./ \./ \._", 0
    aquariusArt4Len equ $ - aquariusArt4
    aquariusArt5 db "'             '", 0
    aquariusArt5Len equ $ - aquariusArt5

    ; pisces
    piscesArt1 db "`-.    .-'", 0
    piscesArt1Len equ $ - piscesArt1
    piscesArt2 db "   :  :   ", 0
    piscesArt2Len equ $ - piscesArt2
    piscesArt3 db " --:--:-- ", 0
    piscesArt3Len equ $ - piscesArt3
    piscesArt4 db "   :  :   ", 0
    piscesArt4Len equ $ - piscesArt4
    piscesArt5 db ".-'    `-.", 0
    piscesArt5Len equ $ - piscesArt5

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

    push eax
    mov ebx, eax
    movzx edx, byte [zodiacsLen + ebx] 

    shl eax, 2
    mov ecx, [zodiacs + eax]
    STDOUT ecx, edx
    STDOUT newln, newlnLen 
    STDOUT newln, newlnLen

    STDOUT bdayTxt, bdayTxtLen
    STDOUT bdayBuffer, 10 

    STDOUT newln, newlnLen
    STDOUT newln, newlnLen

    cmp eax, 0
    je .printAriesArt
    cmp eax, 1
    je .printTaurusArt
    cmp eax, 2
    je .printGeminiArt
    cmp eax, 3
    je .printCancerArt
    cmp eax, 4
    je .printLeoArt
    cmp eax, 5
    je .printVirgoArt
    cmp eax, 6
    je .printLibraArt
    cmp eax, 7
    je .printScorpioArt
    cmp eax, 8
    je .printSagittariusArt
    cmp eax, 9
    je .printCapricornArt
    cmp eax, 10
    je .printAquariusArt
    cmp eax, 11
    je .printPiscesArt
    jmp .doneArt            ; Jump to the end

.printAriesArt:
    STDOUT ariesArt1, $ - ariesArt1 - 1
    STDOUT newln, newlnLen
    STDOUT ariesArt2, $ - ariesArt2 - 1
    STDOUT newln, newlnLen
    STDOUT ariesArt3, $ - ariesArt3 - 1
    STDOUT newln, newlnLen
    STDOUT ariesArt4, $ - ariesArt4 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printTaurusArt:
    STDOUT taurusArt1, $ - taurusArt1 - 1
    STDOUT newln, newlnLen
    STDOUT taurusArt2, $ - taurusArt2 - 1
    STDOUT newln, newlnLen
    STDOUT taurusArt3, $ - taurusArt3 - 1
    STDOUT newln, newlnLen
    STDOUT taurusArt4, $ - taurusArt4 - 1
    STDOUT newln, newlnLen
    STDOUT taurusArt5, $ - taurusArt5 - 1
    STDOUT newln, newlnLen
    STDOUT taurusArt6, $ - taurusArt6 - 1
    STDOUT newln, newlnLen
    STDOUT taurusArt7, $ - taurusArt7 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printGeminiArt:
    STDOUT geminiArt1, $ - geminiArt1 - 1
    STDOUT newln, newlnLen
    STDOUT geminiArt2, $ - geminiArt2 - 1
    STDOUT newln, newlnLen
    STDOUT geminiArt3, $ - geminiArt3 - 1
    STDOUT newln, newlnLen
    STDOUT geminiArt4, $ - geminiArt4 - 1
    STDOUT newln, newlnLen
    STDOUT geminiArt5, $ - geminiArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printCancerArt:
    STDOUT cancerArt1, $ - cancerArt1 - 1
    STDOUT newln, newlnLen
    STDOUT cancerArt2, $ - cancerArt2 - 1
    STDOUT newln, newlnLen
    STDOUT cancerArt3, $ - cancerArt3 - 1
    STDOUT newln, newlnLen
    STDOUT cancerArt4, $ - cancerArt4 - 1
    STDOUT newln, newlnLen
    STDOUT cancerArt5, $ - cancerArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printLeoArt:
    STDOUT leoArt1, $ - leoArt1 - 1
    STDOUT newln, newlnLen
    STDOUT leoArt2, $ - leoArt2 - 1
    STDOUT newln, newlnLen
    STDOUT leoArt3, $ - leoArt3 - 1
    STDOUT newln, newlnLen
    STDOUT leoArt4, $ - leoArt4 - 1
    STDOUT newln, newlnLen
    STDOUT leoArt5, $ - leoArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printVirgoArt:
    STDOUT virgoArt1, $ - virgoArt1 - 1
    STDOUT newln, newlnLen
    STDOUT virgoArt2, $ - virgoArt2 - 1
    STDOUT newln, newlnLen
    STDOUT virgoArt3, $ - virgoArt3 - 1
    STDOUT newln, newlnLen
    STDOUT virgoArt4, $ - virgoArt4 - 1
    STDOUT newln, newlnLen
    STDOUT virgoArt5, $ - virgoArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printLibraArt:
    STDOUT libraArt1, $ - libraArt1 - 1
    STDOUT newln, newlnLen
    STDOUT libraArt2, $ - libraArt2 - 1
    STDOUT newln, newlnLen
    STDOUT libraArt3, $ - libraArt3 - 1
    STDOUT newln, newlnLen
    STDOUT libraArt4, $ - libraArt4 - 1
    STDOUT newln, newlnLen
    STDOUT libraArt5, $ - libraArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printScorpioArt:
    STDOUT scorpioArt1, $ - scorpioArt1 - 1
    STDOUT newln, newlnLen
    STDOUT scorpioArt2, $ - scorpioArt2 - 1
    STDOUT newln, newlnLen
    STDOUT scorpioArt3, $ - scorpioArt3 - 1
    STDOUT newln, newlnLen
    STDOUT scorpioArt4, $ - scorpioArt4 - 1
    STDOUT newln, newlnLen
    STDOUT scorpioArt5, $ - scorpioArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printSagittariusArt:
    STDOUT sagittariusArt1, $ - sagittariusArt1 - 1
    STDOUT newln, newlnLen
    STDOUT sagittariusArt2, $ - sagittariusArt2 - 1
    STDOUT newln, newlnLen
    STDOUT sagittariusArt3, $ - sagittariusArt3 - 1
    STDOUT newln, newlnLen
    STDOUT sagittariusArt4, $ - sagittariusArt4 - 1
    STDOUT newln, newlnLen
    STDOUT sagittariusArt5, $ - sagittariusArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printCapricornArt:
    STDOUT capricornArt1, $ - capricornArt1 - 1
    STDOUT newln, newlnLen
    STDOUT capricornArt2, $ - capricornArt2 - 1
    STDOUT newln, newlnLen
    STDOUT capricornArt3, $ - capricornArt3 - 1
    STDOUT newln, newlnLen
    STDOUT capricornArt4, $ - capricornArt4 - 1
    STDOUT newln, newlnLen
    STDOUT capricornArt5, $ - capricornArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printAquariusArt:
    STDOUT aquariusArt1, $ - aquariusArt1 - 1
    STDOUT newln, newlnLen
    STDOUT aquariusArt2, $ - aquariusArt2 - 1
    STDOUT newln, newlnLen
    STDOUT aquariusArt3, $ - aquariusArt3 - 1
    STDOUT newln, newlnLen
    STDOUT aquariusArt4, $ - aquariusArt4 - 1
    STDOUT newln, newlnLen
    STDOUT aquariusArt5, $ - aquariusArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.printPiscesArt:
    STDOUT piscesArt1, $ - piscesArt1 - 1
    STDOUT newln, newlnLen
    STDOUT piscesArt2, $ - piscesArt2 - 1
    STDOUT newln, newlnLen
    STDOUT piscesArt3, $ - piscesArt3 - 1
    STDOUT newln, newlnLen
    STDOUT piscesArt4, $ - piscesArt4 - 1
    STDOUT newln, newlnLen
    STDOUT piscesArt5, $ - piscesArt5 - 1
    STDOUT newln, newlnLen
    jmp .doneArt
.doneArt:
    pop eax                 ; Restore index (0-11)

    STDOUT newln, newlnLen
    STDOUT newln, newlnLen

    cmp eax, 0
    je .printAriesInfo
    cmp eax, 1
    je .printTaurusInfo
    cmp eax, 2
    je .printGeminiInfo
    cmp eax, 3
    je .printCancerInfo
    cmp eax, 4
    je .printLeoInfo
    cmp eax, 5
    je .printVirgoInfo
    cmp eax, 6
    je .printLibraInfo
    cmp eax, 7
    je .printScorpioInfo
    cmp eax, 8
    je .printSagittariusInfo
    cmp eax, 9
    je .printCapricornInfo
    cmp eax, 10
    je .printAquariusInfo
    cmp eax, 11
    je .printPiscesInfo
    jmp .doneInfo

.printAriesInfo:
    STDOUT ariesInfo1, $ - ariesInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT ariesInfo2, $ - ariesInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT ariesInfo3, $ - ariesInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT ariesInfo4, $ - ariesInfo4 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printTaurusInfo:
    STDOUT taurusInfo1, $ - taurusInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT taurusInfo2, $ - taurusInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT taurusInfo3, $ - taurusInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT taurusInfo4, $ - taurusInfo4 - 1
    STDOUT newln, newlnLen
    STDOUT taurusInfo5, $ - taurusInfo5 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printGeminiInfo:
    STDOUT geminiInfo1, $ - geminiInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT geminiInfo2, $ - geminiInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT geminiInfo3, $ - geminiInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT geminiInfo4, $ - geminiInfo4 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printCancerInfo:
    STDOUT cancerInfo1, $ - cancerInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT cancerInfo2, $ - cancerInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT cancerInfo3, $ - cancerInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT cancerInfo4, $ - cancerInfo4 - 1
    STDOUT newln, newlnLen
    STDOUT cancerInfo5, $ - cancerInfo5 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printLeoInfo:
    STDOUT leoInfo1, $ - leoInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT leoInfo2, $ - leoInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT leoInfo3, $ - leoInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT leoInfo4, $ - leoInfo4 - 1
    STDOUT newln, newlnLen
    STDOUT leoInfo5, $ - leoInfo5 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printVirgoInfo:
    STDOUT virgoInfo1, $ - virgoInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT virgoInfo2, $ - virgoInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT virgoInfo3, $ - virgoInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT virgoInfo4, $ - virgoInfo4 - 1
    STDOUT newln, newlnLen
    STDOUT virgoInfo5, $ - virgoInfo5 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printLibraInfo:
    STDOUT libraInfo1, $ - libraInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT libraInfo2, $ - libraInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT libraInfo3, $ - libraInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT libraInfo4, $ - libraInfo4 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printScorpioInfo:
    STDOUT scorpioInfo1, $ - scorpioInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT scorpioInfo2, $ - scorpioInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT scorpioInfo3, $ - scorpioInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT scorpioInfo4, $ - scorpioInfo4 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printSagittariusInfo:
    STDOUT sagittariusInfo1, $ - sagittariusInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT sagittariusInfo2, $ - sagittariusInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT sagittariusInfo3, $ - sagittariusInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT sagittariusInfo4, $ - sagittariusInfo4 - 1
    STDOUT newln, newlnLen
    STDOUT sagittariusInfo5, $ - sagittariusInfo5 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printCapricornInfo:
    STDOUT capricornInfo1, $ - capricornInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT capricornInfo2, $ - capricornInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT capricornInfo3, $ - capricornInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT capricornInfo4, $ - capricornInfo4 - 1
    STDOUT newln, newlnLen
    STDOUT capricornInfo5, $ - capricornInfo5 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printAquariusInfo:
    STDOUT aquariusInfo1, $ - aquariusInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT aquariusInfo2, $ - aquariusInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT aquariusInfo3, $ - aquariusInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT aquariusInfo4, $ - aquariusInfo4 - 1
    STDOUT newln, newlnLen
    STDOUT aquariusInfo5, $ - aquariusInfo5 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.printPiscesInfo:
    STDOUT piscesInfo1, $ - piscesInfo1 - 1
    STDOUT newln, newlnLen
    STDOUT piscesInfo2, $ - piscesInfo2 - 1
    STDOUT newln, newlnLen
    STDOUT piscesInfo3, $ - piscesInfo3 - 1
    STDOUT newln, newlnLen
    STDOUT piscesInfo4, $ - piscesInfo4 - 1
    STDOUT newln, newlnLen
    STDOUT piscesInfo5, $ - piscesInfo5 - 1
    STDOUT newln, newlnLen
    jmp .doneInfo
.doneInfo:
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