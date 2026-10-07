.ORIG x3000

; main

MAIN
    LEA R0, FIRST
    PUTS

    JSR GETNUM
    ST R0, NUM1

    LEA R0, OPMSG
    PUTS

    JSR GETOP
    ST R0, OPERATOR

    LEA R0, SECOND
    PUTS

    JSR GETNUM
    ADD R1,R0,#0

    LD R0,NUM1
    LD R2,OPERATOR

    JSR CALC
    ST R0,ANSWER

    LEA R0,RESULT
    PUTS

    LD R0,ANSWER
    JSR DISPLAY

    LD R0,ENTER
    OUT

    BRnzp MAIN


; gets the number

GETNUM
    ST R7,SAVE7NUM

    AND R1,R1,#0

GETNUMLOOP
    GETC
    OUT

    ; check enter
    ADD R2,R0,#-10
    BRz NUMDONE

    ADD R2,R0,#-13
    BRz NUMDONE

    ; change ascii to number
    LD R2,NEGZERO
    ADD R3,R0,R2

    ; multiply old number by 10
    ADD R0,R1,R1
    ADD R2,R0,R0
    ADD R2,R2,R2
    ADD R0,R0,R2

    ADD R1,R0,R3

    BRnzp GETNUMLOOP

NUMDONE
    ADD R0,R1,#0
    LD R7,SAVE7NUM
    RET


; gets + - or *

GETOP
    ST R7,SAVE7OP

    GETC
    OUT

    ST R0,TEMPOP

    LD R0,ENTER
    OUT

    LD R0,TEMPOP

    LD R7,SAVE7OP
    RET


; does the calculation
; r0 first num
; r1 second num
; r2 operator

CALC
    ST R7,SAVE7CALC

    ; check for +
    LD R3,NEGPLUS
    ADD R4,R2,R3
    BRz ADDNUM

    ; check for -
    LD R3,NEGMINUS
    ADD R4,R2,R3
    BRz SUBNUM

    ; if not + or - then multiply
    BRnzp MULTNUM


ADDNUM
    ADD R0,R0,R1
    BRnzp CALCDONE


SUBNUM
    ; make second number negative
    NOT R1,R1
    ADD R1,R1,#1

    ADD R0,R0,R1
    BRnzp CALCDONE


MULTNUM
    ADD R3,R0,#0
    ADD R4,R1,#0

    AND R0,R0,#0

MULTLOOP
    ADD R4,R4,#0
    BRz CALCDONE

    ADD R0,R0,R3
    ADD R4,R4,#-1

    BRnzp MULTLOOP


CALCDONE
    LD R7,SAVE7CALC
    RET


; prints answer

DISPLAY
    ST R7,SAVE7DIS

    ADD R1,R0,#0

    ; negative?
    BRzp POSITIVE

    LD R0,MINUS
    OUT

    NOT R1,R1
    ADD R1,R1,#1


POSITIVE

    ; thousands

    AND R2,R2,#0

THOUSAND
    LD R3,N1000
    ADD R4,R1,R3
    BRn HUNDREDSTART

    ADD R1,R4,#0
    ADD R2,R2,#1
    BRnzp THOUSAND


HUNDREDSTART
    ADD R5,R2,#0
    BRz HUNDRED

    LD R3,ZERO
    ADD R0,R2,R3
    OUT


    ; hundreds

HUNDRED
    AND R2,R2,#0

HUNDREDLOOP
    LD R3,N100
    ADD R4,R1,R3
    BRn HUNDREDDONE

    ADD R1,R4,#0
    ADD R2,R2,#1
    BRnzp HUNDREDLOOP


HUNDREDDONE
    ADD R4,R5,#0
    BRp PRINTHUNDRED

    ADD R4,R2,#0
    BRz TEN


PRINTHUNDRED
    LD R3,ZERO
    ADD R0,R2,R3
    OUT

    ADD R5,R5,#1


    ; tens

TEN
    AND R2,R2,#0

TENLOOP
    ADD R4,R1,#-10
    BRn TENDONE

    ADD R1,R4,#0
    ADD R2,R2,#1
    BRnzp TENLOOP


TENDONE
    ADD R4,R5,#0
    BRp PRINTTEN

    ADD R4,R2,#0
    BRz ONE


PRINTTEN
    LD R3,ZERO
    ADD R0,R2,R3
    OUT


    ; ones

ONE
    LD R3,ZERO
    ADD R0,R1,R3
    OUT

    LD R7,SAVE7DIS
    RET


; messages

FIRST   .STRINGZ "Enter first number (0 - 99): "
OPMSG   .STRINGZ "Enter an operation (+, -, *): "
SECOND  .STRINGZ "Enter second number (0 - 99): "
RESULT  .STRINGZ "Result: "


; variables

NUM1       .BLKW 1
OPERATOR   .BLKW 1
ANSWER     .BLKW 1
TEMPOP     .BLKW 1


; ascii stuff

ZERO       .FILL #48
NEGZERO    .FILL #-48
MINUS      .FILL #45

NEGPLUS    .FILL #-43
NEGMINUS   .FILL #-45

ENTER      .FILL #10

N100       .FILL #-100
N1000      .FILL #-1000


; saving r7 for subroutines

SAVE7NUM    .BLKW 1
SAVE7OP     .BLKW 1
SAVE7CALC   .BLKW 1
SAVE7DIS    .BLKW 1


.END