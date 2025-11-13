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
%macro FILEWRITE 3
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
    STDOUT newln, newlnLen
%endmacro
%macro GETINPUT 3
    STDOUT %1, %2
    STDIN %3, RESERVE_BYTE_SIZE
    dec eax
    mov byte [%3 + eax], 0
%endmacro
%macro APPEND_STR_LITERAL 1
    mov eax, %1
    call appendString
%endmacro
%macro PRINT_LOOP_ART 3
    movzx ecx, byte [%1]
    mov edi, %2
    mov esi, %3
    jmp .printLoopArt
%endmacro
%macro PRINT_LOOP_INFO 3
    movzx ecx, byte [%1]
    mov edi, %2 
    mov esi, %3
    jmp .printLoopInfo
%endmacro 
%macro APPEND_LOOP_ART 2
    movzx ecx, byte [%1]
    mov esi, %2
    jmp .appendLoopArt
%endmacro
%macro APPEND_LOOP_INFO 2
    movzx ecx, byte [%1]
    mov esi, %2
    jmp .appendLoopInfo
%endmacro

section .data
    RESERVE_BYTE_SIZE equ 256
    cls db 27, '[2J', 27, '[H'
    clsLen equ $ - cls
    filename db "zodiac.txt", 0

    newln db 10, 0
    newlnLen equ $ - newln

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
    
    zodiacs dd aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces
    zodiacsLen db ariesLen, taurusLen, geminiLen, cancerLen, leoLen, virgoLen, libraLen, scorpioLen, sagittariusLen, capricornLen, aquariusLen, piscesLen
    
    ariesInfo1      db "Aries is the student who raises their hand first, even if", 0
    ariesInfo1Len equ $ - ariesInfo1
    ariesInfo2      db "they're not 100% sure of the answer. They're the competitive", 0
    ariesInfo2Len equ $ - ariesInfo2
    ariesInfo3      db "one who turns every group project into a race and will", 0
    ariesInfo3Len equ $ - ariesInfo3
    ariesInfo4      db "probably organize the study group (and the party afterwards)."
    ariesInfo4Len equ $ - ariesInfo4
    ariesInfos     dd ariesInfo1, ariesInfo2, ariesInfo3, ariesInfo4
    ariesInfosLen  dd ariesInfo1Len, ariesInfo2Len, ariesInfo3Len, ariesInfo4Len
    ariesInfoCount dd 4

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
    taurusInfos     dd taurusInfo1, taurusInfo2, taurusInfo3, taurusInfo4, taurusInfo5
    taurusInfosLen  dd taurusInfo1Len, taurusInfo2Len, taurusInfo3Len, taurusInfo4Len, taurusInfo5Len
    taurusInfoCount db 5

    geminiInfo1      db "Gemini is that student who seems to be in five different clubs", 0
    geminiInfo1Len equ $ - geminiInfo1
    geminiInfo2      db "and knows everyone on campus. They'll ace the class presentation", 0
    geminiInfo2Len equ $ - geminiInfo2
    geminiInfo3      db "with their charm and quick wit, but they probably started it an", 0
    geminiInfo3Len equ $ - geminiInfo3
    geminiInfo4      db "hour before class after changing their topic three times.", 0
    geminiInfo4Len equ $ - geminiInfo4
    geminiInfos     dd geminiInfo1, geminiInfo2, geminiInfo3, geminiInfo4
    geminiInfosLen  dd geminiInfo1Len, geminiInfo2Len, geminiInfo3Len, geminiInfo4Len
    geminiInfoCount db 4

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
    cancerInfos     dd cancerInfo1, cancerInfo2, cancerInfo3, cancerInfo4, cancerInfo5
    cancerInfosLen  dd cancerInfo1Len, cancerInfo2Len, cancerInfo3Len, cancerInfo4Len, cancerInfo5Len
    cancerInfoCount db 5

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
    leoInfos        dd leoInfo1, leoInfo2, leoInfo3, leoInfo4, leoInfo5
    leoInfosLen     dd leoInfo1Len, leoInfo2Len, leoInfo3Len, leoInfo4Len, leoInfo5Len
    leoInfoCount    db 5

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
    virgoInfos      dd virgoInfo1, virgoInfo2, virgoInfo3, virgoInfo4, virgoInfo5
    virgoInfosLen   dd virgoInfo1Len, virgoInfo2Len, virgoInfo3Len, virgoInfo4Len, virgoInfo5Len
    virgoInfoCount  db 5

    libraInfo1      db "Libra is the diplomat of every group project, making sure everyone", 0
    libraInfo1Len equ $ - libraInfo1
    libraInfo2      db "is getting along and the workload is fair. They have a natural", 0
    libraInfo2Len equ $ - libraInfo2
    libraInfo3      db "charm that professors love, but they might spend more time debating", 0
    libraInfo3Len equ $ - libraInfo3
    libraInfo4      db "which font to use than actually writing the paper.", 0
    libraInfo4Len equ $ - libraInfo4
    libraInfos      dd libraInfo1, libraInfo2, libraInfo3, libraInfo4
    libraInfosLen   dd libraInfo1Len, libraInfo2Len, libraInfo3Len, libraInfo4Len
    libraInfoCount  db 4

    scorpioInfo1    db "Scorpio is the focused, intense student who sits in the back and", 0
    scorpioInfo1Len equ $ - scorpioInfo1
    scorpioInfo2    db "misses nothing. They are a research master who will dig up obscure", 0
    scorpioInfo2Len equ $ - scorpioInfo2
    scorpioInfo3    db "facts for a term paper that impress the professor. Don't even", 0
    scorpioInfo3Len equ $ - scorpioInfo3
    scorpioInfo4    db "bother asking for their grades; they're a well-kept secret.", 0
    scorpioInfo4Len equ $ - scorpioInfo4
    scorpioInfos    dd scorpioInfo1, scorpioInfo2, scorpioInfo3, scorpioInfo4
    scorpioInfosLen dd scorpioInfo1Len, scorpioInfo2Len, scorpioInfo3Len, scorpioInfo4Len
    scorpioInfoCount db 4

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
    sagittariusInfos    dd sagittariusInfo1, sagittariusInfo2, sagittariusInfo3, sagittariusInfo4, sagittariusInfo5
    sagittariusInfosLen dd sagittariusInfo1Len, sagittariusInfo2Len, sagittariusInfo3Len, sagittariusInfo4Len, sagittariusInfo5Len
    sagittariusInfoCount db 5

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
    capricornInfos      dd capricornInfo1, capricornInfo2, capricornInfo3, capricornInfo4, capricornInfo5
    capricornInfosLen   dd capricornInfo1Len, capricornInfo2Len, capricornInfo3Len, capricornInfo4Len, capricornInfo5Len
    capricornInfoCount  db 5

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
    aquariusInfos       dd aquariusInfo1, aquariusInfo2, aquariusInfo3, aquariusInfo4, aquariusInfo5
    aquariusInfosLen    dd aquariusInfo1Len, aquariusInfo2Len, aquariusInfo3Len, aquariusInfo4Len, aquariusInfo5Len
    aquariusInfoCount   db 5

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
    piscesInfos     dd piscesInfo1, piscesInfo2, piscesInfo3, piscesInfo4, piscesInfo5
    piscesInfosLen  dd piscesInfo1Len, piscesInfo2Len, piscesInfo3Len, piscesInfo4Len, piscesInfo5Len
    piscesInfoCount db 5

    ; aries
    ariesArt1 db " .-.   .-. ", 0
    ariesArt1Len equ $ - ariesArt1
    ariesArt2 db "(_ \\ // _)", 0
    ariesArt2Len equ $ - ariesArt2
    ariesArt3 db "    \|/    ", 0
    ariesArt3Len equ $ - ariesArt3
    ariesArt4 db "     |     ", 0
    ariesArt4Len equ $ - ariesArt4
    ariesArts     dd ariesArt1, ariesArt2, ariesArt3, ariesArt4 
    ariesArtsLen  dd ariesArt1Len, ariesArt2Len, ariesArt3Len, ariesArt4Len
    ariesArtCount db 4 

    ; taurus
    taurusArt1 db ".-.     .-.", 0
    taurusArt1Len equ $ - taurusArt1
    taurusArt2 db " \.     ./  ", 0
    taurusArt2Len equ $ - taurusArt2
    taurusArt3 db "   \___/    ", 0
    taurusArt3Len equ $ - taurusArt3
    taurusArt4 db "  .'   '.   ", 0
    taurusArt4Len equ $ - taurusArt4
    taurusArt5 db " :       :  ", 0
    taurusArt5Len equ $ - taurusArt5
    taurusArt6 db " :       :  ", 0
    taurusArt6Len equ $ - taurusArt6
    taurusArt7 db "  '.___.'   ", 0
    taurusArt7Len equ $ - taurusArt7
    taurusArts      dd taurusArt1, taurusArt2, taurusArt3, taurusArt4, taurusArt5, taurusArt6, taurusArt7
    taurusArtsLen   dd taurusArt1Len, taurusArt2Len, taurusArt3Len, taurusArt4Len, taurusArt5Len, taurusArt6Len, taurusArt7Len
    taurusArtCount  db 7

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
    geminiArts      dd geminiArt1, geminiArt2, geminiArt3, geminiArt4, geminiArt5
    geminiArtsLen   dd geminiArt1Len, geminiArt2Len, geminiArt3Len, geminiArt4Len, geminiArt5Len
    geminiArtCount  db 5

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
    cancerArts      dd cancerArt1, cancerArt2, cancerArt3, cancerArt4, cancerArt5
    cancerArtsLen   dd cancerArt1Len, cancerArt2Len, cancerArt3Len, cancerArt4Len, cancerArt5Len
    cancerArtCount  db 5

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
    leoArts         dd leoArt1, leoArt2, leoArt3, leoArt4, leoArt5
    leoArtsLen      dd leoArt1Len, leoArt2Len, leoArt3Len, leoArt4Len, leoArt5Len
    leoArtCount     db 5

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
    virgoArts       dd virgoArt1, virgoArt2, virgoArt3, virgoArt4, virgoArt5
    virgoArtsLen    dd virgoArt1Len, virgoArt2Len, virgoArt3Len, virgoArt4Len, virgoArt5Len
    virgoArtCount   db 5

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
    libraArts       dd libraArt1, libraArt2, libraArt3, libraArt4, libraArt5
    libraArtsLen    dd libraArt1Len, libraArt2Len, libraArt3Len, libraArt4Len, libraArt5Len
    libraArtCount   db 5

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
    scorpioArts     dd scorpioArt1, scorpioArt2, scorpioArt3, scorpioArt4, scorpioArt5
    scorpioArtsLen  dd scorpioArt1Len, scorpioArt2Len, scorpioArt3Len, scorpioArt4Len, scorpioArt5Len
    scorpioArtCount db 5

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
    sagittariusArts     dd sagittariusArt1, sagittariusArt2, sagittariusArt3, sagittariusArt4, sagittariusArt5
    sagittariusArtsLen  dd sagittariusArt1Len, sagittariusArt2Len, sagittariusArt3Len, sagittariusArt4Len, sagittariusArt5Len
    sagittariusArtCount db 5

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
    capricornArts       dd capricornArt1, capricornArt2, capricornArt3, capricornArt4, capricornArt5
    capricornArtsLen    dd capricornArt1Len, capricornArt2Len, capricornArt3Len, capricornArt4Len, capricornArt5Len
    capricornArtCount   db 5

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
    aquariusArts        dd aquariusArt1, aquariusArt2, aquariusArt3, aquariusArt4, aquariusArt5
    aquariusArtsLen     dd aquariusArt1Len, aquariusArt2Len, aquariusArt3Len, aquariusArt4Len, aquariusArt5Len
    aquariusArtCount    db 5

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
    piscesArts      dd piscesArt1, piscesArt2, piscesArt3, piscesArt4, piscesArt5
    piscesArtsLen   dd piscesArt1Len, piscesArt2Len, piscesArt3Len, piscesArt4Len, piscesArt5Len
    piscesArtCount  db 5

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
    STDOUT newln, newlnLen
    jmp askTryAgain

saveToFile:
    mov dword [contentLength], 0

    APPEND_STR_LITERAL outputTxt

    movzx eax, byte [zodiacInt]
    dec eax
    shl eax, 2
    mov eax, [zodiacs + eax]
    call appendString

    APPEND_STR_LITERAL newln
    APPEND_STR_LITERAL newln

    mov eax, bdayTxt
    mov ebx, bdayBuffer
    call appendStringPair

    APPEND_STR_LITERAL newln
    APPEND_STR_LITERAL newln

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

.appendLoopArt:
    push ecx

    mov ecx, [esi]
    push esi
    APPEND_STR_LITERAL ecx
    pop esi
    pop ecx

    sub ecx, 1
    add esi, 4
    cmp ecx, 0

    jne .appendLoopArt
    jmp .doneAppendArt
.appendAriesArt:
    APPEND_LOOP_ART ariesArtCount, ariesArts
.appendTaurusArt:
    APPEND_LOOP_ART taurusArtCount, taurusArts
.appendGeminiArt:
    APPEND_LOOP_ART geminiArtCount, geminiArts
.appendCancerArt:
    APPEND_LOOP_ART cancerArtCount, cancerArts
.appendLeoArt:
    APPEND_LOOP_ART leoArtCount, leoArts
.appendVirgoArt:
    APPEND_LOOP_ART virgoArtCount, virgoArts
.appendLibraArt:
    APPEND_LOOP_ART libraArtCount, libraArts
.appendScorpioArt:
    APPEND_LOOP_ART scorpioArtCount, scorpioArts
.appendSagittariusArt:
    APPEND_LOOP_ART sagittariusArtCount, sagittariusArts
.appendCapricornArt:
    APPEND_LOOP_ART capricornArtCount, capricornArts
.appendAquariusArt:
    APPEND_LOOP_ART aquariusArtCount, aquariusArts
.appendPiscesArt:
    APPEND_LOOP_ART piscesArtCount, piscesArts
.doneAppendArt:
    APPEND_STR_LITERAL newln
    APPEND_STR_LITERAL newln

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

.appendLoopInfo:
    push ecx

    mov ecx, [esi]
    push esi
    APPEND_STR_LITERAL ecx
    pop esi
    pop ecx

    sub ecx, 1
    add esi, 4
    cmp ecx, 0

    jne .appendLoopInfo
    jmp .doneAppendInfo
.appendAriesInfo:
    APPEND_LOOP_INFO ariesInfoCount, ariesInfos
.appendTaurusInfo:
    APPEND_LOOP_INFO taurusInfoCount, taurusInfos
.appendGeminiInfo:
    APPEND_LOOP_INFO geminiInfoCount, geminiInfos
.appendCancerInfo:
    APPEND_LOOP_INFO cancerInfoCount, cancerInfos
.appendLeoInfo:
    APPEND_LOOP_INFO leoInfoCount, leoInfos
.appendVirgoInfo:
    APPEND_LOOP_INFO virgoInfoCount, virgoInfos
.appendLibraInfo:
    APPEND_LOOP_INFO libraInfoCount, libraInfos
.appendScorpioInfo:
    APPEND_LOOP_INFO scorpioInfoCount, scorpioInfos
.appendSagittariusInfo:
    APPEND_LOOP_INFO sagittariusInfoCount, sagittariusInfos
.appendCapricornInfo:
    APPEND_LOOP_INFO capricornInfoCount, capricornInfos
.appendAquariusInfo:
    APPEND_LOOP_INFO aquariusInfoCount, aquariusInfos
.appendPiscesInfo:
    APPEND_LOOP_INFO piscesInfoCount, piscesInfos
.doneAppendInfo:
    APPEND_STR_LITERAL newln
    FILEWRITE filename, contentBuffer, contentLength
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
    jmp .doneArt          

.printLoopArt:  
    push ecx

    mov edx, [esi]
    mov ecx, [edi]
    STDOUT ecx, edx
    STDOUT newln, newlnLen
    pop ecx

    sub ecx, 1
    add esi, 4
    add edi, 4
    cmp ecx, 0
    
    jne .printLoopArt
    jmp .doneArt
.printAriesArt:
    PRINT_LOOP_ART ariesArtCount, ariesArts, ariesArtsLen
.printTaurusArt:
    PRINT_LOOP_ART taurusArtCount, taurusArts, taurusArtsLen
.printGeminiArt:
    PRINT_LOOP_ART geminiArtCount, geminiArts, geminiArtsLen
.printCancerArt:
    PRINT_LOOP_ART cancerArtCount, cancerArts, cancerArtsLen
.printLeoArt:
    PRINT_LOOP_ART leoArtCount, leoArts, leoArtsLen
.printVirgoArt:
    PRINT_LOOP_ART virgoArtCount, virgoArts, virgoArtsLen
.printLibraArt:
    PRINT_LOOP_ART libraArtCount, libraArts, libraArtsLen
.printScorpioArt:
    PRINT_LOOP_ART scorpioArtCount, scorpioArts, scorpioArtsLen
.printSagittariusArt:
    PRINT_LOOP_ART sagittariusArtCount, sagittariusArts, sagittariusArtsLen
.printCapricornArt:
    PRINT_LOOP_ART capricornArtCount, capricornArts, capricornArtsLen
.printAquariusArt:
    PRINT_LOOP_ART aquariusArtCount, aquariusArts, aquariusArtsLen
.printPiscesArt:
    PRINT_LOOP_ART piscesArtCount, piscesArts, piscesArtsLen
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

.printLoopInfo:  
    push ecx

    mov edx, [esi]
    mov ecx, [edi]
    STDOUT ecx, edx
    STDOUT newln, newlnLen
    pop ecx

    sub ecx, 1
    add esi, 4
    add edi, 4
    cmp ecx, 0
    
    jne .printLoopInfo
    jmp .doneInfo
.printAriesInfo:
    PRINT_LOOP_INFO ariesInfoCount, ariesInfos, ariesInfosLen
.printTaurusInfo:
    PRINT_LOOP_INFO taurusInfoCount, taurusInfos, taurusInfosLen
.printGeminiInfo:
    PRINT_LOOP_INFO geminiInfoCount, geminiInfos, geminiInfosLen
.printCancerInfo:
    PRINT_LOOP_INFO cancerInfoCount, cancerInfos, cancerInfosLen
.printLeoInfo:
    PRINT_LOOP_INFO leoInfoCount, leoInfos, leoInfosLen
.printVirgoInfo:
    PRINT_LOOP_INFO virgoInfoCount, virgoInfos, virgoInfosLen
.printLibraInfo:
    PRINT_LOOP_INFO libraInfoCount, libraInfos, libraInfosLen
.printScorpioInfo:
    PRINT_LOOP_INFO scorpioInfoCount, scorpioInfos, scorpioInfosLen
.printSagittariusInfo:
    PRINT_LOOP_INFO sagittariusInfoCount, sagittariusInfos, sagittariusInfosLen
.printCapricornInfo:
    PRINT_LOOP_INFO capricornInfoCount, capricornInfos, capricornInfosLen
.printAquariusInfo:
    PRINT_LOOP_INFO aquariusInfoCount, aquariusInfos, aquariusInfosLen
.printPiscesInfo:
    PRINT_LOOP_INFO piscesInfoCount, piscesInfos, piscesInfosLen
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
    xor ebx, ebx        
    xor ecx, ecx        
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