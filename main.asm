//**************************************************************
//** cpu select
//**************************************************************
.cpu _45gs02

//**************************************************************
//** include kick assembler macros
//**************************************************************
#import "./includes/m65macros.s"

//**************************************************************
//** Basic Start
//**************************************************************
BasicUpstart65(start)

//**************************************************************
//** Include MemoryMap Labels
//**************************************************************
#import "memory.asm"                //** include memory.asm file

//**************************************************************
//** Include bin files
//**************************************************************
*=SpritesMemory                     //** Pointer to sprites in memory
.import binary "assets/playership.bin"  // Load sprites from bin file

//**************************************************************
//** Include other asm files
//**************************************************************
#import "data.asm"                  //** include data definitions from data.asm
#import "strings.asm"               //** include strings perhaps I will translate it in a later stage easily

//**************************************************************
//** Program start
//**************************************************************
*=$2020 "GalaxyWars"

start:
    sei
    // VIC4 init to $d000 and enable it
    lda #$35
    sta $01
    enableVIC4Registers()           //** enable VIC4 registers and Mega65 IO from m65macros.s

    // Turn off H640 mode (switch to 320x200)
    lda $d031
    and #$7f
    sta $d031



    


main:
title_init:
    
    jsr ClearScreen                 // goto subroutine ClearScreen

    // Set border and background color
    ldx #BlackCol                   //** Load black color
    stx BGCOL0                      //** Store Black color in Background
    ldx #BlackCol                   //** Load black color ** (only needed when other color )
    stx EXTCOL                      //** Store black color in border

    // disable sprite0
    lda #%00000000
    sta SPENA

title_screen:
    //*******
    :print_at(12,11,txt_en_gametitle)   // Macro print_at Input: column, row, textstring
    :print_at(11,15,txt_en_starttitle)  // Print info
    //:print_at(1,1,$d610)


    jsr checkKeypressSpaceStartGame

    jmp title_screen
    cli
    rts

//**************************************************************
//** Game Files
//**************************************************************
#import "gameloop.asm"              //** Include gameloop


//**************************************************************
//** include subroutines (including macros)
//************************************************************** 
#import "subroutines.asm"           //** Include subroutines from subroutines.asm 
