//**************************************************************
//** Memory addresses C64 (VIC-II) / Mega65 (VIC-IV)
//**************************************************************

// Memory mapping locations
.label ScreenMemory = $0800         // M65:Screen memory 
.label ScreenBlock1 = $0800         // Location of screen block 1
.label ScreenBlock2 = $08FF         // Location of screen block 2
.label ScreenBlock3 = $09FE         // Location of screen block 3
.label ScreenBlock4 = $0AFD         // Location of screen block 4
.label SpritesMemory = $3000        // Sprites memory


// sprite addresses
.label SEPNA = $D015                // Sprite enable register
.label SP0X = $D000                 // Sprite 0 horizontal position
.label SP0Y = $D001                 // Sprite 0 vertical position
.label SP0COL = $D027               // Sprite 0 colour
.label SPSPCL = $D01E               // Sprite to sprite collision
.label SPBGCL = $D01F               // Sprite to background collision
.label SSDP0 =  $0BF8               // M65:Sprite 0 Datapointer

// joystick addresses
.label CIAPRA = $DC00               // Joystick port 2
.label CIAPRB = $DC01               // Joystick port 1

// screen addresses
.label EXTCOL = $D020               // Border color
.label BGCOL0 = $D021               // Background color 0
.label BGCOL1 = $D022               // Background color 1
.label BGCOL2 = $D023               // Background color 2
.label BGCOL3 = $D024               // Background color 3

// raster
.label RASTER = $d012               // Read current raster line

// character set
.label VSCMB = $D018                // VIC-II chip memory control register  //**
.label SCROLX = $D016               // Fine scrolling and scroll register