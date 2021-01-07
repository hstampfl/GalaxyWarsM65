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

    // VIC4 init to $d000 and enable it
    lda #$35
    sta $01
    enableVIC4Registers()           //** enable VIC4 registers from m65macros.s

    // Turn off H640 mode (switch to 320x200)
    lda $d031
    and #$7f
    sta $d031

    jsr ClearScreen

    // Set border and background color
    ldx #BlackCol                   //** Load black color
    stx BGCOL0                      //** Store Black color in Background
    ldx #BlackCol                   //** Load black color ** (only needed when other color )
    stx EXTCOL                      //** Store black color in border


main:
title_screen:
    //*******
    :print_at(12,12,txt_en_gametitle)   // Macro print_at Input: column, row, textstring

    jmp title_screen
    rts



//**************************************************************
//** include subroutines (including macros)
//************************************************************** 
#import "subroutines.asm"           //** Include subroutines from subroutines.asm 