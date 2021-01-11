//**************************************************************
//** GAME LOOP
//**************************************************************

game_init:
    jsr ClearScreen

game_loop:

    //show sprite0 at titlescreen
    lda #$c0                        //** DEC 192
    sta SP0DP

    //set sprite0 color
    ldx WhiteCol                        // load color
    stx SP0COL                          // store value in SP0COL address

    //set sprite0 position in titlescreen
    lda player1.pos_x                   // load initial position x
    sta SP0X                            // store value in SP0X
    lda player1.pos_y                   // load initial position x
    sta SP0Y                            // store value in SP0Y

    // enable sprite0
    lda #%00000001
    sta SPENA

    jsr checkKeypressRunStopGame

    jmp game_loop




