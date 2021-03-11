SECTION "rom",ROM0
; $0000 - $003F: RST handlers.
ret
REPT 7
    nop
ENDR
; $0008
ret
REPT 7
    nop
ENDR
; $0010
ret
REPT 7
    nop
ENDR
; $0018
ret
REPT 7
    nop
ENDR
; $0020
ret
REPT 7
    nop
ENDR
; $0028
ret
REPT 7
    nop
ENDR
; $0030
ret
REPT 7
    nop
ENDR
; $0038
ret
REPT 7
    nop
ENDR
SECTION "interrupts",ROM0[$0040]
; $0040 - $0067: Interrupt handlers.
; $0040
call $FF80
call BG_selector_write
REPT 2
    nop
ENDR
; $0048
jp stat
REPT 5
    nop
ENDR
; $0050
jp timer
REPT 5
    nop
ENDR
; $0058
jp serial
REPT 5
    nop
ENDR
; $0060
jp joypad
REPT 5
    nop
ENDR
; $0068 - $00FF: Free space.
DS $98
; $0100 - $0103: Startup handler.
nop
jp main
; $0104 - $0133: The Nintendo Logo.
DB $CE, $ED, $66, $66, $CC, $0D, $00, $0B
DB $03, $73, $00, $83, $00, $0C, $00, $0D
DB $00, $08, $11, $1F, $88, $89, $00, $0E
DB $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99
DB $BB, $BB, $67, $63, $6E, $0E, $EC, $CC
DB $DD, $DC, $99, $9F, $BB, $B9, $33, $3E
; $0134 - $013E: The title, in upper-case letters, followed by zeroes.
DB "TEST"
DS 7 ; padding
; $013F - $0142: The manufacturer code.
DS 4
; $0143: Gameboy Color compatibility flag.    
GBC_UNSUPPORTED EQU $00
GBC_COMPATIBLE EQU $80
GBC_EXCLUSIVE EQU $C0
DB GBC_UNSUPPORTED
; $0144 - $0145: "New" Licensee Code, a two character name.
DB "OK"
; $0146: Super Gameboy compatibility flag.
SGB_UNSUPPORTED EQU $00
SGB_SUPPORTED EQU $03
DB SGB_UNSUPPORTED
; $0147: Cartridge type. Either no ROM or MBC5 is recommended.
CART_ROM_ONLY EQU $00
CART_MBC1 EQU $01
CART_MBC1_RAM EQU $02
CART_MBC1_RAM_BATTERY EQU $03
CART_MBC2 EQU $05
CART_MBC2_BATTERY EQU $06
CART_ROM_RAM EQU $08
CART_ROM_RAM_BATTERY EQU $09
CART_MMM01 EQU $0B
CART_MMM01_RAM EQU $0C
CART_MMM01_RAM_BATTERY EQU $0D
CART_MBC3_TIMER_BATTERY EQU $0F
CART_MBC3_TIMER_RAM_BATTERY EQU $10
CART_MBC3 EQU $11
CART_MBC3_RAM EQU $12
CART_MBC3_RAM_BATTERY EQU $13
CART_MBC4 EQU $15
CART_MBC4_RAM EQU $16
CART_MBC4_RAM_BATTERY EQU $17
CART_MBC5 EQU $19
CART_MBC5_RAM EQU $1A
CART_MBC5_RAM_BATTERY EQU $1B
CART_MBC5_RUMBLE EQU $1C
CART_MBC5_RUMBLE_RAM EQU $1D
CART_MBC5_RUMBLE_RAM_BATTERY EQU $1E
CART_POCKET_CAMERA EQU $FC
CART_BANDAI_TAMA5 EQU $FD
CART_HUC3 EQU $FE
CART_HUC1_RAM_BATTERY EQU $FF
DB CART_ROM_ONLY
; $0148: Rom size.
ROM_32K EQU $00
ROM_64K EQU $01
ROM_128K EQU $02
ROM_256K EQU $03
ROM_512K EQU $04
ROM_1024K EQU $05
ROM_2048K EQU $06
ROM_4096K EQU $07
ROM_1152K EQU $52
ROM_1280K EQU $53
ROM_1536K EQU $54
DB ROM_32K
; $0149: Ram size.
RAM_NONE EQU $00
RAM_2K EQU $01
RAM_8K EQU $02
RAM_32K EQU $03
DB RAM_NONE
; $014A: Destination code.
DEST_JAPAN EQU $00
DEST_INTERNATIONAL EQU $01
DB DEST_INTERNATIONAL
; $014B: Old licensee code.
; $33 indicates new license code will be used.
; $33 must be used for SGB games.
DB $33
; $014C: ROM version number
DB $00
; $014D: Header checksum.
; Assembler needs to patch this.
DB $FF
; $014E- $014F: Global checksum.
; Assembler needs to patch this.
DW $FACE
; $0150: Code!
main:
	ld SP, $E000	; Set Stack
	call clear_HRAM
	call DMA_Copy
	;ld [hl], $D9
	ld hl, $FF40
	ld [hl], $00
	
	call clear_OAM

	EI
	

	
	ld hl, $9000 + 16
	ld de, bg_tile_0000
	call write_sprite_16
	
	ld de, bg_tile_0001
	call write_sprite_16
	
	ld de, bg_tile_0002
	call write_sprite_16
	
	ld de, bg_tile_0003
	call write_sprite_16

	ld de, bg_tile_0004
	call write_sprite_16
	
	ld de, bg_tile_0005
	call write_sprite_16
	
	ld de, bg_tile_0006
	call write_sprite_16
	
	ld de, bg_tile_0007
	call write_sprite_16
	
	ld de, bg_tile_0008
	call write_sprite_16
	
	ld de, bg_tile_0009
	call write_sprite_16
	
	ld de, circle_00
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	
	ld de, minus_bg
	call write_sprite_16
	
	ld de, plus_bg
	call write_sprite_16
	
	ld de, seven_bg
	call write_sprite_16
	
	ld de, eight_bg
	call write_sprite_16
	
	ld de, nine_bg
	call write_sprite_16
	
	ld de, four_bg
	call write_sprite_16
	
	ld de, five_bg
	call write_sprite_16
	
	ld de, six_bg
	call write_sprite_16
	
	ld de, one_bg
	call write_sprite_16
	
	ld de, two_bg
	call write_sprite_16
	
	ld de, three_bg
	call write_sprite_16
	
	ld de, zero_bg
	call write_sprite_16
	
	ld de, multiply_bg
	call write_sprite_16
	
	ld de, divide_bg
	call write_sprite_16
	
	ld de, blank_bg
	call write_sprite_16
	
	ld de, window_00
	call write_sprite
	call write_sprite
	
	ld de, window_02
	call write_sprite_16
	
	ld de, select_00
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	call write_sprite
	
	ld de, seven_16x16
	ld hl, $81A0
	call write_sprite_16
	ld de, eight_16x16
	call write_sprite_16
	ld de, four_16x16
	call write_sprite_16
	ld de, nine_16x16
	call write_sprite_16
	
	ld a, $80
	ld hl, input_digit_0
	ld [hl+], a
	ld [hl+], a
	ld [hl+], a
	ld [hl+], a
	ld [hl+], a
	ld [hl+], a
	ld [hl+], a
	ld [hl+], a
	ld [hl+], a
	ld [hl+], a
	
	jp window_settings
;============================================
; Copies DMA-OAM function to HRAM ($FF80)
; returns nothing	
DMA_Copy:
	ld hl, $FF80
	ld de, oam_inst
	ld b, $0C
.loop
	ld a, [de]
	ld [hl+], a
	inc de
	dec b
	ld a, b
	jp nz, .loop
	ret
;============================================

;============================================
; Clears memory addresses $FE00 - $FE9F
; returns nothing
clear_OAM:
	ld hl, $FE00
	ld a, $9F
.loop:
	ld [hl], 0
	inc hl
	dec a
	jp nz, .loop
	ret
;============================================

;============================================
; Clears memory addresses $FF80 - FFFE
; returns nothing
clear_HRAM:
	ld hl, $FF80
	ld a, $7E
.loop:
	ld [hl], 0
	inc hl
	dec a
	jp nz, .loop
	ret
;============================================

;============================================
; Writes sprite data to location in tile map
; de => 8x8 spite
; hl => address to write to
; returns nothing
write_sprite:
	ld b, 16
.loop
	ld a, [de]
	inc de
	ld [hl+], a
	dec b
	jp nz, .loop
	ret
;============================================

;============================================
; Writes sprite data to location in tile map
; de => 16x16 spite
; hl => address to write to
; returns nothing
write_sprite_16:
	ld b, 64
.loop
	ld a, [de]
	inc de
	ld [hl+], a
	dec b
	jp nz, .loop
	ret
;============================================

;============================================
; Writes OAM data to location in RAM
; b => top left corner x coordinate
; c => top left corner y coordinate
; d => sprite number to draw (assume 4 in a row)
; e => attribute settings
; hl => starting address to write to in OAM
; returns nothing
OAM_Data_w1616:
	push af
	ld [hl], c
	inc hl
	ld [hl], b
	inc hl
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld a, c
	add a, 8
	inc d
	ld [hl], a
	inc hl
	ld [hl], b
	inc hl
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld a, b
	add a, 8
	ld b, a
	ld a, c
	add a, 8
	inc d
	ld [hl], c
	inc hl
	ld [hl], b
	inc hl
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	inc d	
	ld [hl], a
	inc hl
	ld [hl], b
	inc hl
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	pop af
	ret
;============================================

;============================================
; Writes header tiles to BG
; returns nothing
BG_header_write:
	ld [hl+], a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [de], a
	inc a
	inc a
	inc e
	ld [de], a
	inc a
	inc e
	ret
;============================================

;============================================
; Writes Circle top to BG
; returns nothing
BG_circle_write_top:
	ld d, 5
	ld b, a
.loop
	ld a, b
	ld [hl+], a
	inc a
	ld [hl+], a
	inc a
	ld [hl+], a
	inc a
	ld [hl+], a
	dec d
	jp nz, .loop
	ret
;============================================

;============================================
; Writes Circle top to BG
; returns nothing
BG_circle_write_bottom:
	ld d, 5
	ld b, a
.loop
	ld a, b
	ld [hl+], a
	dec a
	ld [hl+], a
	dec a
	ld [hl+], a
	dec a
	ld [hl+], a
	dec d
	jp nz, .loop
	ret
;============================================

;============================================
; Writes Circle top to BG
; returns nothing
BG_circle_write_upper:
	ld d, 5
	ld b, a
.loop
	ld a, b
	ld [hl+], a
	inc hl
	inc hl
	add a, 5
	ld [hl+], a
	dec d
	jp nz, .loop
	ret
;============================================

;============================================
; Writes Circle top to BG
; returns nothing
BG_circle_write_lower:
	ld d, 5
	ld b, a
.loop
	ld a, b
	ld [hl+], a
	inc hl
	inc hl
	sub a, 5
	ld [hl+], a
	dec d
	jp nz, .loop
	ret
;============================================

;============================================
; Chooses which tiles to write for selector
; a => value of new_state_value
; returns nothing
BG_selector_erase:
	ld hl, old_cursor_location
	ld a, [hl]
	inc hl
	ld b, [hl]
	bit 0, a
	jp z, .n_zero
.zero:
	ld hl, $98E0
	ld a, $29
	ld [hl], a
	ld hl, $98C1
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98E3
	inc a
	inc a
	ld [hl], a
	ld hl, $9903
	inc a
	ld [hl], a
	ld hl, $9921
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9900
	ld [hl], a
	jp .end
.n_zero:
	bit 1, a
	jp z, .n_one
.one:
	ld hl, $98E4
	ld a, $29
	ld [hl], a
	ld hl, $98C5
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98E7
	inc a
	inc a
	ld [hl], a
	ld hl, $9907
	inc a
	ld [hl], a
	ld hl, $9925
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9904
	ld [hl], a
	jp .end
.n_one:
	bit 2, a
	jp z, .n_two
.two:
	ld hl, $98E8
	ld a, $29
	ld [hl], a
	ld hl, $98C9
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98EB
	inc a
	inc a
	ld [hl], a
	ld hl, $990B
	inc a
	ld [hl], a
	ld hl, $9929
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9908
	ld [hl], a
	jp .end
.n_two:
	bit 3, a
	jp z, .n_three
.three:
	ld hl, $98EC
	ld a, $29
	ld [hl], a
	ld hl, $98CD
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98EF
	inc a
	inc a
	ld [hl], a
	ld hl, $990F
	inc a
	ld [hl], a
	ld hl, $992D
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $990C
	ld [hl], a
	jp .end
.n_three:
	bit 4, a
	jp z, .n_four
.four:
	ld hl, $98F0
	ld a, $29
	ld [hl], a
	ld hl, $98D1
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98F3
	inc a
	inc a
	ld [hl], a
	ld hl, $9913
	inc a
	ld [hl], a
	ld hl, $9931
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9910
	ld [hl], a
	jp .end
.n_four:
	bit 5, a
	jp z, .n_five
.five:
	ld hl, $9960
	ld a, $29
	ld [hl], a
	ld hl, $9941
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $9963
	inc a
	inc a
	ld [hl], a
	ld hl, $9983
	inc a
	ld [hl], a
	ld hl, $99A1
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9980
	ld [hl], a
	jp .end
.n_five:
	bit 6, a
	jp z, .n_six
.six:
	ld hl, $9964
	ld a, $29
	ld [hl], a
	ld hl, $9945
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $9967
	inc a
	inc a
	ld [hl], a
	ld hl, $9987
	inc a
	ld [hl], a
	ld hl, $99A5
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9984
	ld [hl], a
	jp .end
.n_six:
	bit 7, a
	jp z, .n_seven
.seven:
	ld hl, $9968
	ld a, $29
	ld [hl], a
	ld hl, $9949
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $996B
	inc a
	inc a
	ld [hl], a
	ld hl, $998B
	inc a
	ld [hl], a
	ld hl, $99A9
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9988
	ld [hl], a
	jp .end
.n_seven:
	ld a, b
	bit 0, a
	jp z, .n_eight
.eight:
	ld hl, $996C
	ld a, $29
	ld [hl], a
	ld hl, $994D
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $996F
	inc a
	inc a
	ld [hl], a
	ld hl, $998F
	inc a
	ld [hl], a
	ld hl, $99AD
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $998C
	ld [hl], a
	jp .end
.n_eight:
	bit 1, a
	jp z, .n_nine
.nine:
	ld hl, $9970
	ld a, $29
	ld [hl], a
	ld hl, $9951
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $9973
	inc a
	inc a
	ld [hl], a
	ld hl, $9993
	inc a
	ld [hl], a
	ld hl, $99B1
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9990
	ld [hl], a
	jp .end
.n_nine:
	bit 2, a
	jp z, .n_ten
.ten:
	ld hl, $99E0
	ld a, $29
	ld [hl], a
	ld hl, $99C1
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99E3
	inc a
	inc a
	ld [hl], a
	ld hl, $9A03
	inc a
	ld [hl], a
	ld hl, $9A21
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9A00
	ld [hl], a
	jp .end
.n_ten:
	bit 3, a
	jp z, .n_eleven
.eleven:
	ld hl, $99E4
	ld a, $29
	ld [hl], a
	ld hl, $99C5
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99E7
	inc a
	inc a
	ld [hl], a
	ld hl, $9A07
	inc a
	ld [hl], a
	ld hl, $9A25
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9A04
	ld [hl], a
	jp .end
.n_eleven:
	bit 4, a
	jp z, .n_twelve
.twelve:
	ld hl, $99E8
	ld a, $29
	ld [hl], a
	ld hl, $99C9
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99EB
	inc a
	inc a
	ld [hl], a
	ld hl, $9A0B
	inc a
	ld [hl], a
	ld hl, $9A29
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9A08
	ld [hl], a
	jp .end
.n_twelve:
	bit 5, a
	jp z, .n_thirteen
.thirteen:
	ld hl, $99EC
	ld a, $29
	ld [hl], a
	ld hl, $99CD
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99EF
	inc a
	inc a
	ld [hl], a
	ld hl, $9A0F
	inc a
	ld [hl], a
	ld hl, $9A2D
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9A0C
	ld [hl], a
	jp .end
.n_thirteen:
	bit 6, a
	jp z, .n_fourteen
.fourteen:
	ld hl, $99F0
	ld a, $29
	ld [hl], a
	ld hl, $99D1
	inc a
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99F3
	inc a
	inc a
	ld [hl], a
	ld hl, $9A13
	inc a
	ld [hl], a
	ld hl, $9A31
	inc a
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	inc a
	ld hl, $9A10
	ld [hl], a
	jp .end
.n_fourteen:
.end:
	ret
;============================================

;============================================
; Chooses which tiles to write for selector
; a => value of new_state_value
; b => upper bits of new_state_value
; returns nothing
BG_selector_write:
	push hl
	push af
	push bc
	ld hl, new_cursor_location
	ld a, [hl]
	inc hl
	ld b, [hl]
	bit 0, a
	jp z, .n_zero
.zero:
	ld hl, $98E0
	ld a, $77
	ld [hl], a
	ld hl, $98C1
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98E3
	inc a
	ld [hl], a
	ld hl, $9903
	inc a
	ld [hl], a
	ld hl, $9921
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9900
	ld [hl], a
	jp .end
.n_zero:
	bit 1, a
	jp z, .n_one
.one:
	ld hl, $98E4
	ld a, $77
	ld [hl], a
	ld hl, $98C5
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98E7
	inc a
	ld [hl], a
	ld hl, $9907
	inc a
	ld [hl], a
	ld hl, $9925
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9904
	ld [hl], a
	jp .end
.n_one:
	bit 2, a
	jp z, .n_two
.two:
	ld hl, $98E8
	ld a, $77
	ld [hl], a
	ld hl, $98C9
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98EB
	inc a
	ld [hl], a
	ld hl, $990B
	inc a
	ld [hl], a
	ld hl, $9929
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9908
	ld [hl], a
	jp .end
.n_two:
	bit 3, a
	jp z, .n_three
.three:
	ld hl, $98EC
	ld a, $77
	ld [hl], a
	ld hl, $98CD
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98EF
	inc a
	ld [hl], a
	ld hl, $990F
	inc a
	ld [hl], a
	ld hl, $992D
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $990C
	ld [hl], a
	jp .end
.n_three:
	bit 4, a
	jp z, .n_four
.four:
	ld hl, $98F0
	ld a, $77
	ld [hl], a
	ld hl, $98D1
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $98F3
	inc a
	ld [hl], a
	ld hl, $9913
	inc a
	ld [hl], a
	ld hl, $9931
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9910
	ld [hl], a
	jp .end
.n_four:
	bit 5, a
	jp z, .n_five
.five:
	ld hl, $9960
	ld a, $77
	ld [hl], a
	ld hl, $9941
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $9963
	inc a
	ld [hl], a
	ld hl, $9983
	inc a
	ld [hl], a
	ld hl, $99A1
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9980
	ld [hl], a
	jp .end
.n_five:
	bit 6, a
	jp z, .n_six
.six:
	ld hl, $9964
	ld a, $77
	ld [hl], a
	ld hl, $9945
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $9967
	inc a
	ld [hl], a
	ld hl, $9987
	inc a
	ld [hl], a
	ld hl, $99A5
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9984
	ld [hl], a
	jp .end
.n_six:
	bit 7, a
	jp z, .n_seven
.seven:
	ld hl, $9968
	ld a, $77
	ld [hl], a
	ld hl, $9949
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $996B
	inc a
	ld [hl], a
	ld hl, $998B
	inc a
	ld [hl], a
	ld hl, $99A9
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9988
	ld [hl], a
	jp .end
.n_seven:
	ld a, b
	bit 0, a
	jp z, .n_eight
.eight:
	ld hl, $996C
	ld a, $77
	ld [hl], a
	ld hl, $994D
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $996F
	inc a
	ld [hl], a
	ld hl, $998F
	inc a
	ld [hl], a
	ld hl, $99AD
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $998C
	ld [hl], a
	jp .end
.n_eight:
	bit 1, a
	jp z, .n_nine
.nine:
	ld hl, $9970
	ld a, $77
	ld [hl], a
	ld hl, $9951
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $9973
	inc a
	ld [hl], a
	ld hl, $9993
	inc a
	ld [hl], a
	ld hl, $99B1
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9990
	ld [hl], a
	jp .end
.n_nine:
	bit 2, a
	jp z, .n_ten
.ten:
	ld hl, $99E0
	ld a, $77
	ld [hl], a
	ld hl, $99C1
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99E3
	inc a
	ld [hl], a
	ld hl, $9A03
	inc a
	ld [hl], a
	ld hl, $9A21
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9A00
	ld [hl], a
	jp .end
.n_ten:
	bit 3, a
	jp z, .n_eleven
.eleven:
	ld hl, $99E4
	ld a, $77
	ld [hl], a
	ld hl, $99C5
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99E7
	inc a
	ld [hl], a
	ld hl, $9A07
	inc a
	ld [hl], a
	ld hl, $9A25
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9A04
	ld [hl], a
	jp .end
.n_eleven:
	bit 4, a
	jp z, .n_twelve
.twelve:
	ld hl, $99E8
	ld a, $77
	ld [hl], a
	ld hl, $99C9
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99EB
	inc a
	ld [hl], a
	ld hl, $9A0B
	inc a
	ld [hl], a
	ld hl, $9A29
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9A08
	ld [hl], a
	jp .end
.n_twelve:
	bit 5, a
	jp z, .n_thirteen
.thirteen:
	ld hl, $99EC
	ld a, $77
	ld [hl], a
	ld hl, $99CD
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99EF
	inc a
	ld [hl], a
	ld hl, $9A0F
	inc a
	ld [hl], a
	ld hl, $9A2D
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9A0C
	ld [hl], a
	jp .end
.n_thirteen:
	bit 6, a
	jp z, .n_fourteen
.fourteen:
	ld hl, $99F0
	ld a, $77
	ld [hl], a
	ld hl, $99D1
	inc a
	ld [hl+], a
	inc a
	ld [hl], a
	ld hl, $99F3
	inc a
	ld [hl], a
	ld hl, $9A13
	inc a
	ld [hl], a
	ld hl, $9A31
	inc a
	inc a
	ld [hl+], a
	dec a
	ld [hl], a
	inc a
	inc a
	ld hl, $9A10
	ld [hl], a
	jp .end
.n_fourteen:
.end:
    call BG_selector_erase
	pop bc
	pop af
	pop hl
	ret
;============================================

;============================================
; Writes window tiles to BG
; returns nothing
BG_window_write:
	ld hl, $9880
	ld a, $71
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl], a
	ld hl, $9881
	ld a, $72
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl+], a
	inc hl
	ld [hl], a
	; Writes | | bg
	ld hl, $9840
	ld de, $9860
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $9842
	ld de, $9862
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $9844
	ld de, $9864
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $9846
	ld de, $9866
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $9848
	ld de, $9868
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $984A
	ld de, $986A
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $984C
	ld de, $986C
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $984E
	ld de, $986E
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $9850
	ld de, $9870
	ld a, $73
	call BG_header_write
	; Writes | | bg
	ld hl, $9852
	ld de, $9872
	ld a, $73
	call BG_header_write
	ret
;============================================

;============================================
; Writes keypad symbols to BG
; returns nothing
BG_keypad_write:
	; Writes - button
	ld hl, $98E1
	ld de, $9901
	ld a, $35
	call BG_header_write
	
	; Writes + button
	ld hl, $9961
	ld de, $9981
	ld a, $39
	call BG_header_write
	
	; Writes 7 button
	ld hl, $98E5
	ld de, $9905
	ld a, $3D
	call BG_header_write
	
	; Writes 8 button
	ld hl, $98E9
	ld de, $9909
	ld a, $41
	call BG_header_write
	
	; Writes 9 button
	ld hl, $98ED
	ld de, $990D
	ld a, $45
	call BG_header_write
	
	; Writes 4 button
	ld hl, $9965
	ld de, $9985
	ld a, $49
	call BG_header_write
	
	; Writes 5 button
	ld hl, $9969
	ld de, $9989
	ld a, $4D
	call BG_header_write
	
	; Writes 6 button
	ld hl, $996D
	ld de, $998D
	ld a, $51
	call BG_header_write
	
	; Writes 1 button
	ld hl, $99E5
	ld de, $9A05
	ld a, $55
	call BG_header_write
	
	; Writes 2 button
	ld hl, $99E9
	ld de, $9A09
	ld a, $59
	call BG_header_write
	
	; Writes 3 button
	ld hl, $99ED
	ld de, $9A0D
	ld a, $5D
	call BG_header_write
	
	; Writes 0 button
	ld hl, $99E1
	ld de, $9A01
	ld a, $61
	call BG_header_write
	
	; Writes * button
	ld hl, $9971
	ld de, $9991
	ld a, $65
	call BG_header_write
	
	; Writes / button
	ld hl, $98F1
	ld de, $9911
	ld a, $69
	call BG_header_write
	
	; Writes _ button
	ld hl, $99F1
	ld de, $9A11
	ld a, $6D
	call BG_header_write
	ret
;============================================



window_settings:
	
	ld hl, $9800   ;Top Left Pixel = bg_sprite1
	ld de, $9820
	ld a, $01
	call BG_header_write
	call BG_header_write
	call BG_header_write
	call BG_header_write
	call BG_header_write
	call BG_header_write
	call BG_header_write
	call BG_header_write
	call BG_header_write
	call BG_header_write
	
	ld hl, $98C0
	ld a, $2A
	call BG_circle_write_top
	
	ld hl, $98E0
	ld a, $29
	call BG_circle_write_upper
	
	ld hl, $9900
	ld a, $34
	call BG_circle_write_lower
	
	ld hl, $9920
	ld a, $33
	call BG_circle_write_bottom
	
	ld hl, $9940
	ld a, $2A
	call BG_circle_write_top
	
	ld hl, $9960
	ld a, $29
	call BG_circle_write_upper
	
	ld hl, $9980
	ld a, $34
	call BG_circle_write_lower
	
	ld hl, $99A0
	ld a, $33
	call BG_circle_write_bottom
	
	ld hl, $99C0
	ld a, $2A
	call BG_circle_write_top
	
	ld hl, $99E0
	ld a, $29
	call BG_circle_write_upper
	
	ld hl, $9A00
	ld a, $34
	call BG_circle_write_lower
	
	ld hl, $9A20
	ld a, $33
	call BG_circle_write_bottom
	
	
	
	
	call BG_keypad_write
	call BG_window_write
	ld a, $01
	ld b, $00
	ld hl, new_cursor_location
	ld [hl+], a
	ld [hl], b
	call BG_selector_write
	ld a, $01
	ld [calc_state], a

	
	
	
	

	
	ld hl, $FF47 	;Background Palette
	ld [hl], $E4
	
	ld hl, $FF48 	;Obj Palette 0
	ld [hl], $E4
	
	ld hl, $FF49 	;Obj Palette 1
	ld [hl], $E4

	ld hl, $FF40 	;Turn on Display
	ld [hl], $83
	
	
	ld d, $1C
	ld e, $1C
	ld hl, $FFFF
	ld [hl], $01
	;call $FF80
	jp end

;============================================
; Move state right
; returns nothing

move_right:
	push af
	push hl
	push bc
	ld hl, new_cursor_location
	ld a, [hl]
	inc hl
	ld b, [hl]
	bit 4, a
	jp nz, .end
	bit 1, b
	jp nz, .end
	bit 6, b
	jp nz, .end
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	bit 7, a
	jp nz, .a_to_b
	sla a
	sla b
	ld hl, new_cursor_location
	ld [hl+], a
	ld [hl], b
	jp .end
.a_to_b:
	ld a, $00
	ld b, $01
	ld hl, new_cursor_location
	ld [hl+], a
	ld [hl], b
.end:
	pop bc
	pop hl
	pop af
	ret
;============================================

;============================================
; Move state left
; returns nothing

move_left:
	push af
	push hl
	push bc
	ld hl, new_cursor_location
	ld a, [hl]
	inc hl
	ld b, [hl]
	bit 0, a
	jp nz, .end
	bit 5, a
	jp nz, .end
	bit 2, b
	jp nz, .end
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	bit 0, b
	jp nz, .b_to_a
	srl a
	srl b
	ld hl, new_cursor_location
	ld [hl+], a
	ld [hl], b
	jp .end
.b_to_a:
	ld a, $80
	ld b, $00
	ld hl, new_cursor_location
	ld [hl+], a
	ld [hl], b
.end:
	pop bc
	pop hl
	pop af
	ret
;============================================

;============================================
; Move state down
; returns nothing

move_down:
	push af
	push hl
	push bc
	ld hl, new_cursor_location
	ld a, [hl]
	inc hl
	ld b, [hl]
	bit 0, a
	jp nz, .shift_a_down
	bit 1, a
	jp nz, .shift_a_down
	bit 2, a
	jp nz, .shift_a_down
	bit 3, a
	jp nz, .three
	bit 4, a
	jp nz, .four
	bit 5, a
	jp nz, .five
	bit 6, a
	jp nz, .six
	bit 7, a
	jp nz, .seven
	bit 0, b
	jp nz, .zero
	bit 1, b
	jp nz, .one
	jp .end
.shift_a_down:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	sla a
	sla a
	sla a
	sla a
	sla a
	ld b, $00
	jp .end
.zero:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $20
	jp .end
.one:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $40
	jp .end
.three:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $01
	jp .end
.four:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $02
	jp .end
.five:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $04
	jp .end
.six:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $08
	jp .end
.seven:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $10
.end:
	ld hl, new_cursor_location
	ld [hl+], a
	ld [hl], b
	pop bc
	pop hl
	pop af
	ret
;============================================

;============================================
; Move state up
; returns nothing

move_up:
	push af
	push hl
	push bc
	ld hl, new_cursor_location
	ld a, [hl]
	inc hl
	ld b, [hl]
	bit 0, b
	jp nz, .zero
	bit 1, b
	jp nz, .one
	bit 2, b
	jp nz, .two
	bit 3, b
	jp nz, .three
	bit 4, b
	jp nz, .four
	bit 5, b
	jp nz, .five
	bit 6, b
	jp nz, .six
	bit 5, a
	jp nz, .shift_a_down
	bit 6, a
	jp nz, .shift_a_down
	bit 7, a
	jp nz, .shift_a_down
	jp .end
.shift_a_down:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	srl a
	srl a
	srl a
	srl a
	srl a
	ld b, $00
	jp .end
.zero:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $08
	ld b, $00
	jp .end
.one:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $10
	ld b, $00
	jp .end
.two:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $20
	ld b, $00
	jp .end
.three:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $40
	ld b, $00
	jp .end
.four:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $80
	ld b, $00
	jp .end
.five:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $01
	jp .end
.six:
	ld hl, old_cursor_location
	ld [hl+], a
	ld [hl], b
	ld a, $00
	ld b, $02
.end:
	ld hl, new_cursor_location
	ld [hl+], a
	ld [hl], b
	pop bc
	pop hl
	pop af
	ret
;============================================

;============================================
; Renders digits to screen based on values in input_digit_0-9
; returns nothing
update_calc_oam:
	push af
	ld de, input_digit_0
	ld a, 10
.loop:
	cp a, 1
	jp nz, .n_pos_zero
.pos_zero:
	ld b, $07
	ld c, $20
	ld hl, digit_nine_oam
	jp .number_to_display
.n_pos_zero:
	cp a, 2
	jp nz, .n_pos_one
.pos_one:
	ld b, $17
	ld c, $30
	ld hl, digit_eight_oam
	jp .number_to_display
.n_pos_one:
	cp a, 3
	jp nz, .n_pos_two
.pos_two:
	ld b, $27
	ld c, $20
	ld hl, digit_seven_oam
	jp .number_to_display
.n_pos_two:
	cp a, 4
	jp nz, .n_pos_three
.pos_three:
	ld b, $37
	ld c, $30
	ld hl, digit_six_oam
	jp .number_to_display
.n_pos_three:
	cp a, 5
	jp nz, .n_pos_four
.pos_four:
	ld b, $47
	ld c, $20
	ld hl, digit_five_oam
	jp .number_to_display
.n_pos_four:
	cp a, 6
	jp nz, .n_pos_five
.pos_five:
	ld b, $57
	ld c, $30
	ld hl, digit_four_oam
	jp .number_to_display
.n_pos_five:
	cp a, 7
	jp nz, .n_pos_six
.pos_six:
	ld b, $67
	ld c, $20
	ld hl, digit_three_oam
	jp .number_to_display
.n_pos_six:
	cp a, 8
	jp nz, .n_pos_seven
.pos_seven:
	ld b, $77
	ld c, $30
	ld hl, digit_two_oam
	jp .number_to_display
.n_pos_seven:
	cp a, 9
	jp nz, .n_pos_eight
.pos_eight:
	ld b, $87
	ld c, $20
	ld hl, digit_one_oam
	jp .number_to_display
.n_pos_eight:
	cp a, 10
	jp nz, .n_pos_nine
.pos_nine:
	ld b, $97
	ld c, $30
	ld hl, digit_zero_oam
	jp .number_to_display
.n_pos_nine:



.number_to_display
	push af
	ld a, [de]
	bit 7, a
	jp nz, .skip
	push de
	cp a, 0
	jp nz, .n_zero
.zero:
	jp .write
.n_zero:
	cp a, 1
	jp nz, .n_one
.one:
	jp .write
.n_one:
	cp a, 2
	jp nz, .n_two
.two:
	jp .write
.n_two:
	cp a, 3
	jp nz, .n_three
.three:
	jp .write
.n_three:
	cp a, 4
	jp nz, .n_four
.four:
	ld d, $22
	jp .write
.n_four:
	cp a, 5
	jp nz, .n_five
.five:
	jp .write
.n_five:
	cp a, 6
	jp nz, .n_six
.six:
	jp .write
.n_six:
	cp a, 7
	jp nz, .n_seven
.seven:
	ld d, $1A
	jp .write
.n_seven:
	cp a, 8
	jp nz, .n_eight
.eight:
	ld d, $1E
	jp .write
.n_eight:
	cp a, 9
	jp nz, .n_nine
.nine:
	ld d, $26
	jp .write
.n_nine:
	
.write:
	ld e, $00
	call OAM_Data_w1616
	pop de
.skip:
	pop af
	inc de
	dec a
	jp nz, .loop
	pop af
	ret
;============================================

;============================================
; Adds digit to LSD position, shifting rest left
; returns nothing
add_digit_to_operand:
	push af
	ld de, input_digit_8
	ld hl, input_digit_9
	ld b, 9
.loop:
	ld a, [de]
	dec de
	ld [hl], a
	dec hl
	dec b
	jp nz, .loop
	pop af
	ldh [input_digit_0], a
	ret
;============================================

;============================================
; Logic for calculator state zero
; returns nothing
calc_state_zero:
	bit 1, a
	jp z, .n_seven
.seven:
	call add_digit_to_operand
	ld hl, input_digit_0
	ld [hl], $07
	jp .end
.n_seven:
	bit 2, a
	jp z, .n_eight
.eight:
	call add_digit_to_operand
	ld hl, input_digit_0
	ld [hl], $08
	jp .end
.n_eight:
	bit 3, a
	jp z, .n_nine
.nine:
	call add_digit_to_operand
	ld hl, input_digit_0
	ld [hl], $09
	jp .end
.n_nine:
	bit 6, a
	jp z, .n_four
.four:
	call add_digit_to_operand
	ld hl, input_digit_0
	ld [hl], $04
	jp .end
.n_four:
.end:
	ret
;============================================

;============================================
; Logic for calculator state one
; returns nothing
calc_state_one:

.end:
	ret
;============================================

;============================================
; Performs logic for calculator
; returns nothing
calc_state_logic:
	ld a, [calc_state]
	ld c, a
	ld hl, new_cursor_location
	ld a, [hl]
	inc hl
	ld b, [hl]
	bit 0, c
	jp z, .n_zero
.zero:
	call calc_state_zero
	jp .end
.n_zero:
	bit 1, c
	jp z, .n_one
.one:
	call calc_state_one
.n_one:
.end:
	ret
;============================================

handle_input:
	ld a,[new_input_data]
	bit 4, a
	jp z, .nmove_right
.move_right:
	call move_right
.nmove_right:
	bit 5, a
	jp z, .nmove_left
.move_left:
	call move_left
.nmove_left:
	bit 7, a
	jp z, .nmove_down
.move_down:
	call move_down
.nmove_down:
	bit 6, a
	jp z, .nmove_up
.move_up:
	call move_up
.nmove_up:
	bit 0, a
	jp z, .n_A_button
.A_Button:
	call calc_state_logic
.n_A_button:
	
.B_Button:
	
.n_B_Button:

.Start:

.Select:
	jp end
;============================================
; Gets Button/D-Pad I/O
; returns a with the bits set of activated inputs
get_input:
	ld a, $20
	ld [$FF00], a
	ld a, [$FF00]
	ld a, [$FF00]
	cpl 
	and $0F
	swap a
	ld b, a
	LD A,$10
	LD [$FF00],A
	LD A,[$FF00]
	LD A,[$FF00]
	LD A,[$FF00]
	LD A,[$FF00]
	LD A,[$FF00]
	LD A,[$FF00]
	CPL
	AND $0F
	OR B
	LD B,A
	LD A,[old_input_data]
	XOR B
	AND B
	LD [new_input_data],A
	LD A,B
	LD [old_input_data],A
	LD A,$30
	LD [$FF00],A
	ret
;============================================

end: 
	call get_input
	ld a,[new_input_data]
	jp nz, .update
	call update_calc_oam
	jp end
.update:
	call handle_input
	call update_calc_oam
	jp end


stat:
timer:
serial:
joypad:
    reti
	

bg_tile_0000:
DB $00,$00,$00,$01,$03,$03,$0C,$0C
DB $1C,$0C,$1C,$0C,$18,$1C,$1C,$18
DB $18,$1C,$1C,$0C,$0C,$0C,$04,$06
DB $01,$01,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$C0,$F0,$20,$18,$18
DB $18,$08,$08,$08,$00,$00,$00,$00
DB $3C,$1C,$18,$18,$18,$18,$18,$18
DB $D0,$E0,$00,$00,$FF,$FF,$01,$FF

bg_tile_0001:
DB $00,$00,$00,$00,$7F,$FF,$30,$30
DB $30,$30,$30,$30,$30,$31,$31,$30
DB $30,$30,$30,$30,$30,$38,$3F,$1F
DB $00,$00,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$00,$80,$80,$C0
DB $E0,$C0,$E0,$C0,$80,$80,$C0,$C0
DB $60,$E0,$60,$60,$60,$60,$E0,$C0
DB $00,$00,$00,$00,$FF,$FF,$01,$FF

bg_tile_0002:
DB $00,$00,$00,$00,$06,$05,$18,$18
DB $18,$18,$30,$38,$30,$30,$38,$30
DB $30,$30,$38,$38,$18,$18,$0C,$08
DB $03,$07,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$80,$80,$70,$20
DB $20,$30,$10,$10,$10,$10,$00,$00
DB $01,$00,$01,$11,$21,$01,$23,$23
DB $40,$C0,$00,$00,$FF,$FF,$01,$FF

bg_tile_0003:
DB $00,$00,$00,$00,$00,$20,$30,$30
DB $70,$30,$78,$70,$98,$58,$98,$98
DB $2C,$D8,$0C,$2C,$0E,$04,$06,$06
DB $00,$00,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$3F,$7F,$0C,$1E
DB $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C
DB $0C,$0C,$0C,$0C,$0E,$1C,$1F,$1F
DB $00,$00,$00,$00,$FF,$FF,$01,$FF

bg_tile_0004:
DB $00,$00,$00,$00,$00,$00,$01,$01
DB $01,$01,$03,$03,$03,$03,$03,$03
DB $13,$33,$13,$13,$31,$11,$F0,$F0
DB $00,$00,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$68,$58,$87,$82
DB $82,$83,$01,$81,$01,$01,$80,$00
DB $00,$00,$80,$81,$82,$80,$C2,$82
DB $34,$7C,$00,$00,$FF,$FF,$01,$FF

bg_tile_0005:
DB $00,$00,$00,$00,$7E,$3F,$1C,$1C
DB $0C,$1C,$0C,$1C,$0C,$1C,$0C,$1C
DB $0C,$1C,$1C,$0C,$0C,$0C,$0E,$04
DB $03,$01,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$1C,$3D,$08,$08
DB $08,$08,$08,$08,$08,$08,$08,$08
DB $08,$08,$08,$08,$08,$00,$10,$10
DB $C0,$E0,$00,$00,$FF,$FF,$01,$FF

bg_tile_0006:
DB $00,$00,$00,$00,$FC,$FC,$30,$78
DB $30,$30,$30,$30,$30,$30,$30,$30
DB $30,$30,$30,$30,$30,$70,$7F,$7F
DB $00,$00,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$00,$00,$00,$00
DB $01,$00,$01,$01,$02,$01,$02,$02
DB $44,$C3,$44,$44,$C4,$44,$CC,$CC
DB $00,$00,$00,$00,$FF,$FF,$01,$FF

bg_tile_0007:
DB $00,$00,$00,$00,$00,$81,$C0,$C1
DB $C0,$C1,$E0,$C1,$60,$61,$60,$60
DB $B0,$60,$30,$B0,$38,$10,$18,$18
DB $00,$00,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$FF,$FF,$CC,$8C
DB $8C,$8C,$0C,$0C,$0C,$0C,$0C,$0C
DB $0C,$0C,$0C,$0C,$08,$0C,$08,$1E
DB $00,$00,$00,$00,$FF,$FF,$01,$FF

bg_tile_0008:
DB $00,$00,$00,$00,$E0,$C0,$63,$63
DB $66,$66,$26,$26,$2E,$2E,$0E,$0E
DB $0E,$06,$06,$06,$03,$07,$03,$03
DB $00,$00,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$B8,$D0,$0C,$0C
DB $06,$06,$06,$06,$07,$07,$07,$07
DB $07,$07,$06,$06,$0C,$0C,$08,$08
DB $70,$E0,$00,$00,$FF,$FF,$01,$FF

bg_tile_0009:
DB $00,$00,$00,$00,$3F,$7F,$18,$1C
DB $18,$1C,$18,$1C,$1C,$1C,$1E,$1D
DB $1C,$1C,$1C,$1C,$1C,$0C,$18,$0C
DB $00,$00,$00,$00,$FF,$FF,$00,$FF
DB $00,$00,$00,$00,$E0,$E0,$38,$18
DB $18,$18,$18,$18,$B0,$70,$80,$00
DB $C0,$C0,$60,$60,$70,$30,$30,$38
DB $00,$00,$00,$00,$FF,$FF,$01,$FF

four_16x16:
DB $00,$00,$00,$00,$00,$00,$00,$00
DB $01,$00,$03,$01,$06,$02,$08,$04
DB $18,$08,$1F,$1F,$00,$00,$06,$01
DB $07,$07,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$C0,$00
DB $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
DB $C0,$C0,$F0,$F8,$C0,$C0,$C0,$C0
DB $F8,$F0,$00,$00,$00,$00,$00,$00

seven_16x16:
DB $00,$00,$00,$00,$00,$00,$00,$00
DB $07,$0F,$0F,$0F,$00,$00,$00,$00
DB $00,$00,$00,$01,$01,$01,$01,$03
DB $03,$03,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00
DB $F0,$F0,$E0,$F0,$30,$20,$40,$60
DB $C0,$C0,$80,$C0,$80,$80,$80,$80
DB $80,$00,$00,$00,$00,$00,$00,$00

eight_16x16:
DB $00,$00,$00,$00,$00,$00,$02,$03
DB $08,$0C,$18,$08,$0C,$1C,$0F,$0F
DB $07,$07,$18,$08,$18,$18,$18,$18
DB $07,$06,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$C0,$40
DB $20,$20,$30,$30,$20,$30,$E0,$C0
DB $E0,$F0,$70,$70,$18,$18,$10,$30
DB $60,$C0,$00,$00,$00,$00,$00,$00

nine_16x16:
DB $00,$00,$00,$00,$00,$00,$03,$01
DB $0F,$06,$0C,$0C,$0C,$1C,$0C,$0C
DB $06,$07,$00,$00,$0A,$0C,$0C,$0E
DB $07,$02,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$80,$80
DB $60,$E0,$30,$30,$30,$38,$38,$38
DB $78,$F8,$38,$30,$30,$30,$20,$60
DB $80,$C0,$00,$00,$00,$00,$00,$00

circle_00:
DB $2F,$30,$5F,$60,$5F,$60,$5F,$60
DB $BF,$C0,$BF,$C0,$BF,$C0,$BF,$C0

circle_01:
DB $00,$00,$00,$00,$01,$01,$02,$03
DB $04,$07,$0B,$0C,$17,$18,$27,$38

circle_02:
DB $0F,$0F,$70,$7F,$8F,$F0,$7F,$80
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00

circle_03:
DB $F0,$F0,$0E,$FE,$F1,$0F,$FE,$01
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00

circle_04:
DB $00,$00,$00,$00,$80,$80,$40,$C0
DB $20,$E0,$D0,$30,$E8,$18,$E4,$1C

circle_05:
DB $F4,$0C,$FA,$06,$FA,$06,$FA,$06
DB $FD,$03,$FD,$03,$FD,$03,$FD,$03

circle_06:
DB $FD,$03,$FD,$03,$FD,$03,$FD,$03
DB $FA,$06,$FA,$06,$FA,$06,$F4,$0C

circle_07:
DB $E4,$1C,$E8,$18,$D0,$30,$20,$E0
DB $40,$C0,$80,$80,$00,$00,$00,$00

circle_08:
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FE,$01,$F1,$0F,$0E,$FE,$F0,$F0

circle_09:
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $7F,$80,$8F,$F0,$70,$7F,$0F,$0F

circle_10:
DB $27,$38,$17,$18,$0B,$0C,$04,$07
DB $02,$03,$01,$01,$00,$00,$00,$00

circle_11:
DB $BF,$C0,$BF,$C0,$BF,$C0,$BF,$C0
DB $5F,$60,$5F,$60,$5F,$60,$2F,$30

minus_bg:
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$00,$FF,$7F,$FF
DB $7F,$FF,$00,$FF,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$00,$FF,$FE,$FF
DB $FE,$FF,$00,$FF,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00

plus_bg:
DB $FC,$03,$FD,$03,$FD,$03,$FD,$03
DB $FD,$03,$FD,$03,$01,$FF,$7F,$FF
DB $7F,$FF,$01,$FF,$FD,$03,$FD,$03
DB $FD,$03,$FD,$03,$FD,$03,$FC,$03
DB $3F,$C0,$BF,$C0,$BF,$C0,$BF,$C0
DB $BF,$C0,$BF,$C0,$80,$FF,$FE,$FF
DB $FE,$FF,$80,$FF,$BF,$C0,$BF,$C0
DB $BF,$C0,$BF,$C0,$BF,$C0,$3F,$C0

seven_bg:
DB $80,$7F,$7F,$FF,$FF,$FF,$FF,$C0
DB $FF,$80,$FF,$80,$7F,$80,$FF,$00
DB $FF,$00,$FF,$00,$FF,$01,$FF,$03
DB $FB,$07,$FF,$0F,$FF,$0F,$EF,$1F
DB $00,$FF,$FF,$FF,$FF,$FE,$F5,$0E
DB $FF,$18,$F7,$18,$FF,$30,$EF,$70
DB $FF,$60,$DF,$E0,$DF,$E0,$FF,$C0
DB $FF,$C0,$BF,$C0,$FF,$80,$FF,$80

eight_bg:
DB $F7,$0F,$DF,$30,$FF,$30,$FF,$70
DB $FF,$70,$FF,$78,$BF,$7F,$DF,$3F
DB $DF,$3B,$FF,$70,$FF,$F0,$EF,$F0
DB $EF,$F0,$FF,$70,$F7,$38,$F7,$0F
DB $EF,$F0,$EF,$18,$FD,$0E,$FD,$0E
DB $FD,$0E,$FF,$0C,$E7,$98,$FF,$F0
DB $FF,$FE,$DE,$3F,$FF,$0F,$FF,$0F
DB $FF,$0F,$FF,$0E,$FF,$18,$FF,$E0

nine_bg:
DB $FF,$07,$FB,$1C,$FF,$78,$7F,$F8
DB $FF,$F8,$FF,$F8,$FF,$F8,$FF,$78
DB $DB,$3C,$FF,$0F,$F7,$08,$BF,$7C
DB $FF,$7C,$BB,$7C,$FF,$30,$E8,$1F
DB $9F,$E0,$F7,$38,$FB,$1C,$FD,$1E
DB $FF,$1E,$FE,$1F,$FF,$1F,$FF,$1F
DB $BF,$7F,$7F,$DF,$FE,$1F,$FF,$1E
DB $FD,$1E,$FB,$1C,$F7,$38,$DF,$E0

four_bg:
DB $FF,$00,$FF,$00,$FE,$01,$FD,$03
DB $FB,$06,$F5,$0E,$EF,$18,$DF,$30
DB $BF,$60,$7F,$C0,$FF,$FF,$3F,$FF
DB $FF,$00,$FF,$00,$FE,$01,$F1,$0F
DB $AF,$70,$6F,$F0,$FF,$F0,$FF,$F0
DB $FF,$F0,$FF,$F0,$FF,$F0,$FF,$F0
DB $FF,$F0,$77,$F8,$FC,$FF,$FF,$FF
DB $FF,$F0,$FF,$F0,$F7,$F8,$FC,$FF

five_bg:
DB $DF,$3F,$DF,$3F,$FF,$3F,$FF,$20
DB $FF,$20,$BF,$60,$A7,$7F,$EF,$70
DB $FF,$00,$FF,$00,$DF,$20,$7F,$F8
DB $FF,$F8,$7F,$F8,$EF,$70,$F8,$1F
DB $FD,$FE,$FB,$FC,$EF,$F0,$FF,$00
DB $FF,$00,$FF,$00,$DF,$E0,$3F,$FC
DB $FF,$1E,$FF,$1F,$FF,$1F,$FF,$1F
DB $FF,$1F,$FD,$1E,$F3,$3C,$EF,$F0

six_bg:
DB $FB,$07,$EF,$1C,$DF,$38,$BF,$78
DB $FF,$78,$7F,$F8,$FE,$FB,$FD,$FE
DB $FF,$F8,$FF,$F8,$7F,$F8,$FF,$78
DB $BF,$78,$DF,$38,$EF,$1C,$F9,$07
DB $17,$F8,$FF,$0C,$DD,$3E,$FF,$3E
DB $FD,$3E,$EF,$10,$FF,$F0,$DB,$3C
DB $FF,$1E,$FF,$1F,$FF,$1F,$FF,$1F
DB $FE,$1F,$FF,$1E,$DF,$38,$FF,$E0

one_bg:
DB $FF,$00,$DF,$3F,$3F,$FF,$FB,$07
DB $FF,$03,$FF,$03,$FF,$03,$FF,$03
DB $FF,$03,$FF,$03,$FF,$03,$FF,$03
DB $FF,$03,$FB,$07,$FF,$07,$1F,$FF
DB $5F,$E0,$DF,$E0,$DF,$E0,$DF,$E0
DB $DF,$E0,$DF,$E0,$DF,$E0,$DF,$E0
DB $DF,$E0,$DF,$E0,$DF,$E0,$DF,$E0
DB $DF,$E0,$DF,$E0,$FF,$E0,$F8,$FF

two_bg:
DB $F7,$0F,$E7,$38,$DF,$60,$DF,$60
DB $9D,$FE,$FF,$FE,$FF,$7E,$FB,$1C
DB $FF,$00,$FF,$00,$FF,$03,$F7,$0C
DB $FF,$10,$FF,$3F,$FF,$7F,$7F,$FF
DB $DF,$E0,$BB,$7C,$DF,$3E,$FF,$1E
DB $FF,$1F,$FF,$1F,$DE,$3F,$FF,$3C
DB $FF,$78,$FF,$E0,$FF,$01,$FD,$03
DB $FE,$03,$FF,$FE,$FF,$FE,$FF,$FE

three_bg:
DB $F7,$0F,$FF,$30,$F7,$78,$7F,$F8
DB $7F,$F8,$BF,$78,$FF,$00,$F1,$0F
DB $F3,$0E,$FF,$00,$FF,$00,$FF,$78
DB $FF,$F8,$FF,$F8,$EF,$70,$F8,$1F
DB $DF,$E0,$FF,$78,$BF,$7C,$FF,$3C
DB $FF,$3C,$FF,$3C,$FB,$3C,$FF,$E0
DB $E7,$F8,$FD,$3E,$FE,$1F,$FF,$1F
DB $FE,$1F,$FF,$1E,$DF,$3C,$6F,$F0

zero_bg:
DB $FB,$07,$EF,$1C,$FF,$38,$FF,$38
DB $FF,$78,$FF,$78,$7F,$F8,$FF,$F8
DB $FF,$F8,$7F,$F8,$FF,$78,$FF,$78
DB $FF,$38,$FF,$38,$FB,$1C,$FE,$07
DB $DF,$E0,$DF,$38,$FF,$1C,$FD,$1E
DB $FF,$1E,$FE,$1F,$FF,$1F,$FF,$1F
DB $FF,$1F,$FF,$1F,$FE,$1F,$FF,$1E
DB $FD,$1E,$FF,$1C,$FF,$18,$6F,$F0

multiply_bg:
DB $1F,$E0,$6F,$F0,$77,$F8,$BB,$7C
DB $DD,$3E,$EE,$1F,$F7,$0F,$FB,$07
DB $FB,$07,$F7,$0F,$EE,$1F,$DD,$3E
DB $BB,$7C,$77,$F8,$6F,$F0,$1F,$E0
DB $F8,$07,$F6,$0F,$EE,$1F,$DD,$3E
DB $BB,$7C,$77,$F8,$EF,$F0,$DF,$E0
DB $DF,$E0,$EF,$F0,$77,$F8,$BB,$7C
DB $DD,$3E,$EE,$1F,$F6,$0F,$F8,$07

divide_bg:
DB $FF,$00,$FC,$03,$FD,$03,$FD,$03
DB $FC,$03,$FF,$00,$00,$FF,$7F,$FF
DB $7F,$FF,$00,$FF,$FF,$00,$FC,$03
DB $FD,$03,$FD,$03,$FC,$03,$FF,$00
DB $FF,$00,$3F,$C0,$BF,$C0,$BF,$C0
DB $3F,$C0,$FF,$00,$00,$FF,$FE,$FF
DB $FE,$FF,$00,$FF,$FF,$00,$3F,$C0
DB $BF,$C0,$BF,$C0,$3F,$C0,$FF,$00

blank_bg:
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00
DB $FF,$00,$FF,$00,$FF,$00,$FF,$00

window_00:
DB $40,$80,$40,$80,$40,$80,$40,$80
DB $40,$80,$7F,$80,$00,$FF,$FF,$FF
window_01:
DB $05,$03,$05,$03,$05,$03,$05,$03
DB $05,$03,$FD,$03,$01,$FF,$FF,$FF


window_02:
DB $7F,$80,$40,$80,$40,$80,$40,$80
DB $40,$80,$40,$80,$40,$80,$40,$80
DB $40,$80,$40,$80,$40,$80,$40,$80
DB $40,$80,$40,$80,$40,$80,$40,$80
DB $FD,$03,$05,$03,$05,$03,$05,$03
DB $05,$03,$05,$03,$05,$03,$05,$03
DB $05,$03,$05,$03,$05,$03,$05,$03
DB $05,$03,$05,$03,$05,$03,$05,$03

select_00:
DB $2F,$30,$5F,$60,$5F,$60,$5F,$60
DB $BF,$F8,$A7,$FC,$BF,$FE,$A1,$FF

select_01:
DB $0F,$0F,$70,$7F,$8F,$FF,$7A,$8F
DB $FA,$0F,$FE,$07,$FE,$03,$FF,$01

select_02:
DB $F0,$F0,$0E,$FE,$F1,$FF,$5E,$F1
DB $5F,$F0,$7F,$E0,$7F,$C0,$FF,$80

select_03:
DB $F4,$0C,$FA,$06,$FA,$06,$FA,$06
DB $FD,$1F,$E5,$3F,$FD,$7F,$85,$FF

select_04:
DB $85,$FF,$FD,$7F,$E5,$3F,$FD,$1F
DB $FA,$06,$FA,$06,$FA,$06,$F4,$0C

select_05:
DB $FF,$80,$7F,$C0,$7F,$E0,$5F,$F0
DB $5E,$F1,$F1,$FF,$0E,$FE,$F0,$F0

select_06:
DB $FF,$01,$FE,$03,$FE,$07,$FA,$0F
DB $7A,$8F,$8F,$FF,$70,$7F,$0F,$0F

select_07:
DB $A1,$FF,$BF,$FE,$A7,$FC,$BF,$F8
DB $5F,$60,$5F,$60,$5F,$60,$2F,$30


oam_inst:
DB  $F5, $3E, $C1, $E0, $46, $3E, $28, $3D, $20, $FD, $F1, $D9
	;push af
	;ld a, $C1
	;ld [$ff46],a
	;ld a, $28
;.loop:
	;dec a
	;jr nz, .loop
	;pop af
	;reti
	
SECTION "rm",ROMX[$7FFF]
DB $00

SECTION "OAM_DATA",WRAM0[$C100]
digit_zero_oam: DS 4 * 4
digit_one_oam: DS 4 * 4
digit_two_oam: DS 4 * 4
digit_three_oam: DS 4 * 4
digit_four_oam: DS 4 * 4
digit_five_oam: DS 4 * 4
digit_six_oam: DS 4 * 4
digit_seven_oam: DS 4 * 4
digit_eight_oam: DS 4 * 4
digit_nine_oam: DS 4 * 4

SECTION "DMA_VBlank",HRAM[$FF80]
;============================================
; oam_inst VBlank interrupt handler $FF80 - $FF8B ($0040)
;============================================
SECTION "I/O_Storage",HRAM[$FF8C]
old_input_data: DS 1
new_input_data: DS 1
SECTION "Variables",HRAM[$FF8E]
old_cursor_location: DS 2
new_cursor_location: DS 2
calc_state: DS 1
operand_0: DS 4
operand_1: DS 4
result: DS 4
input_digit_0: DS 1
input_digit_1: DS 1
input_digit_2: DS 1
input_digit_3: DS 1
input_digit_4: DS 1
input_digit_5: DS 1
input_digit_6: DS 1
input_digit_7: DS 1
input_digit_8: DS 1
input_digit_9: DS 1