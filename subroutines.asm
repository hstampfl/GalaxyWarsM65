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