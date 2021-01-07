//**************************************************************
//** clear screen
//**************************************************************
ClearScreen: {
            ldx #$00                // load counter
    clearscr:                       
            lda #$20                // load fill character 
            sta ScreenBlock1,x 
            sta ScreenBlock2,x 
            sta ScreenBlock3,x 
            sta ScreenBlock4,x
            inx         
            bne clearscr
            rts
}


//**************************************************************
//** screen position at
//** 
//**************************************************************
.macro print_at(column, row, textstring) {
    .var screen_at = ScreenMemory + 40*row+column

            ldx #$0                // set counter
        loop:                       
            lda textstring, x        // load character from position x
            beq end
            sta screen_at, x 
            inx
            jmp loop
        end:
           
}