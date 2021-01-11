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

    sei
    lda #$37
    sta $01
  
    lda #$00
    ldx #<IRQ
    ldy #>IRQ
    stx $0314
    sty $0315
    sta $D012
    lda #$7F
    sta $DC0D
    lda #$1B
    sta $D011
    lda #$01
    sta $D01A
    cli
    jmp *

IRQ:
    inc $D019
    lda $DC0D
    sta $DD0D
    jsr RASTERBAR
    jmp $EA7E

RASTERBAR:
    lda #$aa // Set position of raster split
    cmp $D012  //to current raster position.
    bne *-3   // Jump back to cmp

    ldx #$00
RASTERLOOP:
    lda RASCOL,X
    ldy TIMING,X
    dey
    bne *-1   // Jump back to dey

    // sta $D020
    sta $D021
    inx
    cpx #TIMINGEND-TIMING // Or you could use RASCOLEND-RASCOL
    bne RASTERLOOP
    rts
//Table for raster colours
RASCOL: .byte $02,$0a,$07,$01,$03,$0e,$06,$00
RASCOLEND: .byte $00
//Table for raster timing (requires patience with flicker fixing)
//NOTE: In order to work out the timing for each raster line,
//you need to trigger a flicker to move left / right on current line
//according to the value of the raster position. This requires a lot
//of trial and error. It is very easy to time out each line, but
//can be a real pain now and then anyhow :)
TIMING: .byte $05,$08,$08,$08,08,$08,$08,$08
TIMINGEND: .byte $00



//**************************************************************
//** include subroutines (including macros)
//************************************************************** 
#import "subroutines.asm"           //** Include subroutines from subroutines.asm 