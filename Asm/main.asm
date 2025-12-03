SECTION "Header", ROM0[$0100]
    nop
    jp main
    ds $150 - $104 ; alloc space for Nintendo Header

SECTION "tiles", ROM0
TileData:
    INCBIN "ASM/Hello-CharLight.bin"
TileDataEnd:

SECTION "tilemap_data", ROM0
TileMapData:

    ; ---------------
    ; | Hello world |
    ; ---------------
    db 1,3,4,4,5,0,2,5,6,4,7
    ds 32-11,0

    ds 32*32,0

TileMapDataEnd:


SECTION "main", ROM0
main:
    DI
    LD A, 0
    LDH [$FF40], A      ; 0 to $FF40 to turn off screen

    ; === Copy tiles to VRAM ===
    LD HL, TileData
    LD DE, $8000        ; set to start of VRAM
    LD BC, TileDataEnd - TileData  ; nb of bytes to copy

.copy_tiles:
    LD A, [HL]          ; get first byte
    LD [DE], A          ; copy A to DE ($8000)
    INC HL              ; go to the next byte in TileData
    INC DE              ; go to the next addr in vram
    DEC BC              ; dec BC (nb of bytes) by 1

    LD A, B
    OR C
    JR NZ, .copy_tiles  ; Continue if BC != 0

    ; === Copy TileMap to VRAM ===
    LD HL, TileMapData
    LD DE, $9800        ; Tilemap start at $9800
    LD BC, TileMapDataEnd - TileMapData ; Tilemap Size

.copy_tilemap:
    LD A, [HL+]
    LD [DE], A
    INC DE
    DEC BC
    LD A, B
    OR C
    JR NZ, .copy_tilemap

    LD A, %11100100     ; Palette
    LDH [$FF47], A

    LD A, %10010001     ; LCD ON + BG ON + tile data at $8000
    LDH [$FF40], A

.loop:
    HALT
    JP .loop

.wait_vblank:
    LDH A, [$FF44]
    CP 144
    JR C, .wait_vblank

    JR .loop
