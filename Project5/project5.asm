
.ORIG x3000


MAIN
LD R6, STACKTOP
    LEA R0, PROMPT
    PUTS

    GETC
    OUT
    LD R1, NEGASCII
    ADD R1, R0, R1
    ST R1, INPUT

    ADD R6, R6, #-1
    STR R1, R6, #0
    JSR FIBONACCI
    ADD R6, R6, #1
    ST R0, RESULT

    LEA R0, NEWLINE
    PUTS
    LEA R0, PREFIX
    PUTS

    LD R0, INPUT
    LD R1, ASCII
    ADD R0, R0, R1
    OUT

    LEA R0, EQUALS
    PUTS

    LD R2, RESULT
    AND R3, R3, #0

  TENS
    ADD R4, R2, #-10
    BRn PRINTNUM
    ADD R2, R2, #-10
    ADD R3, R3, #1
    BR TENS

 PRINTNUM
    ADD R3, R3, #0
    BRz ONES
    ADD R0, R3, #0
    LD R1, ASCII
    ADD R0, R0, R1
    OUT

ONES
    ADD R0, R2, #0
    LD R1, ASCII
    ADD R0, R0, R1
    OUT
    LEA R0, NEWLINE
    PUTS
    HALT

FIBONACCI
    ADD R6, R6, #-3
    STR R7, R6, #0
    STR R1, R6, #1
    STR R2, R6, #2

    LDR R1, R6, #3
    ADD R2, R1, #-1
    BRp RECURSE

    ADD R0, R1, #0
    BR FIBDONE

RECURSE
    ADD R2, R1, #-1
    ADD R6, R6, #-1
    STR R2, R6, #0
    JSR FIBONACCI
    ADD R6, R6, #1

    STR R0, R6, #2
    LDR R1, R6, #3
    ADD R2, R1, #-2
    ADD R6, R6, #-1
    STR R2, R6, #0
    JSR FIBONACCI
    ADD R6, R6, #1

    LDR R2, R6, #2
    ADD R0, R0, R2

FIBDONE
    LDR R7, R6, #0
    LDR R1, R6, #1
    LDR R2, R6, #2
    ADD R6, R6, #3
    RET

PROMPT   .STRINGZ "Please enter a number n: "
PREFIX   .STRINGZ "F("
EQUALS   .STRINGZ ") = "
NEWLINE  .STRINGZ "\n"
ASCII    .FILL #48
NEGASCII .FILL #-48
INPUT    .BLKW 1
RESULT   .BLKW 1
STACKTOP .FILL xF000

.END
