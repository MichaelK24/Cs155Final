; Michael King final project
; Choose your own adventure game
; r0 - used for output and character handling
; r1 - used for score tracking
; r2 - used for comparison results
; r3 - temporary for ascii comparison
; r4 - used to load addresses
; r5 - not used
; r6 - not used
; r7 - return address for jsr
.ORIG x3000
;scenario
scenario1      .STRINGZ "Someones car broke down will you help them (H) or pass by (P)? \n"
prompt1        .STRINGZ "Enter your choice: "
        LEA R0, scenario1     ; load first message
        PUTS                  ; print it
        LEA R0, prompt1       ; load prompt
        PUTS                  ; print it
        JSR getchoice         ; get input
        JSR processchoice     ; process input

; scenario 2
scenario2      .STRINGZ "\nYou find a wallet on the ground do you return it (H) or keep it (P)? \n"
prompt2        .STRINGZ "Enter your choice: "
        LEA R0, scenario2
        PUTS
        LEA R0, prompt2
        PUTS
        JSR getchoice
        JSR processchoice

; scenario 3
scenario3      .STRINGZ "\nA classmate asks for your notes share (H) or ignore (P)?\n"
prompt3        .STRINGZ "Enter your choice: "
        LEA R0, scenario3
        PUTS
        LEA R0, prompt3
        PUTS
        JSR getchoice
        JSR processchoice

; scenario 4
scenario4      .STRINGZ "\nYou witness bullying do you intervene (H) or walk away (P)?\n"
prompt4        .STRINGZ "Enter your choice: "
        LEA R0, scenario4
        PUTS
        LEA R0, prompt4
        PUTS
        JSR getchoice
        JSR processchoice

;scenario 5
scenario5      .STRINGZ "\nYour friend is in trouble offer help (H) or stay silent (P)?\n"
prompt5        .STRINGZ "Enter your choice: "
        LEA R0, scenario5
        PUTS
        LEA R0, prompt5
        PUTS
        JSR getchoice
        JSR processchoice
; scenario 6
scenario6      .STRINGZ "\nSomeone asks to borrow 5$ at the gas pump (H) or ignore him (P)?\n"
prompt6        .STRINGZ "Enter your choice: "
        LEA R0, scenario6
        PUTS
        LEA R0, prompt6
        PUTS
        JSR getchoice
        JSR processchoice
; scenario 7 
scenario7      .STRINGZ "\nYou witness a bank being robbed (H) or stay silent (P)?\n"
prompt7        .STRINGZ "Enter your choice: "
        LEA R0, scenario6     ; note: still loads scenario6
        PUTS
        LEA R0, prompt7
        PUTS
        JSR getchoice
        JSR processchoice

; scenario 8
scenario8      .STRINGZ "\nYou see a car drive off the road and into the water Call the Police (H) or ignore it (P)?\n"
prompt8        .STRINGZ "Enter your choice: "
        LEA R0, scenario8
        PUTS
        LEA R0, prompt8
        PUTS
        JSR getchoice
        JSR processchoice

;determine ending
        LEA R4, score         ; load score location
        LDR R1, R4, #0        ; load score value
        BRp positiveending    ; if score > 0
        BRn negativeending    ; if score < 0
        BRz secretending      ; if score = 0
positiveending
        LEA R0, endingpos
        PUTS
        BRnzp haltprogram
negativeending
        LEA R0, endingneg
        PUTS
        BRnzp haltprogram
secretending
        LEA R0, endingsecret
        PUTS
haltprogram
        HALT                 ; stop program
; subroutines
getchoice
        GETC                 ; get char input
        OUT                  ; echo input
        RET
processchoice
        ; check for 'H'
        LEA R4, asciiH
        LDR R3, R4, #0
        NOT R3, R3
        ADD R3, R3, #1
        ADD R2, R0, R3
        BRz helpchoice       ; if input was 'H'

        ; check for 'P'
        LEA R4, asciiP
        LDR R3, R4, #0
        NOT R3, R3
        ADD R3, R3, #1
        ADD R2, R0, R3
        BRz passchoice       ; if input was 'P'
        ; invalid input
        BRnzp endgame

helpchoice
        LEA R4, score
        LDR R1, R4, #0
        ADD R1, R1, #1       ; add 1 for help
        STR R1, R4, #0
        RET

passchoice
        LEA R4, score
        LDR R1, R4, #0
        ADD R1, R1, #-1      ; subtract 1 for pass
        STR R1, R4, #0
        RET

endgame
        LEA R0, invalidinputmsg
        PUTS
        BRnzp haltprogram

; strigns and const
asciiH         .FILL x0048      ; ascii value for 'H'
asciiP         .FILL x0050      ; ascii value for 'P'
score          .BLKW 1          ; storage for the score

endingpos      .STRINGZ "\nYou have lived a good life!\n"             ; good ending
endingneg      .STRINGZ "\nYou walk alone, burdened by regret you choose to help no one.\n"   ; bad ending
endingsecret   .STRINGZ "\nA Perfectly balenced.\n" ; secret ending
invalidinputmsg .STRINGZ "\nInvalid input detected. \n" ; wrong key message

.END