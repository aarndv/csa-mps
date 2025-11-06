section .data
    tableLineH:
    	db '+'
    	times 10 db '-'
    	db '+'
    	times 39 db '-'
    	db '+'
    	times 7 db '-'
    	db '+'
    	times 5 db '-'
    	db '+'
    	times 4 db '-'
    	db '+'
    	times 39 db '-'
    	db '+'
    	times 18 db '-'
    	db '+', 0
    tableLabels db "|Courses   |Title                                  |Section|Units|Days|Time                                   |Room              |", 0, 10
    tableRow1 db   "|GED0075   |LINEAR ALGEBRA                         |TN24   |3    |F/T |13:00:00-14:50:00/13:00:00-14:50:00    |ONLINE/ONLINE     |", 0, 10 
    tableRow2 db   "|GED0081   |COLLEGE PHYSICS 1 LECTURE              |TN24   |2    |T   |07:00:00-09:40:00                      |ONLINE            |", 0, 10
    tableRow3 db   "|CS0001    |DISCRETE STRUCTURES 1                  |TN24   |3    |S/W |15:00:00-16:50:00/15:00:00-16:50:00    |F711/F711         |", 0, 10
    tableRow4 db   "|CS0003    |COMPUTER SYSTEMS & ARCHITECTURE        |TN24   |2    |F   |10:00:00-12:40:00                      |ONLINE            |", 0, 10
    tableRow5 db   "|GED0021   |SPECIALIZED ENGLISH PROGRAM 2          |TN24   |3    |S/W |13:00:00-14:50:00/13:00:00-14:50:00    |F608/F608         |", 0, 10
    tableRow6 db   "|CCS0021   |INFORMATION MANAGEMENT (LEC)           |TN24   |2    |T   |16:00:00-18:40:00                      |ONLINE            |", 0, 10

    enrlPrompt db "Enter Enrollment Status: ", 0, 10
    stdnPrompt db "Enter Student #: ", 0, 10
    namePrompt db "Enter Name: ", 0, 10
    phonePrompt db "Enter Phone #: ", 0, 10
    zipPrompt db "Enter Zip Code: ", 0, 10
    colgPrompt db "Enter College: ", 0, 10
    progPrompt db "Enter College Program: ", 0, 10
    adrsPrompt db "Enter Address: ", 0, 10
    yrlvPrompt db "Enter Year Level: ", 0, 10

    enrlText db "Enrollment Status: ", 0, 10
    stdnText db "Student #: ", 0, 10
    nameText db "Name: ", 0, 10
    phoneText db "Phone: +", 0, 10
    zipText db "Zip Code: ", 0, 10
    colgText db "College: ", 0, 10
    progText db "Program: ", 0, 10
    adrsText db "Address: ", 0, 10
    yrlvText db "Year Level: ", 0, 10
    
    tfFeeTableLineH:
    	db '+'
    	times 80 db '-'
    	db '+', 0
    tfFeeTableLineHLen equ $ - tfFeeTableLineH

    tfFeeTableBR  db "|                                                                                |", 0, 10
    tfFeeTableR1  db "|Tuition Fee (21)                                            43,218.00           |", 0, 10    
    tfFeeTableR2  db "|Miscellaneous Fee                                           10,540.00           |", 0, 10    
    tfFeeTableR3  db "|ID Validation Fee                                           78.00               |", 0, 10   
    tfFeeTableR4  db "|ITE Computer Laboratory Fee (CCS0021)                       3,914.00            |", 0, 10    
    tfFeeTableR5  db "|ITE Computer Laboratory Fee (CS0003)                        3,914.00            |", 0, 10    
    tfFeeTableR6  db "|ITE Computer Laboratory Fee (CS0070)                        3,914.00            |", 0, 10    
    tfFeeTableR7  db "|Science Lab Fee (GED0081)                                   4,007.00            |", 0, 10    
    tfFeeTableR8  db "|TOTAL ASSESSMENT                                            69,585.00           |", 0, 10    
    tfFeeTableR9  db "|Presidents Scholar with High Honors (75% of Tuition and     (52,188.75)         |", 0, 10    
    tfFeeTableR10 db "|Miscellaneous Fee)                                                              |", 0, 10    
    tfFeeTableR11 db "|NET TOTAL ASSESSMENT                                        17,396.25           |", 0, 10     
    tfFeeTableR12 db "|Down Payment (Upon Enrollment) 40%                          6,958.50            |", 0, 10    
    tfFeeTableR13 db "|Midterm (Oct 06 - Oct 08 2025) 30%                          5,218.88            |", 0, 10
    tfFeeTableR14 db "|Final (Nov 21 - Nov 27 2025) 30%                            5,218.88            |", 0, 10    

    clafText db "Classification:", 0, 10
    clafTextLen equ $ - clafText

    cls db 27, '[2J', 27, '[H'
    clsLen equ $ - cls

    mvCrsToRight1 db 27, '[01;085H' 
    mvCrsToNewln1 db 27, '[02;001H'
    mvCrsToRight2 db 27, '[02;085H' 
    mvCrsToNewln2 db 27, '[03;001H'
    mvCrsToRight3 db 27, '[03;085H' 
    mvCrsToNewln3 db 27, '[04;001H'
    mvCrsToRightZ db 27, '[04;030H' 
    mvCrsToRight4 db 27, '[04;085H' 
    mvCrsToNewln4 db 27, '[05;001H'
    mvCrsToNewln5 db 27, '[06;001H'
    nextRow db 27, '[E' 
    nextRowLen equ $ - nextRow
    newline db 0xA

section .bss
    enrl resb 256
    stdn resb 256
    name resb 256
    phone resb 256
    zip resb 256
    colg resb 256
    prog resb 256
    adrs resb 256
    yrlv resb 256

section .text
    global _start
    
_start:
    call promptInfo
    call clearScreen
    call displayInfo
    call displayTable
    call displayTuition
    call exit

promptInfo:
    mov edx, enrlPrompt 
    call displayString
    mov eax, enrl 
    call inputString

    mov edx, stdnPrompt
    call displayString
    mov eax, stdn
    call inputString

    mov edx, namePrompt
    call displayString
    mov eax, name
    call inputString

    mov edx, phonePrompt
    call displayString
    mov eax, phone
    call inputString

    mov edx, zipPrompt 
    call displayString
    mov eax, zip
    call inputString

    mov edx, colgPrompt 
    call displayString
    mov eax, colg
    call inputString
    
    mov edx, progPrompt 
    call displayString
    mov eax, prog
    call inputString
    
    mov edx, adrsPrompt
    call displayString
    mov eax, adrs
    call inputString
    
    mov edx, yrlvPrompt 
    call displayString
    mov eax, yrlv
    call inputString
    ret

displayInfo:
    mov edx, enrlText
    call displayString
    mov edx, enrl 
    call displayString
    mov ecx, mvCrsToRight1 
    call jumpRow

    mov edx, colgText
    call displayString
    mov edx, colg
    call displayString
    mov ecx, mvCrsToNewln1
    call jumpRow

    mov edx, stdnText
    call displayString
    mov edx, stdn
    call displayString
    mov ecx, mvCrsToRight2
    call jumpRow

    mov edx, progText
    call displayString
    mov edx, prog
    call displayString
    mov ecx, mvCrsToNewln2
    call jumpRow

    mov edx, nameText
    call displayString
    mov edx, name
    call displayString
    mov ecx, mvCrsToRight3
    call jumpRow
    
    mov edx, adrsText
    call displayString
    mov edx, adrs
    call displayString
    mov ecx, mvCrsToNewln3
    call jumpRow

    mov edx, phoneText
    call displayString
    mov edx, phone
    call displayString
    mov ecx, mvCrsToRightZ
    call jumpRow

    mov edx, zipText
    call displayString
    mov edx, zip
    call displayString
    mov ecx, mvCrsToRight4
    call jumpRow

    mov edx, yrlvText
    call displayString
    mov edx, yrlv
    call displayString
    mov ecx, mvCrsToNewln4
    call jumpRow

    ;Classification
    mov edx, clafText
    call displayString
    mov ecx, mvCrsToNewln5
    call jumpRow
    ret

displayTable:
    mov edx, tableLineH
    call lineRowRoutine

    mov edx, tableLabels
    call lineRowRoutine

    mov edx, tableLineH
    call lineRowRoutine

    mov edx, tableRow1
    call lineRowRoutine

    mov edx, tableRow2
    call lineRowRoutine

    mov edx, tableRow3
    call lineRowRoutine

    mov edx, tableRow4
    call lineRowRoutine

    mov edx, tableRow5
    call lineRowRoutine

    mov edx, tableRow6
    call lineRowRoutine

    mov edx, tableLineH
    call lineRowRoutine
    ret

displayTuition:
    mov edx, tfFeeTableLineH
    call lineRowRoutine

    mov edx, tfFeeTableR1
    call lineRowRoutine

    mov edx, tfFeeTableR2
    call lineRowRoutine

    mov edx, tfFeeTableR3
    call lineRowRoutine

    mov edx, tfFeeTableR4
    call lineRowRoutine
    
    mov edx, tfFeeTableR5
    call lineRowRoutine

    mov edx, tfFeeTableR6
    call lineRowRoutine

    mov edx, tfFeeTableR7
    call lineRowRoutine

    mov edx, tfFeeTableR8
    call lineRowRoutine

    mov edx, tfFeeTableBR
    call lineRowRoutine

    mov edx, tfFeeTableR9
    call lineRowRoutine

    mov edx, tfFeeTableR10
    call lineRowRoutine

    mov edx, tfFeeTableBR
    call lineRowRoutine

    mov edx, tfFeeTableR11
    call lineRowRoutine

    mov edx, tfFeeTableBR
    call lineRowRoutine

    mov edx, tfFeeTableBR
    call lineRowRoutine

    mov edx, tfFeeTableBR
    call lineRowRoutine

    mov edx, tfFeeTableR12
    call lineRowRoutine

    mov edx, tfFeeTableR13
    call lineRowRoutine

    mov edx, tfFeeTableR14
    call lineRowRoutine
    
    mov edx, tfFeeTableLineH
    call lineRowRoutine
    ret

lineRowRoutine:
    call displayString
    mov eax, 4
    mov ebx, 1
    mov ecx, nextRow
    mov edx, nextRowLen
    int 0x80
    ret

jumpRow:
    mov eax, 4
    mov ebx, 1
    mov edx, 9
    int 0x80
	ret

displayString:
    mov ecx, edx
    mov edx, 0
countChar:
    cmp byte [ecx + edx], 0
    je doneCounting
    inc edx
    jmp countChar
doneCounting:
    mov eax, 4
    mov ebx, 1
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

exit:
    mov eax, 1
    xor ebx, ebx   
    int 0x80