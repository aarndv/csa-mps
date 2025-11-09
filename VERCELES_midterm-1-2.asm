section .data
    RESERVE_BYTE_SIZE equ 256

    rw1Title db "      _______  ___      ___          _______  _______  _______  __   __  _______      __   __  _______  __            _______      _______  ___      _______  __   __  _______  _______  _______  ___   _ ", 10
    rw2Title db "     |   _   ||   |    |   |        |   _   ||  _    ||       ||  | |  ||       |    |  |_|  ||       ||  |          |   _   |    |       ||   |    |   _   ||  |_|  ||  _    ||       ||       ||   | | |", 10
    rw3Title db "     |  |_|  ||   |    |   |        |  |_|  || |_|   ||   _   ||  | |  ||_     _|    |       ||    ___||  |          |  |_|  |    |  _____||   |    |  |_|  ||       || |_|   ||   _   ||   _   ||   |_| |", 10
    rw4Title db "     |       ||   |    |   |        |       ||       ||  | |  ||  |_|  |  |   |      |       ||   |___ |  |          |       |    | |_____ |   |    |       ||       ||       ||  | |  ||  | |  ||      _|", 10
    rw5Title db "     |       ||   |___ |   |___     |       ||  _   | |  |_|  ||       |  |   |      |       ||    ___||__|          |       |    |_____  ||   |___ |       ||       ||  _   | |  |_|  ||  |_|  ||     |_ ", 10
    rw6Title db "     |   _   ||       ||       |    |   _   || |_|   ||       ||       |  |   |      | ||_|| ||   |___  __           |   _   |     _____| ||       ||   _   || ||_|| || |_|   ||       ||       ||    _  |", 10
    rw7Title db "     |__| |__||_______||_______|    |__| |__||_______||_______||_______|  |___|      |_|   |_||_______||__|          |__| |__|    |_______||_______||__| |__||_|   |_||_______||_______||_______||___| |_|", 10
    
    titlePointers dd rw1Title, rw2Title, rw3Title, rw4Title, rw5Title, rw6Title, rw7Title, newline, newline, newline
    titleLen equ ($ - titlePointers) / 4

    rw1Footer db "     _______  ______    _______  _______  _______  ______    _______  __   __      _______  _______      _______  _______  ______    _______  __    _      ______   _______  ___      _______ ", 10
    rw2Footer db "    |       ||    _ |  |       ||       ||       ||    _ |  |       ||  | |  |    |       ||       |    |   _   ||   _   ||    _ |  |       ||  |  | |    |      | |   _   ||   |    |       |", 10
    rw3Footer db "    |    _  ||   | ||  |   _   ||    _  ||    ___||   | ||  |_     _||  |_|  |    |   _   ||    ___|    |  |_|  ||  |_|  ||   | ||  |   _   ||   |_| |    |  _    ||  |_|  ||   |    |    ___|", 10
    rw4Footer db "    |   |_| ||   |_||_ |  | |  ||   |_| ||   |___ |   |_||_   |   |  |       |    |  | |  ||   |___     |       ||       ||   |_||_ |  | |  ||       |    | | |   ||       ||   |    |   |___ ", 10
    rw5Footer db "    |    ___||    __  ||  |_|  ||    ___||    ___||    __  |  |   |  |_     _|    |  |_|  ||    ___|    |       ||       ||    __  ||  |_|  ||  _    |    | |_|   ||       ||   |___ |    ___|", 10
    rw6Footer db "    |   |    |   |  | ||       ||   |    |   |___ |   |  | |  |   |    |   |      |       ||   |        |   _   ||   _   ||   |  | ||       || | |   |    |       ||   _   ||       ||   |___ ", 10
    rw7Footer db "    |___|    |___|  |_||_______||___|    |_______||___|  |_|  |___|    |___|      |_______||___|        |__| |__||__| |__||___|  |_||_______||_|  |__|    |______| |__| |__||_______||_______|", 10

    footerPointers dd newline, newline, newline, rw1Footer, rw2Footer, rw3Footer, rw4Footer, rw5Footer, rw6Footer, rw7Footer
    footerLen equ ($ - footerPointers) / 4

    rw1Art  db ".......................................................:.::.:::::::::.::.::::::::::::::::::::::::..:.::.:::::::::::::::::::.::::::::::::::::::::::.:-:...........::*-........:..................................................................", 10
    rw2Art  db ".......................+.......................:.........:..::::::::::::::::.:::::::::.:::::::::::::.:::::::.:::::::::::::::::::::::.::.:.:.::.:.::................:::::.....................-..................................................", 10
    rw3Art  db ".......................................................:::.:::::::::::.:..:::::..:::::=::::::=:::::::.-::::::::::*:::::::::::::::::+=*::::.:.:..::::::::....::.....:..:-....:...................................................................", 10
    rw4Art  db "..........................:...........:.:.......:::::..=-:::::::::::.:::::.::::::::::-::::::::::::::::.:-:::::::::::::::::::::::::::::-:::::::..::.:::........:....::::..:.....:*...............::..................:...........................", 10
    rw5Art  db "............................:......:.....::::.:.:::::::.:::::::::::::::::..::::::-::::::::::-::::::::::::::-::#:=::::::::::::::::::::::::::::::::::...:..:........:............:....:...........................................................", 10
    rw6Art  db "....:..........:.........:..:.........-.::::.::::-:::.::::-::::::::::::::::::::::::::::::::-::::::::-::::::::::::::-::::::::::::::::::::::::::::::::::.:...:.........:............:::.....................................=.....................", 10
    rw7Art  db "...............:...:::.::.:::.:::.::::::.-::.::::::::::::::::::::::::::::::::::::::::::::::::::::::::::-::-::=:-::-:::::=:::-:::=::::::::::::::::::=:::......-....::..:....:...::.:.:...........................................................", 10
    rw8Art  db "......::::::-:--+--====+=========--=-----:--:-::%:::::::::::::::::::::::::::::::::::::::::::::::::=-:-:::::::-:::--:-:-:--:::-::-::::::::::::::+-:-::::::..:.-::.......:.......::.+...............:.............................................", 10
    rw9Art  db ".....:::=+=++%%**%%#%******************%*###*%+=+=-=-*---:--:::::-::::::::::::-::::::::-::::-::-::--=---===+-::--------:--:::=--::--=::::::::::::-:::::::::..:.:..::.:......-:..................................................................", 10
    rw10Art db ".:.....:+#*=+*+=##+*#%#**%*************************%*%*%#%#*+#---+=--+---::-:=:--:--::%+:-::-::---=+-:--+-==-----:---=-------:-:--:--::+:::-::::::::::::::::::..:..:.::..............:....................*:..:.................................", 10
    rw11Art db "........:=-#+=-=*++=**%******%*%*********%****************%****%%*#%%*+***++==----*----------=:------=#---+=-=-==+====+--=-==-=--=:---=:--:::-::::::::::::::::.:.:....:...:......:...:..........................................................", 10
    rw12Art db "...........:==+===*+*=+*%*%#%*%*****************************************%%%%%%##*#+**+#+*-==--+===-=+=-===++=--===#=+=+=++-+=-==----+=---:-:--::::::::::::::::-::....:.:.....:..:......:...................:....................................", 10
    rw13Art db "...............:=+-:--+*-*%**%**#************************************************%%%**%%%%###+*+*++**++=++*=++=++++=+*=++++=++*==+===-=--=---::-:-:-::::--=::::.:::.:..::.:....:.:::......=.....................................................", 10
    rw14Art db "...............::::=-----=--++**%%%#%#*************%***+++++****+#*#*%%******************%*%%*%*%%%%%#*#**+***#*+*+++****+***=++====-=--==*----:+::-=::::::::::::::::....:......::..::..........................................................", 10
    rw15Art db ".................:...::--+==----*%##%#%*************%*+#*%**%*=+=+++=+++*+*%*#+%%****************%*****%**%#%%%#**#%#*#*#**#**+**++++==+-=-------=::--:::-::::::::::::.::::......:::.........:..............=...................................", 10
    rw16Art db ".+................:......::::-==*-==+***%%%##************%*+**++#=+=*+++++++++*#***++#**#%%*************************%%%%%%#%%#******+++=+=====-=+=--:--::=-:::::::::::::::....:...:......::.....................................................", 10
    rw17Art db "...............................:::-:=-==+*%*####%%************%#*++=++#++++*%*%%#***%%%#%#%%%##*%#%%%****************%********%%%%#****+#**=++==--+==:-:--:--:::-:::::::-=:::.:..:.:......:..:...............:..................................", 10
    rw18Art db ".....................:............-:::--:---+-==+*#%#*#%***********#+#*#=++#%+%*%%###%%%#%%*%*****%%%%%%%%%*%*********************%***%%##**++*==#==-=----:::-::--:::-:::::::.:..:::..:.........................................................", 10
    rw19Art db "..............:......................:..::::----=-*+--+*#%%#%%**********#*#**++%*%%**#*#*#***%**%****%************************************%%%%###+++++-=----:=-:::-:::::::-::..:::.:::.:.....................:..................................", 10
    rw20Art db "..............:........................:::::::::::::---==-=***#%%**%%********#%%%*+*#***#*#*%*%************************************************%%%*%%*%++++=-=-::::::::-:-:::::::.:..:...:-.:.......:........*:.:...............................", 10
    rw21Art db "..............................................:.::-::::::--==++-+=*+#%%*************%%*####%*###*%*************************************************%%%*##*#%#*++==-=::-::::-:::::-:::.:.:::..........:........................=:................", 10
    rw22Art db "..........................................:..:......:::::::-:-::---++#+#+#*%#%%%%*********%%*%%#%#%#%*%**%******************************%%%%**************%%#*%##*#*++==+::-:::::::::::::::::.::...:...:.......................:................", 10
    rw23Art db ".........................................................::::::::::::-=-===++=**#*%%%*************%*%%#%%%**********************************%%##%%**************%##%%#+#*#**+---:::::::::::::.:.:..:.:..................:..:....:...:...........", 10
    rw24Art db "..................................................:..::.:.:.:..:::::::::::-=---==++++####%%**************%%%%*%%*******************************%###**#*#%#***********%%%+%%#%%%##**+==-:::-=::::::::::...:......................................", 10
    rw25Art db "............................................................::...:.::::::-::::::::-=-=++*+**#**#%%**%*****************************************%*%%%*%###%*%+++%%%*************#%*###*###+-----:::::::::::.:.................:.....=.............", 10
    rw26Art db "............................................................:....:.::.:.::::::::::::::+--=-==+++*##%#*%%%%**********************%*****%*****%***%%*%%%###%#*##***+==+****%*******%%##%*#******==+=--::-:::::::.........:........................", 10
    rw27Art db "..............................................................::..:...::.:..::.:::::::::::--=-=-+=-#++**##%#%%%******************%*%%%%##%#%*%#%*%%%#####***#*#**+=%*++++***%**%********#%##**#*#*+=--+---::::::...:.:................::.:......", 10
    rw28Art db ".................................................:............:...:....:......:::-::::::::-::=-:----=+-=++#*+####%%%************************%##%*****#**#***#++*+===+*====++#*+#%%**********%***+++*+++======--::::.:.........:...::..:::.......", 10
    rw29Art db "........................................:......................................::::-::::::::::::::-:---=-+*##+=*#**#*+*##%%%****%*****************%%%#**+#+++*+++%*+==++==#-++*=+**++*%********%#%*#%*#*+*==+==+-----::::.:......:......:.......", 10
    rw30Art db "...............=...........:.......................-.....:..................:.........::-::::::::::::-----==+====+++=**+***+*#%*#%#%%*%%%%**%*****************##**+++*+++*+++++===+#%%*%*%%***%%****%*%%*%%*-=+**-=-==++-::::::.:...............", 10
    rw31Art db ".......=..............................................................................:.::::::::::*:::*:-:---=---=-=--=+=++*+++*=+++++***#*##*#%%*%#%%%%*%**********************%*%*****%******************#*%%*+%**#=*==:-+=:-:::..:...........", 10
    rw32Art db "......................................................*..............................:.:.:::..:::::::::::::::--:---==-==+=*++==+==+====+=-+=-==+***%*+*##%#%*%%***********************************#%***%***#**#%*=%*+%%***+++**#==::.::.........", 10
    rw33Art db ".............................................................::.................=.............:.:..::::::::::::-----=--------=-++---------=*-----::=--=--==++*****%##%%%%%*%*********************************%***%*++++#+%#*#=*++**--::::.......", 10
    rw34Art db "........................................................................+...........:..........:...:::.:::::::::::::::::-------------::-:=-:-=::::-:-:::::-::+%:=-=-===+=+++*%#%%%%**%%%%%**%%***%%%%*%#%********%%%#***++#*+%#**#*#*%%-::......", 10
    rw35Art db ".............:...............................................:.................................:..:.:.:::.::::::::::::::::--::-::-=---:::::::::::::::::::::#::::::-:::::::::-----=*+++*%%%*%%#%%%%%*%%%%****%*%#%%*%###***##*%%%%%*+**+=+-::....", 10
    rw36Art db "............*.........................................................................................:.....:=:::::::::::::::::-:-:::::+::::::::::::::::::.:::::::-.:::.-.:*::::::::::::--:----+++++***%%%##%*%##%%%##%%%#%%##%%%#+=*==-:--:....", 10
    rw37Art db ".....................................................................................................:..............:.::::::::::::::::::::::::::::::::.::::::%-::...:..:.-:..:....::...:::::::::-:::::::-:::----========----====----::::::......", 10
    rw38Art db "............=....................................................................................:................:..:....:.::..:.:.::::::..:...::..:::.:.....:.:.:........::...........:......::.:::.:::::::.::::::::.:::.::::::.:.:.:.........", 10
    rw39Art db "...........................................................................................................................::::...::::...::....:::..:........:.*::.........................:..::...::.:.........................................", 10
    rw40Art db ".........................................................................................................:..................:...........:.......................:.....:...................:........................:............:...............", 10
    rw41Art db "........................................................................................................-...................:..............:.....................................................::..................:..........................", 10
    rw42Art db ".......................................................=.................................................................:..................:.......:...........................................................................................", 10
    rw43Art db "................................................................................................................................................................................................................................................", 10

    artPointers dd rw1Art, rw2Art, rw3Art, rw4Art, rw5Art, rw6Art, rw7Art, rw8Art, rw9Art, rw10Art, rw11Art, rw12Art, rw13Art, rw14Art, rw15Art, rw16Art, rw17Art, rw18Art, rw19Art, rw20Art, rw21Art, rw22Art, rw23Art, rw24Art, rw25Art, rw26Art, rw27Art, rw28Art, rw29Art, rw30Art, rw31Art, rw32Art, rw33Art, rw34Art, rw35Art, rw36Art, rw37Art, rw38Art, rw39Art, rw40Art, rw41Art, rw42Art, rw43Art
    artLen equ ($ - artPointers) / 4

    newline db 10,
    cls db 27, '[2J', 27, '[H'
    clsLen equ $ - cls
    
    detailsText db "Let's get your detais!", 10, 0
    namePrompt db "What's your name? ", 0
    emailPrompt db "Enter your email: ", 0
    agePrompt db "How old are you? ", 0

    firstsText db "Let's move on to your firsts!", 10, 0
    riskPrompt db "First risk you ever took? ", 0
    happyPrompt db "Last time you felt completely happy? ", 0

    favesText db "Let's move on towards your favorites!", 10, 0
    colorPrompt db "Favorite color? ", 0
    genrePrompt db "Favorite music genre? ", 0
    bandPrompt db "Favorite band? ", 0
    songPrompt db "Favorite song? ", 0
    foodPrompt db "Favorite food? ", 0
    drinkPrompt db "Favorite drink? ", 0

    hobbiesText db "Let's get to know your hobbies!", 10, 0
    actPrompt db "What's your go-to activity? ", 0
    gamePrompt db "What's your go-to game? ", 0
    bookPrompt db "What's your go-to book? ", 0
    showPrompt db "What's your go-to show? ", 0
    moviePrompt db "What's your go-to movie? ", 0
    placePrompt db "What's your go-to place? ", 0

    whatIfText db "Next is your what ifs!", 10, 0
    powerPrompt db "What if you had a superpower. What would that be? ", 0
    timeTrvPrompt db "What if you could time travel. When would you go? ", 0
    meetAnyPrompt db "What if you could meet anyone. Who would that be? ", 0

    topThreeText db "Let's find out about your top 3's", 10, 0
    t3SongsPrompt db "Top 3 songs on repeat right now? ", 0
    t3ThingsPrompt db "Top 3 things you can't live without? ", 0
    t3CountriesPrompt db "Top 3 dream countries? ", 0

    ambitionsText db "Lastly, let's find out about your ambitions!", 10, 0
    dreamPrompt db "What is your dream? ", 0
    mottoPrompt db "What is your motto in life? ", 0
    
    ;DETAILS
    mvCrsDetailsH db 27, '[014;004H' 
    mvCrsDetails1 db 27, '[015;004H'
    mvCrsDetails2 db 27, '[016;004H'
    mvCrsDetails3 db 27, '[017;004H'

    ;FIRSTS
    mvCrsFirstsH db 27, '[014;060H' 
    mvCrsFirsts1 db 27, '[015;060H'
    mvCrsFirsts2 db 27, '[016;060H'

    ;FAVES
    mvCrsFavesH db 27, '[026;201H'
    mvCrsFaves1 db 27, '[027;201H'
    mvCrsFaves2 db 27, '[028;201H'
    mvCrsFaves3 db 27, '[029;201H'
    mvCrsFaves4 db 27, '[030;201H'
    mvCrsFaves5 db 27, '[031;201H'
    mvCrsFaves6 db 27, '[032;201H'

    ;HOBBIES
    mvCrsHobbiesH db 27, '[014;143H'
    mvCrsHobbies1 db 27, '[015;143H'
    mvCrsHobbies2 db 27, '[016;143H'
    mvCrsHobbies3 db 27, '[017;143H'
    mvCrsHobbies4 db 27, '[018;143H'
    mvCrsHobbies5 db 27, '[019;143H'
    mvCrsHobbies6 db 27, '[020;143H'

    ;WHAT IFS
    mvCrsWhatIfH db 27, '[018;181H'
    mvCrsWhatIf1 db 27, '[019;181H'
    mvCrsWhatIf2 db 27, '[020;181H'
    mvCrsWhatIf3 db 27, '[021;181H'
    
    ;TOP THREE
    mvCrsTopThreeH db 27, '[032;004H'
    mvCrsTopThree1 db 27, '[033;004H'
    mvCrsTopThree2 db 27, '[034;004H'
    mvCrsTopThree3 db 27, '[035;004H'

    ;AMBITIONS
    mvCrsAmbitionH db 27, '[042;004H'
    mvCrsAmbition1 db 27, '[043;004H'
    mvCrsAmbition2 db 27, '[044;004H'

    details db " [ -- DETAILS -- ] ", 0
    firsts db " [ -- FIRSTS! -- ] ", 0
    faves db " [ -- FAVORITES! -- ] ", 0
    hobbies db " [ -- HOBBIES -- ] ", 0
    whatIf db " [ -- WHAT IFS -- ] ", 0
    topThree db " [ -- TOP 3's -- ] ", 0
    ambitions db " [ -- AMBITIONS -- ] ", 0

    nameAns db " (*)  Name: ", 0
    emailAns db " (*)  Email: ", 0
    ageAns db " (*)  Age: ", 0
    riskAns db " (*)  First risk you ever took? ", 0
    happyAns db " (*)  Last time you felt happy? ", 0
    colorAns db " (*)  Color: ", 0
    genreAns db " (*)  Music Genre: ", 0
    bandAns db " (*)  Band: ", 0
    songAns db " (*)  Song: ", 0
    foodAns db " (*)  Food: ", 0
    drinkAns db " (*)  Drink: ", 0
    actAns db " (*)  Activity: ", 0
    gameAns db " (*)  Game: ", 0
    bookAns db " (*)  Book: ", 0
    showAns db " (*)  Show: ", 0
    movieAns db " (*)  Movie: ", 0
    placeAns db " (*)  Place: ", 0
    powerAns db " (*)  Superpower: ", 0
    timeTrvAns db " (*)  If you could time travel: ", 0
    meetAnyAns db " (*)  If you could meet anyone: ", 0
    t3SongsAns db " (*)  Songs right now: ", 0
    t3ThingsAns db " (*)  Can't live w/out: ", 0
    t3CountriesAns db " (*)  Countries: ", 0
    dreamAns db " (*)  Dream: ", 0
    mottoAns db " (*)  Motto: ", 0

    mvCrsEnd db 27, '[065;000H'
    
section .bss
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
    call clearScreen
    call promptInput
    call clearScreen
    call displayArt
    call displayAnswers
    call resetCursor
    call exit

promptInput:
    mov esi, detailsText
    call printString
    mov esi, namePrompt
    call printString
    mov eax, name
    call inputString

    mov esi, emailPrompt
    call printString
    mov eax, email
    call inputString

    mov esi, agePrompt
    call printString
    mov eax, age
    call inputString
    call clearScreen

    mov esi, firstsText
    call printString
    mov esi, riskPrompt
    call printString
    mov eax, risk
    call inputString

    mov esi, happyPrompt
    call printString
    mov eax, happy
    call inputString
    call clearScreen

    mov esi, favesText
    call printString
    mov esi, colorPrompt
    call printString
    mov eax, color
    call inputString

    mov esi, genrePrompt
    call printString
    mov eax, genre
    call inputString

    mov esi, bandPrompt
    call printString
    mov eax, band
    call inputString

    mov esi, songPrompt
    call printString
    mov eax, song
    call inputString

    mov esi, foodPrompt
    call printString
    mov eax, food
    call inputString

    mov esi, drinkPrompt
    call printString
    mov eax, drink
    call inputString    
    call clearScreen

    mov esi, hobbiesText
    call printString
    mov esi, actPrompt
    call printString
    mov eax, act
    call inputString

    mov esi, gamePrompt
    call printString
    mov eax, game
    call inputString

    mov esi, bookPrompt
    call printString
    mov eax, book
    call inputString

    mov esi, showPrompt
    call printString
    mov eax, show
    call inputString

    mov esi, moviePrompt
    call printString
    mov eax, movie
    call inputString

    mov esi, placePrompt
    call printString
    mov eax, place
    call inputString
    call clearScreen

    mov esi, whatIfText
    call printString
    mov esi, powerPrompt
    call printString
    mov eax, power
    call inputString

    mov esi, timeTrvPrompt
    call printString
    mov eax, timeTrv
    call inputString

    mov esi, meetAnyPrompt
    call printString
    mov eax, meetAny
    call inputString
    call clearScreen

    mov esi, topThreeText
    call printString
    mov esi, t3SongsPrompt
    call printString
    mov eax, t3Songs
    call inputString

    mov esi, t3ThingsPrompt
    call printString
    mov eax, t3Things
    call inputString

    mov esi, t3CountriesPrompt
    call printString
    mov eax, t3Countries
    call inputString
    call clearScreen

    mov esi, ambitionsText
    call printString
    mov esi, dreamPrompt
    call printString
    mov eax, dream
    call inputString

    mov esi, mottoPrompt
    call printString
    mov eax, motto
    call inputString
    ret
displayArt:
    mov ecx, titleLen
    mov esi, titlePointers
    call printLoop

    mov ecx, artLen
    mov esi, artPointers
    call printLoop

    mov ecx, footerLen
    mov esi, footerPointers
    call printLoop

    ret
displayAnswers:
    mov ecx, mvCrsDetailsH
    call jumpRow
    mov esi, details
    call printString

    mov ecx, mvCrsDetails1
    call jumpRow
    mov esi, nameAns
    call printString
    mov esi, name
    call printStringModified

    mov ecx, mvCrsDetails2
    call jumpRow
    mov esi, emailAns
    call printString
    mov esi, email
    call printStringModified

    mov ecx, mvCrsDetails3
    call jumpRow
    mov esi, ageAns
    call printString
    mov esi, age
    call printStringModified

    mov ecx, mvCrsFirstsH
    call jumpRow
    mov esi, firsts 
    call printString

    mov ecx, mvCrsFirsts1
    call jumpRow
    mov esi, riskAns
    call printString
    mov esi, risk
    call printStringModified

    mov ecx, mvCrsFirsts2
    call jumpRow
    mov esi, happyAns
    call printString
    mov esi, happy
    call printStringModified

    mov ecx, mvCrsFavesH
    call jumpRow
    mov esi, faves 
    call printString

    mov ecx, mvCrsFaves1
    call jumpRow
    mov esi, colorAns
    call printString
    mov esi, color
    call printStringModified

    mov ecx, mvCrsFaves2
    call jumpRow
    mov esi, gameAns
    call printString
    mov esi, game
    call printStringModified

    mov ecx, mvCrsFaves3
    call jumpRow
    mov esi, bookAns
    call printString
    mov esi, book
    call printStringModified

    mov ecx, mvCrsFaves4
    call jumpRow
    mov esi, showAns
    call printString
    mov esi, show
    call printStringModified

    mov ecx, mvCrsFaves5
    call jumpRow
    mov esi, movieAns
    call printString
    mov esi, movie
    call printStringModified

    mov ecx, mvCrsFaves6
    call jumpRow
    mov esi, drinkAns
    call printString
    mov esi, drink
    call printStringModified
    
    mov ecx, mvCrsHobbiesH
    call jumpRow
    mov esi, hobbies 
    call printString

    mov ecx, mvCrsHobbies1
    call jumpRow
    mov esi, actAns
    call printString
    mov esi, act
    call printStringModified

    mov ecx, mvCrsHobbies2
    call jumpRow
    mov esi, gameAns
    call printString
    mov esi, game
    call printStringModified

    mov ecx, mvCrsHobbies3
    call jumpRow
    mov esi, bookAns
    call printString
    mov esi, book
    call printStringModified

    mov ecx, mvCrsHobbies4
    call jumpRow
    mov esi, showAns
    call printString
    mov esi, song
    call printStringModified

    mov ecx, mvCrsHobbies5
    call jumpRow
    mov esi, movieAns
    call printString
    mov esi, movie
    call printStringModified

    mov ecx, mvCrsHobbies6
    call jumpRow
    mov esi, placeAns
    call printString
    mov esi, place
    call printStringModified

    mov ecx, mvCrsWhatIfH
    call jumpRow
    mov esi, whatIf 
    call printString

    mov ecx, mvCrsWhatIf1
    call jumpRow
    mov esi, powerAns
    call printString
    mov esi, power
    call printStringModified

    mov ecx, mvCrsWhatIf2
    call jumpRow
    mov esi, timeTrvAns
    call printString
    mov esi, timeTrv
    call printStringModified

    mov ecx, mvCrsWhatIf3
    call jumpRow
    mov esi, meetAnyAns
    call printString
    mov esi, meetAny
    call printStringModified

    mov ecx, mvCrsTopThreeH
    call jumpRow
    mov esi, topThree 
    call printString

    mov ecx, mvCrsTopThree1
    call jumpRow
    mov esi, t3SongsAns
    call printString
    mov esi, t3Songs
    call printStringModified

    mov ecx, mvCrsTopThree2
    call jumpRow
    mov esi, t3ThingsAns
    call printString
    mov esi, t3Things
    call printStringModified

    mov ecx, mvCrsTopThree3
    call jumpRow
    mov esi, t3CountriesAns
    call printString
    mov esi, t3Countries
    call printStringModified

    mov ecx, mvCrsAmbitionH
    call jumpRow
    mov esi, ambitions 
    call printString

    mov ecx, mvCrsAmbition1
    call jumpRow
    mov esi, dreamAns
    call printString
    mov esi, dream
    call printStringModified

    mov ecx, mvCrsAmbition2
    call jumpRow
    mov esi, mottoAns
    call printString
    mov esi, motto
    call printStringModified
    
    ret

printLoop:
nextLine:
    cmp ecx, 0
    je end

    mov edi, [esi]
    call strLen
    push ecx

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    int 0x80

    pop ecx
    add esi, 4
    dec ecx
    jmp nextLine
end:
    ret
strLen:
    xor edx, edx
countLoop:
    cmp byte [edi + edx], 10
    je done
    inc edx
    jmp countLoop
done:
    inc edx
    ret

printString:
    mov edx, 0              
findLen:
    cmp byte [esi + edx], 0
    je doWrite
    inc edx
    jmp findLen
doWrite:
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    int 0x80                
    ret

printStringModified:
    mov edx, 0
findLenM:
    cmp byte [esi + edx], 0
    je doWriteM
    inc edx
    jmp findLenM
doWriteM:
    mov byte [esi + edx], ' '
    inc edx
    mov byte [esi + edx], ' '
    inc edx
    mov byte [esi + edx], ' '
    inc edx
    mov byte [esi + edx], '|'
    inc edx
    mov byte [esi + edx], 0

    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    int 0x80
    ret
    
jumpRow:
    mov eax, 4
    mov ebx, 1
    mov edx, 10
    int 0x80
    ret
inputString:
    mov ebx, 0
    mov edx, 255
    mov ecx, eax
    mov eax, 3
    int 0x80
    mov byte [ecx + eax - 1], 0
    ret
clearScreen:
	mov eax, 4
	mov ebx, 1
	mov ecx, cls
	mov edx, clsLen
	int 0x80
	ret
resetCursor:
    mov eax, 4
    mov ebx, 1
    mov ecx, mvCrsEnd
    mov edx, 10
    int 0x80
    ret
exit:
    mov eax, 1
    xor ebx, ebx   
    int 0x80
