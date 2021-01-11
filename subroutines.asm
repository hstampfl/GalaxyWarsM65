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

checkKeypressSpaceStartGame: {
            
        check_space:
            lda $d610               // Read ASCIIKEY at $d610 
            cmp #$20                // DEC 32 - SPACE
            bne check_keypress_end
            lda #$00                // write something into $d610 to clar
            sta $d610 
            jmp game_init

        check_keypress_end:
           
            rts

}

checkKeypressRunStopGame: {
            
        check_space:
            lda $d610               // Read ASCIIKEY at $d610 
            cmp #$03                // DEC 03 - RUN/STOP (need to be verified)
            bne check_keypress_end
            lda #$00                // write something into $d610 to clar
            sta $d610 
            jmp title_init          // jump to title_init

        check_keypress_end:
           
            rts

}

//**************************************************************
//** print text at position
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