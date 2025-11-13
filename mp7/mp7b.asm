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

; MODIFIED: Renamed from FILEIN to FILEWRITE for clarity
%macro FILEWRITE 3
    ; sys_creat (creates and opens a file)
    mov eax, 8
    mov ebx, %1     ; const char *filename
    mov ecx, 0777   ; file permissions (octal)
    int 0x80

    ; eax now holds the file descriptor (or -1 on error)
    ; We'll assume it's successful and not check for errors

    ; sys_write
    mov ebx, eax    ; file descriptor
    mov eax, 4
    mov ecx, %2     ; *buffer
    mov edx, [%3]   ; buffer_length (from address)
    int 0x80

    ; sys_close
    mov eax, 6
    ; ebx still holds the file descriptor
    int 0x80
%endmacro

%macro PRINTLN 2
    STDOUT %1, %2
    STDOUT newln, newlnLen
%endmacro

%macro GETINPUT 3
    STDOUT %1, %2
    STDIN %3, RESERVE_BYTE_SIZE

    dec eax
    mov byte [%3 + eax], 0
%endmacro

; NEW: Helper macro to append a string literal to the contentBuffer
%macro APPEND_STR_LITERAL 1
    mov eax, %1
    call appendString
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

    ; NEW: Filename for saving
    filename db "zodiac.txt", 0

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
    
    ariesInfo1      db "Aries is the student who raises their hand first, even if", 0
    ariesInfo1Len equ $ - ariesInfo1
    ariesInfo2      db "they're not 100% sure of the answer. They're the competitive", 0
    ariesInfo2Len equ $ - ariesInfo2
    ariesInfo3      db "one who turns every group project into a race and will", 0
    ariesInfo3Len equ $ - ariesInfo3
    ariesInfo4      db "probably organize the study group (and the party afterwards)."
    ariesInfo4Len equ $ - ariesInfo4

    taurusInfo1      db "Taurus is the super-reliable study buddy who always has the", 0
    taurusInfo1Len equ $ - taurusInfo1
    taurusInfo2      db "best snacks. They'll work methodically on a project all night,", 0
    taurusInfo2Len equ $ - taurusInfo2
    taurusInfo3      db "but good luck trying to get them to change their thesis state-", 0
    taurusInfo3Len equ $ - taurusInfo3
    taurusInfo4      db "ment once they've decided on it. They definitely know the most", 0
    taurusInfo4Len equ $ - taurusInfo4
    taurusInfo5      db "comfortable study spot in the library.", 0
    taurusInfo5Len equ $ - taurusInfo5

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

    leoInfo1        db "Leo is the student who volunteers to present the group project and", 0
    leoInfo1Len equ $ - leoInfo1
    leoInfo2        db "probably ends up directing it, too. They have a flair for the", 0
    leoInfo2Len equ $ - leoInfo2
    leoInfo3        db "dramatic and aren't afraid of the spotlight, making them a natural", 0
    leoInfo3Len equ $ - leoInfo3
    leoInfo4        db "class leader. They're also surprisingly generous and will happily", 0
    leoInfo4Len equ $ - leoInfo4
    leoInfo5        db "share their (brilliant) notes.", 0
    leoInfo5Len equ $ - leoInfo5

    virgoInfo1      db "Virgo is the student with the perfectly color-coded notes and a", 0
    virgoInfo1Len equ $ - virgoInfo1
    virgoInfo2      db "planner that's organized down to the minute. They're the one who", 0
    virgoInfo2Len equ $ - virgoInfo2
    virgoInfo3      db "asks the professor a question that clarifies the entire lesson", 0
    virgoInfo3Len equ $ - virgoInfo3
    virgoInfo4      db "for everyone. You absolutely want them to proofread your paper", 0
    virgoInfo4Len equ $ - virgoInfo4
    virgoInfo5      db "before you sumbit it.", 0
    virgoInfo5Len equ $ - virgoInfo5

    libraInfo1      db "Libra is the diplomat of every group project, making sure everyone", 0
    libraInfo1Len equ $ - libraInfo1
    libraInfo2      db "is getting along and the workload is fair. They have a natural", 0
    libraInfo2Len equ $ - libraInfo2
    libraInfo3      db "charm that professors love, but they might spend more time debating", 0
    libraInfo3Len equ $ - libraInfo3
    libraInfo4      db "which font to use than actually writing the paper.", 0
    libraInfo4Len equ $ - libraInfo4

    scorpioInfo1    db "Scorpio is the focused, intense student who sits in the back and", 0
    scorpioInfo1Len equ $ - scorpioInfo1
    scorpioInfo2    db "misses nothing. They are a research master who will dig up obscure", 0
    scorpioInfo2Len equ $ - scorpioInfo2
    scorpioInfo3    db "facts for a term paper that impress the professor. Don't even", 0
    scorpioInfo3Len equ $ - scorpioInfo3
    scorpioInfo4    db "bother asking for their grades; they're a well-kept secret.", 0
    scorpioInfo4Len equ $ - scorpioInfo4

    sagittariusInfo1 db "Sagittarius is the student who asks the big, philosophical question", 0
    sagittariusInfo1Len equ $ - sagittariusInfo1
    sagittariusInfo2 db "that sends the whole lecture on an interesting tangent. They're", 0
    sagittariusInfo2Len equ $ - sagittariusInfo2
    sagittariusInfo3 db "always optimistic about passing finals, even if they 'studied' by", 0
    sagittariusInfo3Len equ $ - sagittariusInfo3
    sagittariusInfo4 db "watching a documentary. They are the most likely to sign up", 0
    sagittariusInfo4Len equ $ - sagittariusInfo4
    sagittariusInfo5 db "for a study abroad program just for the adventure.", 0
    sagittariusInfo5Len equ $ - sagittariusInfo5

    capricornInfo1  db "Capricorn is the student who already has a five-year career plan", 0
    capricornInfo1Len equ $ - capricornInfo1
    capricornInfo2  db "and an internship lined up in their first year. They're incredibly", 0
    capricornInfo2Len equ $ - capricornInfo2
    capricornInfo3  db "disciplined, always the last to leave the library, and will create", 0
    capricornInfo3Len equ $ - capricornInfo3
    capricornInfo4  db "a detailed spreadsheet for the group project. They aren't", 0
    capricornInfo4Len equ $ - capricornInfo4
    capricornInfo5  db "just here to pass; they're here to be top of the class.", 0
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
    taurusArt1 db ".-.     .-.", 0
    taurusArt1Len equ $ - taurusArt1
    taurusArt2 db " \.     ./  ", 0
    taurusArt2Len equ $ - taurusArt2
    taurusArt3 db "   \___/    ", 0
    taurusArt3Len equ $ - taurusArt3
    taurusArt4 db " .'   '.   ", 0
    taurusArt4Len equ $ - taurusArt4
    taurusArt5 db ":       :  ", 0
    taurusArt5Len equ $ - taurusArt5
    taurusArt6 db ":       :  ", 0
    taurusArt6Len equ $ - taurusArt6
    taurusArt7 db " '.___.'   ", 0
    taurusArt7Len equ $ - taurusArt7

    ; gemini
    geminiArt1 db "'--.__.--'", 0
    geminiArt1Len equ $ - geminiArt1
    geminiArt2 db "    ||     ", 0
    geminiArt2Len equ $ - geminiArt2
    geminiArt3 db "    ||     ", 0
    geminiArt3Len equ $ - geminiArt3
    geminiArt4 db "    ||     ", 0
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
    cancerArt4 db "'.   //   ", 0
    cancerArt4Len equ $ - cancerArt4
    cancerArt5 db "  `---''  ", 0
    cancerArt5Len equ $ - cancerArt5

    ; leo
    leoArt1 db "   .-'-. ", 0
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
    virgoArt5Len equ $ - virgoArt5

    ; libra
    libraArt1 db "    _--_    ", 0
    libraArt1Len equ $ - libraArt1
    libraArt2 db "   (    )   ", 0
    libraArt2Len equ $ - libraArt2
    libraArt3 db "__/      \__", 0
    libraArt3Len equ $ - libraArt3
    libraArt4 db "=====--=====", 0
    libraArt4Len equ $ - libraArt4
    libraArt5 db "'`        `'", 0
    libraArt5Len equ $ - libraArt5
    
    ; scorpio
    scorpioArt1 db "`:--.--.      ", 0
    scorpioArt1Len equ $ - scorpioArt1
    scorpioArt2 db " |  |  |      ", 0
    scorpioArt2Len equ $ - scorpioArt2
    scorpioArt3 db " |  |  |      ", 0
    scorpioArt3Len equ $ - scorpioArt3
    scorpioArt4 db " |  :  |\  ./\,", 0
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
    aquariusArt5 db "'              '", 0
    aquariusArt5Len equ $ - aquariusArt5

    ; pisces
    piscesArt1 db "`-.   .-'", 0
    piscesArt1Len equ $ - piscesArt1
    piscesArt2 db "   :  :   ", 0
    piscesArt2Len equ $ - piscesArt2
    piscesArt3 db " --:--:-- ", 0
    piscesArt3Len equ $ - piscesArt3
    piscesArt4 db "   :  :   ", 0
    piscesArt4Len equ $ - piscesArt4
    piscesArt5 db ".-'   `-.", 0
    piscesArt5Len equ $ - piscesArt5

    zodiacs dd aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces
    zodiacsLen db ariesLen, taurusLen, geminiLen, cancerLen, leoLen, virgoLen, libraLen, scorpioLen, sagittariusLen, capricornLen, aquariusLen, piscesLen

    newln db 10, 0
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
    call outputZodiac      ; Prints to console
    call saveToFile       ; Builds buffer and saves to file
    STDOUT savedTxt, savedTxtLen
    STDOUT newln, newlnLen
    jmp askTryAgain

; MODIFIED: This function now builds the entire file buffer
; and calls the FILEWRITE macro.
saveToFile:
    ; Reset content length to 0 to start building a new file
    mov dword [contentLength], 0

    ; 1. Append "Your zodiac sign is: "
    APPEND_STR_LITERAL outputTxt

    ; 2. Append the correct zodiac name
    movzx eax, byte [zodiacInt]
    dec eax
    shl eax, 2
    mov eax, [zodiacs + eax]
    call appendString

    APPEND_STR_LITERAL newln
    APPEND_STR_LITERAL newln

    ; 3. Append "Birthday: " and the birthday string
    mov eax, bdayTxt
    mov ebx, bdayBuffer
    call appendStringPair

    APPEND_STR_LITERAL newln
    APPEND_STR_LITERAL newln

    ; 4. Jump to append the correct Art
    cmp byte [zodiacInt], 1
    je .appendAriesArt
    cmp byte [zodiacInt], 2
    je .appendTaurusArt
    cmp byte [zodiacInt], 3
    je .appendGeminiArt
    cmp byte [zodiacInt], 4
    je .appendCancerArt
    cmp byte [zodiacInt], 5
    je .appendLeoArt
    cmp byte [zodiacInt], 6
    je .appendVirgoArt
    cmp byte [zodiacInt], 7
    je .appendLibraArt
    cmp byte [zodiacInt], 8
    je .appendScorpioArt
    cmp byte [zodiacInt], 9
    je .appendSagittariusArt
    cmp byte [zodiacInt], 10
    je .appendCapricornArt
    cmp byte [zodiacInt], 11
    je .appendAquariusArt
    cmp byte [zodiacInt], 12
    je .appendPiscesArt
    jmp .doneAppendArt

; --- NEW SECTION: Functions to append Art to buffer ---
.appendAriesArt:
    APPEND_STR_LITERAL ariesArt1
    APPEND_STR_LITERAL ariesArt2
    APPEND_STR_LITERAL ariesArt3
    APPEND_STR_LITERAL ariesArt4
    jmp .doneAppendArt
.appendTaurusArt:
    APPEND_STR_LITERAL taurusArt1
    APPEND_STR_LITERAL taurusArt2
    APPEND_STR_LITERAL taurusArt3
    APPEND_STR_LITERAL taurusArt4
    APPEND_STR_LITERAL taurusArt5
    APPEND_STR_LITERAL taurusArt6
    APPEND_STR_LITERAL taurusArt7
    jmp .doneAppendArt
.appendGeminiArt:
    APPEND_STR_LITERAL geminiArt1
    APPEND_STR_LITERAL geminiArt2
    APPEND_STR_LITERAL geminiArt3
    APPEND_STR_LITERAL geminiArt4
    APPEND_STR_LITERAL geminiArt5
    jmp .doneAppendArt
.appendCancerArt:
    APPEND_STR_LITERAL cancerArt1
    APPEND_STR_LITERAL cancerArt2
    APPEND_STR_LITERAL cancerArt3
    APPEND_STR_LITERAL cancerArt4
    APPEND_STR_LITERAL cancerArt5
    jmp .doneAppendArt
.appendLeoArt:
    APPEND_STR_LITERAL leoArt1
    APPEND_STR_LITERAL leoArt2
    APPEND_STR_LITERAL leoArt3
    APPEND_STR_LITERAL leoArt4
    APPEND_STR_LITERAL leoArt5
    jmp .doneAppendArt
.appendVirgoArt:
    APPEND_STR_LITERAL virgoArt1
    APPEND_STR_LITERAL virgoArt2
    APPEND_STR_LITERAL virgoArt3
    APPEND_STR_LITERAL virgoArt4
    APPEND_STR_LITERAL virgoArt5
    jmp .doneAppendArt
.appendLibraArt:
    APPEND_STR_LITERAL libraArt1
    APPEND_STR_LITERAL libraArt2
    APPEND_STR_LITERAL libraArt3
    APPEND_STR_LITERAL libraArt4
    APPEND_STR_LITERAL libraArt5
    jmp .doneAppendArt
.appendScorpioArt:
    APPEND_STR_LITERAL scorpioArt1
    APPEND_STR_LITERAL scorpioArt2
    APPEND_STR_LITERAL scorpioArt3
    APPEND_STR_LITERAL scorpioArt4
    APPEND_STR_LITERAL scorpioArt5
    jmp .doneAppendArt
.appendSagittariusArt:
    APPEND_STR_LITERAL sagittariusArt1
    APPEND_STR_LITERAL sagittariusArt2
    APPEND_STR_LITERAL sagittariusArt3
    APPEND_STR_LITERAL sagittariusArt4
    APPEND_STR_LITERAL sagittariusArt5
    jmp .doneAppendArt
.appendCapricornArt:
    APPEND_STR_LITERAL capricornArt1
    APPEND_STR_LITERAL capricornArt2
    APPEND_STR_LITERAL capricornArt3
    APPEND_STR_LITERAL capricornArt4
    APPEND_STR_LITERAL capricornArt5
    jmp .doneAppendArt
.appendAquariusArt:
    APPEND_STR_LITERAL aquariusArt1
    APPEND_STR_LITERAL aquariusArt2
    APPEND_STR_LITERAL aquariusArt3
    APPEND_STR_LITERAL aquariusArt4
    APPEND_STR_LITERAL aquariusArt5
    jmp .doneAppendArt
.appendPiscesArt:
    APPEND_STR_LITERAL piscesArt1
    APPEND_STR_LITERAL piscesArt2
    APPEND_STR_LITERAL piscesArt3
    APPEND_STR_LITERAL piscesArt4
    APPEND_STR_LITERAL piscesArt5
    jmp .doneAppendArt
.doneAppendArt:
    APPEND_STR_LITERAL newln
    APPEND_STR_LITERAL newln

    ; 5. Jump to append the correct Info
    cmp byte [zodiacInt], 1
    je .appendAriesInfo
    cmp byte [zodiacInt], 2
    je .appendTaurusInfo
    cmp byte [zodiacInt], 3
    je .appendGeminiInfo
    cmp byte [zodiacInt], 4
    je .appendCancerInfo
    cmp byte [zodiacInt], 5
    je .appendLeoInfo
    cmp byte [zodiacInt], 6
    je .appendVirgoInfo
    cmp byte [zodiacInt], 7
    je .appendLibraInfo
    cmp byte [zodiacInt], 8
    je .appendScorpioInfo
    cmp byte [zodiacInt], 9
    je .appendSagittariusInfo
    cmp byte [zodiacInt], 10
    je .appendCapricornInfo
    cmp byte [zodiacInt], 11
    je .appendAquariusInfo
    cmp byte [zodiacInt], 12
    je .appendPiscesInfo
    jmp .doneAppendInfo

; --- NEW SECTION: Functions to append Info to buffer ---
.appendAriesInfo:
    APPEND_STR_LITERAL ariesInfo1
    APPEND_STR_LITERAL ariesInfo2
    APPEND_STR_LITERAL ariesInfo3
    APPEND_STR_LITERAL ariesInfo4
    jmp .doneAppendInfo
.appendTaurusInfo:
    APPEND_STR_LITERAL taurusInfo1
    APPEND_STR_LITERAL taurusInfo2
    APPEND_STR_LITERAL taurusInfo3
    APPEND_STR_LITERAL taurusInfo4
    APPEND_STR_LITERAL taurusInfo5
    jmp .doneAppendInfo
.appendGeminiInfo:
    APPEND_STR_LITERAL geminiInfo1
    APPEND_STR_LITERAL geminiInfo2
    APPEND_STR_LITERAL geminiInfo3
    APPEND_STR_LITERAL geminiInfo4
    jmp .doneAppendInfo
.appendCancerInfo:
    APPEND_STR_LITERAL cancerInfo1
    APPEND_STR_LITERAL cancerInfo2
    APPEND_STR_LITERAL cancerInfo3
    APPEND_STR_LITERAL cancerInfo4
    APPEND_STR_LITERAL cancerInfo5
    jmp .doneAppendInfo
.appendLeoInfo:
    APPEND_STR_LITERAL leoInfo1
    APPEND_STR_LITERAL leoInfo2
    APPEND_STR_LITERAL leoInfo3
    APPEND_STR_LITERAL leoInfo4
    APPEND_STR_LITERAL leoInfo5
    jmp .doneAppendInfo
.appendVirgoInfo:
    APPEND_STR_LITERAL virgoInfo1
    APPEND_STR_LITERAL virgoInfo2
    APPEND_STR_LITERAL virgoInfo3
    APPEND_STR_LITERAL virgoInfo4
    APPEND_STR_LITERAL virgoInfo5
    jmp .doneAppendInfo
.appendLibraInfo:
    APPEND_STR_LITERAL libraInfo1
    APPEND_STR_LITERAL libraInfo2
    APPEND_STR_LITERAL libraInfo3
    APPEND_STR_LITERAL libraInfo4
    jmp .doneAppendInfo
.appendScorpioInfo:
    APPEND_STR_LITERAL scorpioInfo1
    APPEND_STR_LITERAL scorpioInfo2
    APPEND_STR_LITERAL scorpioInfo3
    APPEND_STR_LITERAL scorpioInfo4
    jmp .doneAppendInfo
.appendSagittariusInfo:
    APPEND_STR_LITERAL sagittariusInfo1
    APPEND_STR_LITERAL sagittariusInfo2
    APPEND_STR_LITERAL sagittariusInfo3
    APPEND_STR_LITERAL sagittariusInfo4
    APPEND_STR_LITERAL sagittariusInfo5
    jmp .doneAppendInfo
.appendCapricornInfo:
    APPEND_STR_LITERAL capricornInfo1
    APPEND_STR_LITERAL capricornInfo2
    APPEND_STR_LITERAL capricornInfo3
    APPEND_STR_LITERAL capricornInfo4
    APPEND_STR_LITERAL capricornInfo5
    jmp .doneAppendInfo
.appendAquariusInfo:
    APPEND_STR_LITERAL aquariusInfo1
    APPEND_STR_LITERAL aquariusInfo2
    APPEND_STR_LITERAL aquariusInfo3
    APPEND_STR_LITERAL aquariusInfo4
    APPEND_STR_LITERAL aquariusInfo5
    jmp .doneAppendInfo
.appendPiscesInfo:
    APPEND_STR_LITERAL piscesInfo1
    APPEND_STR_LITERAL piscesInfo2
    APPEND_STR_LITERAL piscesInfo3
    APPEND_STR_LITERAL piscesInfo4
    APPEND_STR_LITERAL piscesInfo5
    jmp .doneAppendInfo
.doneAppendInfo:
    APPEND_STR_LITERAL newln

    ; 6. Now that the buffer is built, call FILEWRITE
    FILEWRITE filename, contentBuffer, contentLength

    ret

; This function remains unchanged and prints to STDOUT
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

    STDOUT bdayTxt, bdayTxtLen
    STDOUT bdayBuffer, 10 

    STDOUT newln, newlnLen
    STDOUT newln, newlnLen

    cmp byte [zodiacInt], 1
    je .printAriesArt
    cmp byte [zodiacInt], 2
    je .printTaurusArt
    cmp byte [zodiacInt], 3
    je .printGeminiArt
    cmp byte [zodiacInt], 4
    je .printCancerArt
    cmp byte [zodiacInt], 5
    je .printLeoArt
    cmp byte [zodiacInt], 6
    je .printVirgoArt
    cmp byte [zodiacInt], 7
    je .printLibraArt
    cmp byte [zodiacInt], 8
    je .printScorpioArt
    cmp byte [zodiacInt], 9
    je .printSagittariusArt
    cmp byte [zodiacInt], 10
    je .printCapricornArt
    cmp byte [zodiacInt], 11
    je .printAquariusArt
    cmp byte [zodiacInt], 12
    je .printPiscesArt
    jmp .doneArt          ; Jump to the end

.printAriesArt:
    STDOUT ariesArt1, ariesArt1Len
    STDOUT newln, newlnLen
    STDOUT ariesArt2, ariesArt2Len
    STDOUT newln, newlnLen
    STDOUT ariesArt3, ariesArt3Len
    STDOUT newln, newlnLen
    STDOUT ariesArt4, ariesArt4Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printTaurusArt:
    STDOUT taurusArt1, taurusArt1Len
    STDOUT newln, newlnLen
    STDOUT taurusArt2, taurusArt2Len
    STDOUT newln, newlnLen
    STDOUT taurusArt3, taurusArt3Len
    STDOUT newln, newlnLen
    STDOUT taurusArt4, taurusArt4Len
    STDOUT newln, newlnLen
    STDOUT taurusArt5, taurusArt5Len
    STDOUT newln, newlnLen
    STDOUT taurusArt6, taurusArt6Len
    STDOUT newln, newlnLen
    STDOUT taurusArt7, taurusArt7Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printGeminiArt:
    STDOUT geminiArt1, geminiArt1Len
    STDOUT newln, newlnLen
    STDOUT geminiArt2, geminiArt2Len
    STDOUT newln, newlnLen
    STDOUT geminiArt3, geminiArt3Len
    STDOUT newln, newlnLen
    STDOUT geminiArt4, geminiArt4Len
    STDOUT newln, newlnLen
    STDOUT geminiArt5, geminiArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printCancerArt:
    STDOUT cancerArt1, cancerArt1Len
    STDOUT newln, newlnLen
    STDOUT cancerArt2, cancerArt2Len
    STDOUT newln, newlnLen
    STDOUT cancerArt3, cancerArt3Len
    STDOUT newln, newlnLen
    STDOUT cancerArt4, cancerArt4Len
    STDOUT newln, newlnLen
    STDOUT cancerArt5, cancerArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printLeoArt:
    STDOUT leoArt1, leoArt1Len
    STDOUT newln, newlnLen
    STDOUT leoArt2, leoArt2Len
    STDOUT newln, newlnLen
    STDOUT leoArt3, leoArt3Len
    STDOUT newln, newlnLen
    STDOUT leoArt4, leoArt4Len
    STDOUT newln, newlnLen
    STDOUT leoArt5, leoArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printVirgoArt:
    STDOUT virgoArt1, virgoArt1Len
    STDOUT newln, newlnLen
    STDOUT virgoArt2, virgoArt2Len
    STDOUT newln, newlnLen
    STDOUT virgoArt3, virgoArt3Len
    STDOUT newln, newlnLen
    STDOUT virgoArt4, virgoArt4Len
    STDOUT newln, newlnLen
    STDOUT virgoArt5, virgoArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printLibraArt:
    STDOUT libraArt1, libraArt1Len
    STDOUT newln, newlnLen
    STDOUT libraArt2, libraArt2Len
    STDOUT newln, newlnLen
    STDOUT libraArt3, libraArt3Len
    STDOUT newln, newlnLen
    STDOUT libraArt4, libraArt4Len
    STDOUT newln, newlnLen
    STDOUT libraArt5, libraArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printScorpioArt:
    STDOUT scorpioArt1, scorpioArt1Len
    STDOUT newln, newlnLen
    STDOUT scorpioArt2, scorpioArt2Len
    STDOUT newln, newlnLen
    STDOUT scorpioArt3, scorpioArt3Len
    STDOUT newln, newlnLen
    STDOUT scorpioArt4, scorpioArt4Len
    STDOUT newln, newlnLen
    STDOUT scorpioArt5, scorpioArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printSagittariusArt:
    STDOUT sagittariusArt1, sagittariusArt1Len
    STDOUT newln, newlnLen
    STDOUT sagittariusArt2, sagittariusArt2Len
    STDOUT newln, newlnLen
    STDOUT sagittariusArt3, sagittariusArt3Len
    STDOUT newln, newlnLen
    STDOUT sagittariusArt4, sagittariusArt4Len
    STDOUT newln, newlnLen
    STDOUT sagittariusArt5, sagittariusArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printCapricornArt:
    STDOUT capricornArt1, capricornArt1Len
    STDOUT newln, newlnLen
    STDOUT capricornArt2, capricornArt2Len
    STDOUT newln, newlnLen
    STDOUT capricornArt3, capricornArt3Len
    STDOUT newln, newlnLen
    STDOUT capricornArt4, capricornArt4Len
    STDOUT newln, newlnLen
    STDOUT capricornArt5, capricornArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printAquariusArt:
    STDOUT aquariusArt1, aquariusArt1Len
    STDOUT newln, newlnLen
    STDOUT aquariusArt2, aquariusArt2Len
    STDOUT newln, newlnLen
    STDOUT aquariusArt3, aquariusArt3Len
    STDOUT newln, newlnLen
    STDOUT aquariusArt4, aquariusArt4Len
    STDOUT newln, newlnLen
    STDOUT aquariusArt5, aquariusArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.printPiscesArt:
    STDOUT piscesArt1, piscesArt1Len
    STDOUT newln, newlnLen
    STDOUT piscesArt2, piscesArt2Len
    STDOUT newln, newlnLen
    STDOUT piscesArt3, piscesArt3Len
    STDOUT newln, newlnLen
    STDOUT piscesArt4, piscesArt4Len
    STDOUT newln, newlnLen
    STDOUT piscesArt5, piscesArt5Len
    STDOUT newln, newlnLen
    jmp .doneArt
.doneArt:

    STDOUT newln, newlnLen
    STDOUT newln, newlnLen

    cmp byte [zodiacInt], 1
    je .printAriesInfo
    cmp byte [zodiacInt], 2
    je .printTaurusInfo
    cmp byte [zodiacInt], 3
    je .printGeminiInfo
    cmp byte [zodiacInt], 4
    je .printCancerInfo
    cmp byte [zodiacInt], 5
    je .printLeoInfo
    cmp byte [zodiacInt], 6
    je .printVirgoInfo
    cmp byte [zodiacInt], 7
    je .printLibraInfo
    cmp byte [zodiacInt], 8
    je .printScorpioInfo
    cmp byte [zodiacInt], 9
    je .printSagittariusInfo
    cmp byte [zodiacInt], 10
    je .printCapricornInfo
    cmp byte [zodiacInt], 11
    je .printAquariusInfo
    cmp byte [zodiacInt], 12
    je .printPiscesInfo
    jmp .doneInfo


.printAriesInfo:
    STDOUT ariesInfo1, ariesInfo1Len
    STDOUT newln, newlnLen
    STDOUT ariesInfo2, ariesInfo2Len
    STDOUT newln, newlnLen
    STDOUT ariesInfo3, ariesInfo3Len
    STDOUT newln, newlnLen
    STDOUT ariesInfo4, ariesInfo4Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printTaurusInfo:
    STDOUT taurusInfo1, taurusInfo1Len
    STDOUT newln, newlnLen
    STDOUT taurusInfo2, taurusInfo2Len
    STDOUT newln, newlnLen
    STDOUT taurusInfo3, taurusInfo3Len
    STDOUT newln, newlnLen
    STDOUT taurusInfo4, taurusInfo4Len
    STDOUT newln, newlnLen
    STDOUT taurusInfo5, taurusInfo5Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printGeminiInfo:
    STDOUT geminiInfo1, geminiInfo1Len
    STDOUT newln, newlnLen
    STDOUT geminiInfo2, geminiInfo2Len
    STDOUT newln, newlnLen
    STDOUT geminiInfo3, geminiInfo3Len
    STDOUT newln, newlnLen
    STDOUT geminiInfo4, geminiInfo4Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printCancerInfo:
    STDOUT cancerInfo1, cancerInfo1Len
    STDOUT newln, newlnLen
    STDOUT cancerInfo2, cancerInfo2Len
    STDOUT newln, newlnLen
    STDOUT cancerInfo3, cancerInfo3Len
    STDOUT newln, newlnLen
    STDOUT cancerInfo4, cancerInfo4Len
    STDOUT newln, newlnLen
    STDOUT cancerInfo5, cancerInfo5Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printLeoInfo:
    STDOUT leoInfo1, leoInfo1Len
    STDOUT newln, newlnLen
    STDOUT leoInfo2, leoInfo2Len
    STDOUT newln, newlnLen
    STDOUT leoInfo3, leoInfo3Len
    STDOUT newln, newlnLen
    STDOUT leoInfo4, leoInfo4Len
    STDOUT newln, newlnLen
    STDOUT leoInfo5, leoInfo5Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printVirgoInfo:
    STDOUT virgoInfo1, virgoInfo1Len
    STDOUT newln, newlnLen
    STDOUT virgoInfo2, virgoInfo2Len
    STDOUT newln, newlnLen
    STDOUT virgoInfo3, virgoInfo3Len
    STDOUT newln, newlnLen
    STDOUT virgoInfo4, virgoInfo4Len
    STDOUT newln, newlnLen
    STDOUT virgoInfo5, virgoInfo5Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printLibraInfo:
    STDOUT libraInfo1, libraInfo1Len
    STDOUT newln, newlnLen
    STDOUT libraInfo2, libraInfo2Len
    STDOUT newln, newlnLen
    STDOUT libraInfo3, libraInfo3Len
    STDOUT newln, newlnLen
    STDOUT libraInfo4, libraInfo4Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printScorpioInfo:
    STDOUT scorpioInfo1, scorpioInfo1Len
    STDOUT newln, newlnLen
    STDOUT scorpioInfo2, scorpioInfo2Len
    STDOUT newln, newlnLen
    STDOUT scorpioInfo3, scorpioInfo3Len
    STDOUT newln, newlnLen
    STDOUT scorpioInfo4, scorpioInfo4Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printSagittariusInfo:
    STDOUT sagittariusInfo1, sagittariusInfo1Len
    STDOUT newln, newlnLen
    STDOUT sagittariusInfo2, sagittariusInfo2Len
    STDOUT newln, newlnLen
    STDOUT sagittariusInfo3, sagittariusInfo3Len
    STDOUT newln, newlnLen
    STDOUT sagittariusInfo4, sagittariusInfo4Len
    STDOUT newln, newlnLen
    STDOUT sagittariusInfo5, sagittariusInfo5Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printCapricornInfo:
    STDOUT capricornInfo1, capricornInfo1Len
    STDOUT newln, newlnLen
    STDOUT capricornInfo2, capricornInfo2Len
    STDOUT newln, newlnLen
    STDOUT capricornInfo3, capricornInfo3Len
    STDOUT newln, newlnLen
    STDOUT capricornInfo4, capricornInfo4Len
    STDOUT newln, newlnLen
    STDOUT capricornInfo5, capricornInfo5Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printAquariusInfo:
    STDOUT aquariusInfo1, aquariusInfo1Len
    STDOUT newln, newlnLen
    STDOUT aquariusInfo2, aquariusInfo2Len
    STDOUT newln, newlnLen
    STDOUT aquariusInfo3, aquariusInfo3Len
    STDOUT newln, newlnLen
    STDOUT aquariusInfo4, aquariusInfo4Len
    STDOUT newln, newlnLen
    STDOUT aquariusInfo5, aquariusInfo5Len
    STDOUT newln, newlnLen
    jmp .doneInfo
.printPiscesInfo:
    STDOUT piscesInfo1, piscesInfo1Len
    STDOUT newln, newlnLen
    STDOUT piscesInfo2, piscesInfo2Len
    STDOUT newln, newlnLen
    STDOUT piscesInfo3, piscesInfo3Len
    STDOUT newln, newlnLen
    STDOUT piscesInfo4, piscesInfo4Len
    STDOUT newln, newlnLen
    STDOUT piscesInfo5, piscesInfo5Len
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

; Appends string in EAX to contentBuffer
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

; Appends string in EAX, then string in EBX, to contentBuffer
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