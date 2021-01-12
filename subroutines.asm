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
//** checkKeypressSpaceStartGame
//**************************************************************
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

//**************************************************************
//** checkKeypressRunStopGame
//**************************************************************
checkKeypressRunStopGame: {
            
        check_space:
            lda $d610               // Read ASCIIKEY at $d610 
            cmp #$03                // DEC 3 - RUN/STOP (need to be verified)
            bne check_keypress_end
            lda #$00                // write something into $d610 to clar
            sta $d610 
            jmp title_init          // jump to title_init

        check_keypress_end:
           
            rts

}

//**************************************************************
//** checkKeypressRunStopGame
//**************************************************************
checkKeypressEscStopGame: {
            
        check_space:
            lda $d610               // Read ASCIIKEY at $d610 
            cmp #$1b                // DEC 27 - ESC (need to be verified)
            bne check_keypress_end
            lda #$00                // write something into $d610 to clar
            sta $d610 
            jmp title_init          // jump to title_init

        check_keypress_end:
           
            rts

}

//**************************************************************
//** updateJoystickInput
//**************************************************************
updateJoystickInput: {
    
        // Up/Down not needed in a Space Invader's game
        /*
        up:     
                lda $dc00
                and #1
                bne down
                dec spr1y       // spr1 up
        down:   
                lda $dc00
                and #2
                bne left
                inc spr1y       // spr1 down
        */
        left:   
                lda $dc00       // $dc00 = Joystick Port2
                and #4
                bne right
                dec player1.pos_x       // spr1 left
                lda player1.pos_x
                cmp #$ff
                bne right
                dec player1.pos_x      //+1
        right:  
                lda $dc00
                and #8
                bne button   
                inc player1.pos_x
                bne button
                inc player1.pos_x       //spr1 right +1
        button: 
                lda $dc00
                and #16
                bne done
                inc $d020
        done:   
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