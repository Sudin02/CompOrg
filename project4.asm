
.ORIG x3000

MAIN
    LD R6, STACKTOP

    ADD R6, R6, #-5
    LEA R0, ARRAY
    AND R1, R1, #0

LOOP1
    ADD R2, R1, #-5
    BRzp DONE1

    ADD R3, R0, R1
    LDR R4, R3, #0
    ADD R3, R6, R1
    STR R4, R3, #0

    ADD R1, R1, #1
    BR LOOP1

DONE1
    ADD R4, R6, #0

    LD R0, SIZE
    ADD R6, R6, #-1
    STR R0, R6, #0

    ADD R6, R6, #-1
    STR R4, R6, #0

    LD R4, SUMADDR
    JSRR R4

    LDR R0, R6, #0
    ADD R6, R6, #3
    ADD R6, R6, #5

    ADD R6, R6, #-1
    STR R0, R6, #0

    HALT

STACKTOP .FILL xF000
SIZE     .FILL #5
SUMADDR  .FILL SUMOFSQUARES

ARRAY    .FILL #2
         .FILL #3
         .FILL #5
         .FILL #0
         .FILL #1


SUMOFSQUARES
    ADD R6, R6, #-1
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0

    ADD R5, R6, #0
    ADD R6, R6, #-2

    AND R0, R0, #0
    STR R0, R5, #-1
    STR R0, R5, #-2

    ADD R6, R6, #-4
    STR R1, R6, #0
    STR R2, R6, #1
    STR R3, R6, #2
    STR R4, R6, #3

LOOP2
    LDR R0, R5, #-1
    LDR R1, R5, #5

    NOT R2, R1
    ADD R2, R2, #1
    ADD R2, R0, R2
    BRzp DONE2

    LDR R1, R5, #4
    ADD R1, R1, R0
    LDR R2, R1, #0

    ADD R6, R6, #-1
    STR R2, R6, #0

    LD R4, SQADDR
    JSRR R4

    LDR R2, R6, #0
    ADD R6, R6, #2

    LDR R0, R5, #-2
    ADD R0, R0, R2
    STR R0, R5, #-2

    LDR R0, R5, #-1
    ADD R0, R0, #1
    STR R0, R5, #-1

    BR LOOP2

DONE2
    LDR R0, R5, #-2
    STR R0, R5, #3

    LDR R1, R6, #0
    LDR R2, R6, #1
    LDR R3, R6, #2
    LDR R4, R6, #3

    ADD R6, R5, #0
    LDR R5, R6, #0
    LDR R7, R6, #1
    ADD R6, R6, #2

    RET

SQADDR .FILL SQUARE


SQUARE
    ADD R6, R6, #-1
    ADD R6, R6, #-1
    STR R7, R6, #0
    ADD R6, R6, #-1
    STR R5, R6, #0

    ADD R5, R6, #0
    ADD R6, R6, #-1

    ADD R6, R6, #-3
    STR R0, R6, #0
    STR R1, R6, #1
    STR R2, R6, #2

    AND R0, R0, #0
    STR R0, R5, #-1

    LDR R1, R5, #4
    ADD R2, R1, #0

LOOP3
    ADD R2, R2, #0
    BRnz DONE3

    LDR R0, R5, #-1
    ADD R0, R0, R1
    STR R0, R5, #-1

    ADD R2, R2, #-1
    BR LOOP3

DONE3
    LDR R0, R5, #-1
    STR R0, R5, #3

    LDR R0, R6, #0
    LDR R1, R6, #1
    LDR R2, R6, #2

    ADD R6, R5, #0
    LDR R5, R6, #0
    LDR R7, R6, #1
    ADD R6, R6, #2

    RET

.END
