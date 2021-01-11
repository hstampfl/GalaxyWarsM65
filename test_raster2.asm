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
    
    lda #$32
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
    jsr RASTERS
    jmp $EA7E

//** Rasters
RASTERS:
    lda #$3a // Top raster position
    cmp $D012
    bne *-3
// Just for fun, let's display 64 raster bars

    
    ldx #$00
RASLOOP:
    lda COLOURTABLE,X //Read colour table
    ldy TIMINGTABLE,X //Read raster timing tables
    dey
    bne *-1
    
    //sta $D020 //Inside raster split display colour
    sta $D021 //bars.
    inx
    cpx #COLOURTABLEEND-COLOURTABLE
    bne RASLOOP
    //lda #$00
    //sta $D020
    //sta $D021
    rts

//Now set up the tables to display the raster colours (64 OF THEM)
COLOURTABLE:
    .byte $06,$0E,$03,$01,$03,$0E,$06,$00 //8 - BLUE
    .byte $02,$0A,$07,$01,$07,$0A,$02,$00 //16 -RED
    .byte $0B,$0C,$0F,$01,$0F,$0C,$0B,$00 //24 -SILVER
    .byte $09,$08,$07,$01,$07,$08,$09,$00 //32 -GOLD
    .byte $05,$03,$0D,$01,$0D,$03,$05,$00 //40 -GREEN
    .byte $06,$04,$0E,$01,$0E,$04,$06,$00 //48 -PURPLE
    .byte $08,$0A,$0F,$01,$0F,$0A,$08,$00 //56 -ORANGE
    .byte $02,$04,$0A,$01,$0A,$04,$02,$00 //64 -RED / PURPLE
COLOURTABLEEND:
    .byte $00

//Timing table for the raster colour bars (64 of them)
TIMINGTABLE:
    .byte $04,$08,$08,$08,$08,$08,$08,$08
    .byte $01,$08,$08,$08,$08,$08,$08,$08
    .byte $01,$08,$08,$08,$08,$08,$08,$08
    .byte $01,$08,$08,$08,$08,$08,$08,$08
    .byte $01,$08,$08,$08,$08,$08,$08,$08
    .byte $01,$08,$08,$08,$08,$08,$08,$08
    .byte $01,$08,$08,$08,$08,$08,$08,$08
    .byte $01,$08,$08,$08,$08,$08,$08,$09
TIMINGTABLEEND:
    .byte $00



//**************************************************************
//** include subroutines (including macros)
//************************************************************** 
#import "subroutines.asm"           //** Include subroutines from subroutines.asm 