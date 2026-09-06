;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module hello_world
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _load_intro
	.globl _trigger_jumpV
	.globl _update_jumpV
	.globl _isColission
	.globl _moveWith
	.globl _moveDef
	.globl _toAniIndexPos
	.globl _toAniPos
	.globl _toAniIndex
	.globl _toAniDefine
	.globl _toTilesgifyDefineUpdate
	.globl _load_sprite
	.globl _load_palette
	.globl _delay
	.globl _loop
	.globl _count
	.globl _last_state
	.globl _game_state
	.globl __MASTER
	.globl __DELTA
	.globl __PAUSE
	.globl __FINISH
	.globl _prev_tiles
	.globl _next_y_address
	.globl _next_x_address
	.globl _address_til
	.globl _next_id
	.globl _vblank_ocurrido
	.globl _debounce_count
	.globl _vdp_status
	.globl _lives2
	.globl _lives1
	.globl _win2
	.globl _win1
	.globl _lastPoint
	.globl _point2
	.globl _point1
	.globl _sFs
	.globl _vgm
	.globl __BUTTONS
	.globl __intro_til
	.globl __intro_tilemap
	.globl __intro_pal
	.globl __VRAM_SPRITE_END
	.globl __VRAM_SPRITE_INFO_X
	.globl __VRAM_SPRITE_INFO_Y
	.globl __VRAM_TILES_TABLE
	.globl __VRAM_SPRITE_PATT
	.globl __VRAM_SPRITE_COL
	.globl __SPRITE_SIZE
	.globl __SPRITE_HEIGHT
	.globl __SPRITE_WIDTH
	.globl __SCREEN_TILES_SIZE
	.globl __SCREEN_TILES_HEIGHT
	.globl __SCREEN_TILES_WIDTH
	.globl __SCREEN_HEIGHT
	.globl __SCREEN_WIDTH
	.globl __TILE_BYTES_SIZE
	.globl __TILE_SIZE
	.globl __TILE_HEIGHT
	.globl __TILE_WIDTH
	.globl __MASTER_MAX
	.globl _delay
	.globl _isPress
	.globl _isSoftwarePause
	.globl _vgm_init
	.globl _vgm_tick
	.globl _load_music
	.globl _clear_vram
	.globl _write_palette
	.globl _write_vram
	.globl _write_vram_2
	.globl _draw_bg
	.globl _remove_bg
	.globl _vblankISR
	.globl _toVblankISR
	.globl _nmISR
	.globl _playEffectSound
	.globl _playBeep
	.globl _mute
	.globl _loadStatesFunctions
	.globl _spritesInit
	.globl _spritesDefine
	.globl _load_commons
	.globl _init
	.globl _draw
	.globl _update
	.globl _update_fast
	.globl _main
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_VDP_DATA	=	0x00be
_VDP_ADDRESS	=	0x00bf
_PSG	=	0x007f
__PAD1	=	0x00dc
__PAD2	=	0x00dd
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
__BUTTONS::
	.ds 1
_vgm::
	.ds 6
_sFs::
	.ds 128
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_point1::
	.ds 1
_point2::
	.ds 1
_lastPoint::
	.ds 1
_win1::
	.ds 1
_win2::
	.ds 1
_lives1::
	.ds 1
_lives2::
	.ds 1
_vdp_status::
	.ds 1
_debounce_count::
	.ds 1
_vblank_ocurrido::
	.ds 1
_next_id::
	.ds 1
_address_til::
	.ds 2
_next_x_address::
	.ds 1
_next_y_address::
	.ds 1
_prev_tiles::
	.ds 1
__FINISH::
	.ds 1
__PAUSE::
	.ds 1
__DELTA::
	.ds 4
__MASTER::
	.ds 1
_game_state::
	.ds 1
_last_state::
	.ds 1
_count::
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;./inc/basic.h:36: void delay(uint16_t count) {
;	---------------------------------
; Function delay
; ---------------------------------
_delay::
;./inc/basic.h:38: for (i = 0; i < count; i++) {
	ld	bc, #0x0000
00103$:
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	ret	NC
;./inc/basic.h:39: __asm__("nop");
	nop
;./inc/basic.h:38: for (i = 0; i < count; i++) {
	inc	bc
;./inc/basic.h:41: }
	jr	00103$
__MASTER_MAX:
	.db #0xfe	; 254
__TILE_WIDTH:
	.db #0x08	; 8
__TILE_HEIGHT:
	.db #0x08	; 8
__TILE_SIZE:
	.db #0x40	; 64
__TILE_BYTES_SIZE:
	.db #0x20	; 32
__SCREEN_WIDTH:
	.db #0xff	; 255
__SCREEN_HEIGHT:
	.db #0xc0	; 192
__SCREEN_TILES_WIDTH:
	.db #0x20	; 32
__SCREEN_TILES_HEIGHT:
	.db #0x18	; 24
__SCREEN_TILES_SIZE:
	.dw #0x0300
__SPRITE_WIDTH:
	.db #0x04	; 4
__SPRITE_HEIGHT:
	.db #0x08	; 8
__SPRITE_SIZE:
	.db #0x20	; 32
__VRAM_SPRITE_COL:
	.dw #0x0000
__VRAM_SPRITE_PATT:
	.dw #0x2000
__VRAM_TILES_TABLE:
	.dw #0x3800
__VRAM_SPRITE_INFO_Y:
	.dw #0x3f00
__VRAM_SPRITE_INFO_X:
	.dw #0x3f80
__VRAM_SPRITE_END:
	.db #0xd0	; 208
;./inc/basic.h:53: uint8_t isPress(enum eBUTTONS button){
;	---------------------------------
; Function isPress
; ---------------------------------
_isPress::
	ld	c, a
;./inc/basic.h:54: uint8_t pad = _PAD1;
	in	a, (__PAD1)
	ld	b, a
;./inc/basic.h:56: if(button == L2 || button == R2 || button == B12 || button == B22){
	ld	a, c
	sub	a, #0x81
	jr	Z, 00101$
	ld	a, c
	sub	a, #0x82
	jr	Z, 00101$
	ld	a, c
	sub	a, #0x84
	jr	Z, 00101$
	ld	a, c
	sub	a, #0x88
	jr	NZ, 00102$
00101$:
;./inc/basic.h:57: pad = _PAD2;
	in	a, (__PAD2)
	ld	b, a
;./inc/basic.h:58: button &= 0b00001111; //LES ASIGNA SU VALOR CORRECTO (ESTABA DESPLAZADO)
	ld	a, c
	and	a, #0x0f
	ld	c, a
00102$:
;./inc/basic.h:60: if(button == res || button == inA){
	ld	a, c
	sub	a, #0x90
	jr	Z, 00106$
	ld	a, c
	sub	a, #0xc0
	jr	NZ, 00107$
00106$:
;./inc/basic.h:61: pad = _PAD2;
	in	a, (__PAD2)
	ld	b, a
;./inc/basic.h:62: button &= 0b01010000; //LES ASIGNA SU VALOR CORRECTO (ESTABA DESPLAZADO)
	ld	a, c
	and	a, #0x50
	ld	c, a
00107$:
;./inc/basic.h:64: if(button == inB){
	ld	a, c
	sub	a, #0xc1
	jr	NZ, 00110$
;./inc/basic.h:65: pad = _PAD2;
	in	a, (__PAD2)
	ld	b, a
;./inc/basic.h:66: button &= 0b01000001; //LES ASIGNA SU VALOR CORRECTO (ESTABA DESPLAZADO)
	ld	a, c
	and	a, #0x41
	ld	c, a
00110$:
;./inc/basic.h:68: return !(pad & button); //los botones se presionan a cero.
	ld	a, b
	and	a, c
	sub	a,#0x01
	ld	a, #0x00
	rla
;./inc/basic.h:69: }
	ret
;./inc/basic.h:74: bool isSoftwarePause(uint16_t count, uint16_t max){
;	---------------------------------
; Function isSoftwarePause
; ---------------------------------
_isSoftwarePause::
;./inc/basic.h:75: return ((count > max) && ((isPress(B1) && isPress(B2)) || (isPress(B12) && isPress(B22))));
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, h
	jr	NC, 00103$
	ld	a, #0x10
	call	_isPress
	or	a, a
	jr	Z, 00111$
	ld	a, #0x20
	call	_isPress
	or	a, a
	jr	NZ, 00104$
00111$:
	ld	a, #0x84
	call	_isPress
	or	a, a
	jr	Z, 00103$
	ld	a, #0x88
	call	_isPress
	or	a, a
	jr	NZ, 00104$
00103$:
	xor	a, a
	ret
00104$:
	ld	a, #0x01
;./inc/basic.h:76: }
	ret
;./inc/basic.h:88: void vgm_init(vgm_info *vgm, const uint8_t *file_data){
;	---------------------------------
; Function vgm_init
; ---------------------------------
_vgm_init::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-8
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
;./inc/basic.h:89: uint32_t version = *((uint32_t *)(file_data + 0x08));
	ld	hl, #0x0008
	add	hl, de
	ex	de, hl
	push	hl
	ld	hl, #4
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	de
;./inc/basic.h:91: vgm->next_byte = file_data + 0x40;
	ld	c, -2 (ix)
	ld	b, -1 (ix)
	inc	bc
	inc	bc
	ld	hl, #0x0040
	add	hl, de
	ex	(sp), hl
;./inc/basic.h:90: if (version < 0x00000150){
	ld	a, -6 (ix)
	sub	a, #0x50
	ld	a, -5 (ix)
	sbc	a, #0x01
	ld	a, -4 (ix)
	sbc	a, #0x00
	ld	a, -3 (ix)
	sbc	a, #0x00
	jr	NC, 00105$
;./inc/basic.h:91: vgm->next_byte = file_data + 0x40;
	ld	l, c
	ld	h, b
	ld	a, -8 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -7 (ix)
	ld	(hl), a
	jr	00106$
00105$:
;./inc/basic.h:93: uint32_t data_offset = *((uint32_t *)(file_data + 0x34));
	ld	hl, #0x0034
	add	hl, de
	push	de
	push	bc
	ex	de, hl
	ld	hl, #6
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	bc
	pop	de
;./inc/basic.h:94: if (data_offset == 0x0000000C){
	ld	a, -6 (ix)
	sub	a, #0x0c
	or	a, -5 (ix)
	or	a, -4 (ix)
	or	a, -3 (ix)
	jr	NZ, 00102$
;./inc/basic.h:95: vgm->next_byte = file_data + 0x40;
	ld	l, c
	ld	h, b
	ld	a, -8 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -7 (ix)
	ld	(hl), a
	jr	00106$
00102$:
;./inc/basic.h:97: vgm->next_byte = file_data + data_offset + 0x34;
	ld	a, e
	add	a, -6 (ix)
	ld	e, a
	ld	a, d
	adc	a, -5 (ix)
	ld	d, a
	ld	hl, #0x0034
	add	hl, de
	ex	de, hl
	ld	l, c
	ld	h, b
	ld	(hl), e
	inc	hl
	ld	(hl), d
00106$:
;./inc/basic.h:100: vgm->first_byte = vgm->next_byte;
	ld	l, c
	ld	h, b
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
;./inc/basic.h:101: vgm->wait_counter = 0;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	de, #0x0004
	add	hl, de
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;./inc/basic.h:102: }
	ld	sp, ix
	pop	ix
	ret
;./inc/basic.h:107: void vgm_tick(vgm_info *vgm){
;	---------------------------------
; Function vgm_tick
; ---------------------------------
_vgm_tick::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-20
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
;./inc/basic.h:108: if (vgm->wait_counter > 0){
	ld	a, -2 (ix)
	add	a, #0x04
	ld	-20 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-19 (ix), a
	pop	hl
	push	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, b
	or	a, c
	jr	Z, 00102$
;./inc/basic.h:109: --vgm->wait_counter;
	dec	bc
	pop	hl
	push	hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
;./inc/basic.h:110: return;
	jp	00123$
00102$:
;./inc/basic.h:112: const uint8_t *p = vgm->next_byte;
	ld	a, -2 (ix)
	add	a, #0x02
	ld	-18 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-17 (ix), a
	ld	l, -18 (ix)
	ld	h, -17 (ix)
	ld	a, (hl)
	ld	-16 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-15 (ix), a
;./inc/basic.h:113: if (*p == 0x50){
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	a, (hl)
	sub	a, #0x50
	jr	NZ, 00114$
;./inc/basic.h:114: vgm->wait_counter = 0;
	pop	hl
	push	hl
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;./inc/basic.h:115: while (*p == 0x50){
00103$:
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	a, (hl)
	sub	a, #0x50
	jr	NZ, 00114$
;./inc/basic.h:116: ++p;
	ld	c, -16 (ix)
	ld	b, -15 (ix)
	inc	bc
;./inc/basic.h:117: PSG = *p;
	ld	a, (bc)
	out	(_PSG), a
;./inc/basic.h:118: ++p;
	inc	bc
	ld	-16 (ix), c
	ld	-15 (ix), b
	jr	00103$
;./inc/basic.h:121: while ((*p == 0x61) || (*p == 0x62) || (*p == 0x63)){
00114$:
;./inc/basic.h:113: if (*p == 0x50){
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	ld	c, (hl)
;./inc/basic.h:121: while ((*p == 0x61) || (*p == 0x62) || (*p == 0x63)){
	ld	a, c
	sub	a, #0x62
	ld	a, #0x01
	jr	Z, 00197$
	xor	a, a
00197$:
	ld	-6 (ix), a
	ld	a, c
	sub	a, #0x63
	ld	a, #0x01
	jr	Z, 00199$
	xor	a, a
00199$:
	ld	-5 (ix), a
	ld	a, c
	sub	a, #0x61
	jr	Z, 00115$
	ld	a, -6 (ix)
	or	a, a
	jr	NZ, 00115$
	ld	a, -5 (ix)
	or	a, a
	jp	Z, 00134$
00115$:
;./inc/basic.h:116: ++p;
	ld	a, -16 (ix)
	add	a, #0x01
	ld	-4 (ix), a
	ld	a, -15 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
;./inc/basic.h:122: if ((*p == 0x62) || (*p == 0x63)){
	ld	a, -6 (ix)
	or	a, a
	jr	NZ, 00108$
	ld	a, -5 (ix)
	or	a, a
	jr	Z, 00109$
00108$:
;./inc/basic.h:123: ++vgm->wait_counter;
	pop	hl
	push	hl
	ld	a, (hl)
	ld	-8 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-7 (ix), a
	ld	a, -8 (ix)
	add	a, #0x01
	ld	-6 (ix), a
	ld	a, -7 (ix)
	adc	a, #0x00
	ld	-5 (ix), a
	pop	hl
	push	hl
	ld	a, -6 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -5 (ix)
	ld	(hl), a
;./inc/basic.h:124: ++p;
	ld	a, -4 (ix)
	ld	-16 (ix), a
	ld	a, -3 (ix)
	ld	-15 (ix), a
	jp	00114$
00109$:
;./inc/basic.h:126: ++p;
	ld	e, -4 (ix)
	ld	d, -3 (ix)
;./inc/basic.h:127: uint16_t num_samples = *((uint16_t *)p);
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
;./inc/basic.h:128: p += 2;
	inc	de
	inc	de
	ld	-16 (ix), e
	ld	-15 (ix), d
;./inc/basic.h:138: uint32_t aux = num_samples;
	ld	-14 (ix), c
	ld	-13 (ix), b
	xor	a, a
	ld	-12 (ix), a
	ld	-11 (ix), a
;./inc/basic.h:139: aux = ((aux << 14) + (aux << 12) + (aux << 8) + (aux << 5) + (aux << 2)) >> 24;
	ld	d, -14 (ix)
	ld	l, -13 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -12 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	e, #0x00
	ld	b, #0x06
00201$:
	sla	d
	adc	hl, hl
	djnz	00201$
	ld	a, -14 (ix)
	ld	-9 (ix), a
	ld	a, -13 (ix)
	ld	-8 (ix), a
	ld	a, -12 (ix)
	ld	-7 (ix), a
	ld	-10 (ix), #0x00
	ld	b, #0x04
00203$:
	sla	-9 (ix)
	rl	-8 (ix)
	rl	-7 (ix)
	djnz	00203$
	ld	a, e
	add	a, -10 (ix)
	ld	-6 (ix), a
	ld	a, d
	adc	a, -9 (ix)
	ld	-5 (ix), a
	ld	a, l
	adc	a, -8 (ix)
	ld	-4 (ix), a
	ld	a, h
	adc	a, -7 (ix)
	ld	-3 (ix), a
	ld	b, -14 (ix)
	ld	l, -13 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -12 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	c, #0x00
	ld	a, -6 (ix)
	add	a, c
	ld	e, a
	ld	a, -5 (ix)
	adc	a, b
	ld	d, a
	ld	a, -4 (ix)
	adc	a, l
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -3 (ix)
	adc	a, h
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -14 (ix)
	ld	-10 (ix), a
	ld	a, -13 (ix)
	ld	-9 (ix), a
	ld	a, -12 (ix)
	ld	-8 (ix), a
	ld	a, -11 (ix)
	ld	-7 (ix), a
	ld	b, #0x05
00207$:
	sla	-10 (ix)
	rl	-9 (ix)
	rl	-8 (ix)
	rl	-7 (ix)
	djnz	00207$
	ld	a, e
	add	a, -10 (ix)
	ld	-6 (ix), a
	ld	a, d
	adc	a, -9 (ix)
	ld	-5 (ix), a
	ld	a, l
	adc	a, -8 (ix)
	ld	-4 (ix), a
	ld	a, h
	adc	a, -7 (ix)
	ld	-3 (ix), a
	ld	l, -14 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -13 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	b, #0x02
00209$:
	add	hl, hl
	rl	e
	rl	d
	djnz	00209$
	ld	a, -6 (ix)
	add	a, l
	ld	a, -5 (ix)
	adc	a, h
	ld	a, -4 (ix)
	adc	a, e
	ld	a, -3 (ix)
	adc	a, d
	ld	c, a
	ld	b, #0x00
;./inc/basic.h:140: vgm->wait_counter = aux;
	pop	hl
	push	hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
	jp	00114$
;./inc/basic.h:143: while ((*p & 0x70) == 0x70){
00134$:
	ld	a, -16 (ix)
	ld	-4 (ix), a
	ld	a, -15 (ix)
	ld	-3 (ix), a
00117$:
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	c, (hl)
	ld	a, c
	and	a, #0x70
	ld	b, #0x00
	sub	a, #0x70
	or	a, b
	jr	NZ, 00119$
;./inc/basic.h:145: ++p;
	inc	-4 (ix)
	jr	NZ, 00117$
	inc	-3 (ix)
	jr	00117$
00119$:
;./inc/basic.h:147: if (*p == 0x66){
	ld	a, c
	sub	a, #0x66
	jr	NZ, 00121$
;./inc/basic.h:148: vgm->wait_counter = 0;
	pop	hl
	push	hl
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;./inc/basic.h:149: vgm->next_byte = vgm->first_byte;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	pop	de
	pop	hl
	push	hl
	push	de
	ld	(hl), c
	inc	hl
	ld	(hl), b
	jr	00123$
00121$:
;./inc/basic.h:151: vgm->next_byte = p;
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a, -4 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -3 (ix)
	ld	(hl), a
00123$:
;./inc/basic.h:153: }
	ld	sp, ix
	pop	ix
	ret
;./inc/basic.h:158: void load_music(uint8_t *mus){
;	---------------------------------
; Function load_music
; ---------------------------------
_load_music::
	ex	de, hl
;./inc/basic.h:159: vgm_init(&vgm, mus); // vgm es una estructura de tipo "vgm_info" definida en "defines.h"
	ld	hl, #_vgm
;./inc/basic.h:160: }
	jp	_vgm_init
;./inc/basic.h:166: void clear_vram(uint8_t fill) {
;	---------------------------------
; Function clear_vram
; ---------------------------------
_clear_vram::
	ld	c, a
;./inc/basic.h:170: VDP_ADDRESS = 0x00; // start at color 0
	ld	a, #0x00
	out	(_VDP_ADDRESS), a
;./inc/basic.h:171: VDP_ADDRESS = 0x40; //0b01000000; // 64 // 0x40
	ld	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/basic.h:176: for(i = 0; i < 16384; i++) {
	ld	de, #0x0000
00102$:
;./inc/basic.h:177: VDP_DATA = fill;//0x00;
	ld	a, c
	out	(_VDP_DATA), a
;./inc/basic.h:176: for(i = 0; i < 16384; i++) {
	inc	de
;	spillPairReg hl
;	spillPairReg hl
	ld	a, d
	sub	a, #0x40
	jr	C, 00102$
;./inc/basic.h:179: }
	ret
;./inc/basic.h:183: void write_palette(uint8_t offset, const uint8_t *palette){
;	---------------------------------
; Function write_palette
; ---------------------------------
_write_palette::
	out	(_VDP_ADDRESS), a
	ld	c, e
	ld	b, d
;./inc/basic.h:185: VDP_ADDRESS = 0b11000000; // 192 // 0xc0 
	ld	a, #0xc0
	out	(_VDP_ADDRESS), a
;./inc/basic.h:187: while (n > 0){
	ld	e, #0x10
00101$:
	ld	a, e
	or	a, a
	ret	Z
;./inc/basic.h:188: VDP_DATA = *palette;
	ld	a, (bc)
	out	(_VDP_DATA), a
;./inc/basic.h:189: ++palette;
	inc	bc
;./inc/basic.h:190: --n;
	dec	e
;./inc/basic.h:192: }
	jr	00101$
;./inc/basic.h:196: void write_vram(const uint8_t *src, uint16_t size, uint16_t vram_addr){
;	---------------------------------
; Function write_vram
; ---------------------------------
_write_vram::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	c, l
	ld	b, h
;./inc/basic.h:197: VDP_ADDRESS = (uint8_t)(vram_addr & 0x00FF);
	ld	a, 4 (ix)
	out	(_VDP_ADDRESS), a
;./inc/basic.h:198: VDP_ADDRESS = 0b01000000 | ((uint8_t)((vram_addr >> 8) & 0x3F));
	ld	a, 5 (ix)
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/basic.h:199: while (size > 0){
00101$:
	ld	a, d
	or	a, e
	jr	Z, 00104$
;./inc/basic.h:200: VDP_DATA = *src;
	ld	a, (bc)
	out	(_VDP_DATA), a
;./inc/basic.h:201: ++src;
	inc	bc
;./inc/basic.h:202: --size;
	dec	de
	jr	00101$
00104$:
;./inc/basic.h:204: }
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
;./inc/basic.h:207: void write_vram_2(const uint8_t *src, uint16_t size, uint16_t vram_addr){
;	---------------------------------
; Function write_vram_2
; ---------------------------------
_write_vram_2::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	c, l
	ld	b, h
;./inc/basic.h:208: VDP_ADDRESS = (uint8_t)(vram_addr & 0x00FF);
	ld	a, 4 (ix)
	out	(_VDP_ADDRESS), a
;./inc/basic.h:209: VDP_ADDRESS = 0b01000000 | ((uint8_t)((vram_addr >> 8) & 0x3F));
	ld	a, 5 (ix)
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/basic.h:210: while (size > 0){
00101$:
	ld	a, d
	or	a, e
	jr	Z, 00104$
;./inc/basic.h:211: VDP_DATA = *src;
	ld	a, (bc)
	out	(_VDP_DATA), a
;./inc/basic.h:212: VDP_DATA = 0;
	ld	a, #0x00
	out	(_VDP_DATA), a
;./inc/basic.h:213: ++src;
	inc	bc
;./inc/basic.h:214: --size;
	dec	de
	jr	00101$
00104$:
;./inc/basic.h:216: }
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
;./inc/basic.h:219: void draw_bg(uint8_t *pal, uint8_t *tiles, uint16_t size, uint8_t *tilemap){
;	---------------------------------
; Function draw_bg
; ---------------------------------
_draw_bg::
;./inc/basic.h:222: write_palette(PALETTE_OFFSET_TILES, pal);
	ex	de, hl
	push	hl
	xor	a, a
	call	_write_palette
	pop	bc
;./inc/basic.h:223: write_vram(tiles, size, 0);                        // 3 * 4 * 8, 0); // 240 + 1 tile patterns --> vram pattern address (0x0000)
	ld	hl, #0x0000
	push	hl
	ld	hl, #4
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	call	_write_vram
;./inc/basic.h:224: write_vram_2(tilemap, _SCREEN_TILES_SIZE, 0x3800); // 32 * 24 tiles --> vram tile map address (0x3800)
	ld	de, (__SCREEN_TILES_SIZE)
	ld	hl, #0x3800
	push	hl
;	spillPairReg hl
;	spillPairReg hl
	ld	hl, #6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	call	_write_vram_2
;./inc/basic.h:226: }
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;./inc/basic.h:229: void remove_bg(void){
;	---------------------------------
; Function remove_bg
; ---------------------------------
_remove_bg::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-1024
	add	hl, sp
	ld	sp, hl
;./inc/basic.h:231: memset(tiles, 0, 256); //
	ld	hl, #0
	add	hl, sp
	ld	b, #0x80
00103$:
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x00
	inc	hl
	djnz	00103$
;./inc/basic.h:233: memset(tilemap, 0, _SCREEN_TILES_SIZE); // 32 * 24;
	ld	hl, (__SCREEN_TILES_SIZE)
	push	hl
	ld	de, #0x0000
	ld	hl, #258
	add	hl, sp
	call	_memset
;./inc/basic.h:234: write_vram(tiles, 1, 0); // --> vram pattern address (0x0000)
	ld	hl, #0x0000
	push	hl
	ld	de, #0x0001
	ld	hl, #2
	add	hl, sp
	call	_write_vram
;./inc/basic.h:235: write_vram_2(tilemap, _SCREEN_TILES_SIZE, 0x3800); // 32 * 24 (768) tiles --> vram tile map address (0x3800)
	ld	de, (__SCREEN_TILES_SIZE)
	ld	hl, #0x3800
	push	hl
	ld	hl, #258
	add	hl, sp
	call	_write_vram_2
;./inc/basic.h:237: }
	ld	sp, ix
	pop	ix
	ret
;./inc/basic.h:262: void vblankISR(void) __critical __interrupt(0){
;	---------------------------------
; Function vblankISR
; ---------------------------------
_vblankISR::
	push	af
	push	bc
	push	de
	push	hl
	push	iy
;./inc/basic.h:264: vblank_ocurrido = true;
	ld	hl, #_vblank_ocurrido
	ld	(hl), #0x01
;./inc/basic.h:265: vdp_status = VDP_ADDRESS;
	in	a, (_VDP_ADDRESS)
	ld	(_vdp_status+0), a
;./inc/basic.h:266: }
	pop	iy
	pop	hl
	pop	de
	pop	bc
	pop	af
	ei
	reti
;./inc/basic.h:276: void toVblankISR(void){
;	---------------------------------
; Function toVblankISR
; ---------------------------------
_toVblankISR::
;./inc/basic.h:277: __asm__("di"); //; Des-Habilitar interrupciones
	di
;./inc/basic.h:279: if (!_PAUSE){
	ld	iy, #__PAUSE
	bit	0, 0 (iy)
	jr	NZ, 00104$
;./inc/basic.h:282: draw(_DELTA, _MASTER); // main.h
	ld	a, (__MASTER+0)
	push	af
	inc	sp
	ld	de, (__DELTA)
	ld	hl, (__DELTA + 2)
	call	_draw
;./inc/basic.h:284: ++_MASTER;
	ld	iy, #__MASTER
	inc	0 (iy)
;./inc/basic.h:285: if(_MASTER > _MASTER_MAX){ _MASTER = 0; }
	ld	a, (__MASTER_MAX+0)
	ld	c, a
	sub	a, 0 (iy)
	jr	NC, 00104$
	ld	0 (iy), #0x00
00104$:
;./inc/basic.h:287: _DELTA = 0;
	xor	a, a
	ld	(__DELTA+0), a
	ld	(__DELTA+1), a
	ld	(__DELTA+2), a
	ld	(__DELTA+3), a
;./inc/basic.h:288: __asm__("ei"); //; Habilitar interrupciones
	ei
;./inc/basic.h:291: vdp_status = VDP_ADDRESS;
	in	a, (_VDP_ADDRESS)
	ld	(_vdp_status+0), a
;./inc/basic.h:293: vblank_ocurrido = false;
	ld	hl, #_vblank_ocurrido
	ld	(hl), #0x00
;./inc/basic.h:294: }
	ret
;./inc/basic.h:300: void nmISR(void) __critical __interrupt(1) {}
;	---------------------------------
; Function nmISR
; ---------------------------------
_nmISR::
	ei
	reti
;./inc/main.h:63: void loop(void){
;	---------------------------------
; Function loop
; ---------------------------------
_loop::
;./inc/main.h:64: while (last_state == game_state){
00106$:
	ld	a, (_last_state+0)
	ld	hl, #_game_state
	sub	a, (hl)
	ret	NZ
;./inc/main.h:66: while (!vblank_ocurrido){
00101$:
	ld	a, (_vblank_ocurrido+0)
	or	a, a
	jr	NZ, 00103$
;./inc/main.h:67: update_fast();
	call	_update_fast
	jr	00101$
00103$:
;./inc/main.h:71: toVblankISR();
	call	_toVblankISR
;./inc/main.h:75: if (!_PAUSE){
	ld	hl, #__PAUSE
	bit	0, (hl)
	jr	NZ, 00106$
;./inc/main.h:82: update(_DELTA, _MASTER);
	ld	a, (__MASTER+0)
	push	af
	inc	sp
	ld	de, (__DELTA)
	ld	hl, (__DELTA + 2)
	call	_update
;./inc/main.h:85: }
	jr	00106$
;./inc/simpleSounds.h:25: void playEffectSound(uint8_t msg, uint8_t tono, uint8_t vol, int8_t rep){
;	---------------------------------
; Function playEffectSound
; ---------------------------------
_playEffectSound::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	c, a
	ld	b, l
;./inc/simpleSounds.h:26: if (rep > 0){
	xor	a, a
	sub	a, 5 (ix)
	jp	PO, 00110$
	xor	a, #0x80
00110$:
	jp	P, 00103$
;./inc/simpleSounds.h:32: PSG = 0x8B; // Byte bajo de tono (Canal 0)
	ld	a, #0x8b
	out	(_PSG), a
;./inc/simpleSounds.h:33: PSG = tono; // Byte alto de tono (Canal 0)
	ld	a, b
	out	(_PSG), a
;./inc/simpleSounds.h:36: PSG = 0x90 + vol; // 1001 0000 (Canal 0, Volumen Máximo)
	ld	a, 4 (ix)
	add	a, #0x90
	out	(_PSG), a
;./inc/simpleSounds.h:38: delay(msg * 10);
	ld	e, c
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	push	hl
	push	bc
	call	_delay
	pop	bc
	pop	hl
;./inc/simpleSounds.h:41: PSG = 0x9F;
	ld	a, #0x9f
	out	(_PSG), a
;./inc/simpleSounds.h:43: delay(msg * 10);
	push	bc
	call	_delay
	pop	bc
;./inc/simpleSounds.h:45: playEffectSound(msg, tono, vol, --rep);
	dec	5 (ix)
	ld	h, 5 (ix)
	ld	l, 4 (ix)
	push	hl
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	a, c
	call	_playEffectSound
00103$:
;./inc/simpleSounds.h:47: }
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
;./inc/simpleSounds.h:52: void playBeep(uint8_t msg, int8_t rep){
;	---------------------------------
; Function playBeep
; ---------------------------------
_playBeep::
	ld	c, a
	ld	b, l
;./inc/simpleSounds.h:53: playEffectSound(msg, 0x09, 0, rep);
	push	bc
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	l, #0x09
;	spillPairReg hl
;	spillPairReg hl
	ld	a, c
	call	_playEffectSound
;./inc/simpleSounds.h:54: }
	ret
;./inc/simpleSounds.h:59: void mute(int8_t canal) {
;	---------------------------------
; Function mute
; ---------------------------------
_mute::
;./inc/simpleSounds.h:61: if(canal < 1){ PSG = 0x9F; } // 10011111
	ld	c, a
	xor	a, #0x80
	sub	a, #0x81
	jr	NC, 00102$
	ld	a, #0x9f
	out	(_PSG), a
00102$:
;./inc/simpleSounds.h:63: if(canal == -1 || canal == 1){ PSG = 0xBF; } // 10111111
	ld	a, c
	inc	a
	ld	a, #0x01
	jr	Z, 00135$
	xor	a, a
00135$:
	ld	b, a
	or	a, a
	jr	NZ, 00103$
	ld	a, c
	dec	a
	jr	NZ, 00104$
00103$:
	ld	a, #0xbf
	out	(_PSG), a
00104$:
;./inc/simpleSounds.h:65: if(canal == -1 || canal == 2){ PSG = 0xDF; } // 11011111
	ld	a, b
	or	a, a
	jr	NZ, 00106$
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00107$
00106$:
	ld	a, #0xdf
	out	(_PSG), a
00107$:
;./inc/simpleSounds.h:67: if(canal == -1 || canal == 3){ PSG = 0xFF; } // 11111111
	ld	a, b
	or	a, a
	jr	NZ, 00109$
	ld	a, c
	sub	a, #0x03
	ret	NZ
00109$:
	ld	a, #0xff
	out	(_PSG), a
;./inc/simpleSounds.h:68: }
	ret
;./inc/spritesManager.h:36: void load_palette(uint8_t *pal){
;	---------------------------------
; Function load_palette
; ---------------------------------
_load_palette::
	ex	de, hl
;./inc/spritesManager.h:37: write_palette(PALETTE_OFFSET_SPRITES, pal);
	ld	a, #0x10
;./inc/spritesManager.h:40: }
	jp	_write_palette
;./inc/spritesManager.h:46: void load_sprite(const sGraphic *spr, uint16_t vram_addr){
;	---------------------------------
; Function load_sprite
; ---------------------------------
_load_sprite::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	c, l
	ld	b, h
;./inc/spritesManager.h:48: load_palette(spr->pal);
	push	bc
	pop	iy
	ld	l, 6 (iy)
;	spillPairReg hl
	ld	h, 7 (iy)
;	spillPairReg hl
	push	bc
	push	de
	call	_load_palette
	pop	de
	pop	bc
;./inc/spritesManager.h:50: write_vram(spr->tiles, spr->size, vram_addr); //, _VRAM_SPRITE_PATT);
	push	bc
	pop	iy
	ld	a, 9 (iy)
	ld	-2 (ix), a
	ld	a, 10 (iy)
	ld	-1 (ix), a
	ld	hl, #11
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	push	de
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	call	_write_vram
;./inc/spritesManager.h:51: }
	ld	sp, ix
	pop	ix
	ret
;./inc/spritesManager.h:74: void toTilesgifyDefineUpdate(sGraphic *spr, int8_t id, int8_t posX, int8_t posY, uint8_t last){
;	---------------------------------
; Function toTilesgifyDefineUpdate
; ---------------------------------
_toTilesgifyDefineUpdate::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-13
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
;./inc/spritesManager.h:75: if(!spr || !spr->dirty){ return; } // si no es redibujable sale
	ld	a, b
	or	a, c
	jp	Z,00128$
	ld	hl, #0x0015
	add	hl, bc
	ex	(sp), hl
	pop	hl
	push	hl
	ld	e, (hl)
	bit	0, e
	jp	Z,00128$
;./inc/spritesManager.h:76: if(id > -1){ spr->id = id; }
	ld	a, #0xff
	sub	a, 4 (ix)
	jp	PO, 00199$
	xor	a, #0x80
00199$:
	jp	P, 00105$
	ld	a, 4 (ix)
	ld	(bc), a
00105$:
;./inc/spritesManager.h:77: if(posX > -1){ spr->x = posX; }
	ld	hl, #0x0004
	add	hl, bc
	ld	-6 (ix), l
	ld	-5 (ix), h
	ld	a, #0xff
	sub	a, 5 (ix)
	jp	PO, 00200$
	xor	a, #0x80
00200$:
	jp	P, 00107$
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a, 5 (ix)
	ld	(hl), a
00107$:
;./inc/spritesManager.h:78: if(posY > -1){ spr->y = posY; }
	ld	hl, #0x0005
	add	hl, bc
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, #0xff
	sub	a, 6 (ix)
	jp	PO, 00201$
	xor	a, #0x80
00201$:
	jp	P, 00109$
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, 6 (ix)
	ld	(hl), a
00109$:
;./inc/spritesManager.h:95: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF) + spr->yAddress; //spr->id;  // 0 + row; //
	ld	de, (__VRAM_SPRITE_INFO_Y)
	ld	a, e
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:96: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F));  // 0x3f;// // 0x40
	ld	a, d
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:99: for (row = 0; row < spr->h; row++){
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	hl, #0x000f
	add	hl, bc
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	hl, #0x0010
	add	hl, bc
	ld	-11 (ix), l
	ld	-10 (ix), h
	ld	-4 (ix), #0x00
00120$:
	ld	l, -11 (ix)
	ld	h, -10 (ix)
;	spillPairReg hl
	ld	a,-4 (ix)
	sub	a,(hl)
	jr	NC, 00111$
;./inc/spritesManager.h:100: for (col = 0; col < spr->w; col++){
	ld	-3 (ix), #0x00
00117$:
	ld	l, -2 (ix)
	ld	h, -1 (ix)
;	spillPairReg hl
	ld	a,-3 (ix)
	sub	a,(hl)
	jr	NC, 00121$
;./inc/spritesManager.h:101: VDP_DATA = spr->y + (row*8);// siguiente fila es * 8 pixels;
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -4 (ix)
	add	a, a
	add	a, a
	add	a, a
	add	a, l
	out	(_VDP_DATA), a
;./inc/spritesManager.h:100: for (col = 0; col < spr->w; col++){
	inc	-3 (ix)
	jr	00117$
00121$:
;./inc/spritesManager.h:99: for (row = 0; row < spr->h; row++){
	inc	-4 (ix)
	jr	00120$
00111$:
;./inc/spritesManager.h:104: if(last > 0){ VDP_DATA = _VRAM_SPRITE_END; } // end of sprite list (sprite_y = 208)
	ld	a, 7 (ix)
	or	a, a
	jr	Z, 00113$
	ld	a, (__VRAM_SPRITE_END+0)
	out	(_VDP_DATA), a
00113$:
;./inc/spritesManager.h:107: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress; //spr->id;       // 0x80 + col; //
	ld	de, (__VRAM_SPRITE_INFO_X)
	ld	a, e
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:108: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
	ld	a, d
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:109: for (row = 0; row < spr->h; row++){
	ld	a, -6 (ix)
	ld	-9 (ix), a
	ld	a, -5 (ix)
	ld	-8 (ix), a
	ld	-7 (ix), c
	ld	-6 (ix), b
	ld	a, -2 (ix)
	ld	-5 (ix), a
	ld	a, -1 (ix)
	ld	-4 (ix), a
	ld	-2 (ix), #0x00
00126$:
	ld	l, -11 (ix)
	ld	h, -10 (ix)
	ld	c, (hl)
	ld	a, -2 (ix)
	sub	a, c
	jr	NC, 00115$
;./inc/spritesManager.h:110: for (col = 0; col < spr->w; col++){
	ld	-1 (ix), #0x00
00123$:
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	a,-1 (ix)
	sub	a,(hl)
	jr	NC, 00127$
;./inc/spritesManager.h:111: VDP_DATA = spr->x + (col*8); // siguiente columna es * 8 pixels
	ld	l, -9 (ix)
	ld	h, -8 (ix)
	ld	a, (hl)
	ld	-3 (ix), a
	ld	a, -1 (ix)
	add	a, a
	add	a, a
	add	a, a
	ld	c, -3 (ix)
	add	a, c
	out	(_VDP_DATA), a
;./inc/spritesManager.h:112: VDP_DATA = spr->img[(row * spr->w) + col]; // tile number of sprite tiles
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	de, #0x000d
	add	hl, de
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	e, (hl)
	push	bc
	ld	h, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00202$:
	add	hl, hl
	jr	NC, 00203$
	add	hl, de
00203$:
	djnz	00202$
	pop	bc
	ld	e, -1 (ix)
	ld	d, #0x00
	add	hl, de
	add	hl, bc
	ld	a, (hl)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:110: for (col = 0; col < spr->w; col++){
	inc	-1 (ix)
	jr	00123$
00127$:
;./inc/spritesManager.h:109: for (row = 0; row < spr->h; row++){
	inc	-2 (ix)
	jr	00126$
00115$:
;./inc/spritesManager.h:116: spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
	pop	hl
	push	hl
	ld	(hl), #0x00
00128$:
;./inc/spritesManager.h:117: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;./inc/spritesManager.h:128: void toAniDefine(sGraphic *spr, int8_t posX, int8_t posY, int8_t aniIndex, uint8_t last){
;	---------------------------------
; Function toAniDefine
; ---------------------------------
_toAniDefine::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	c, l
	ld	b, h
;./inc/spritesManager.h:129: if(posX > -1){ spr->x = posX; }
	ld	hl, #0x0004
	add	hl, bc
	ex	(sp), hl
	ld	a, #0xff
	sub	a, 4 (ix)
	jp	PO, 00131$
	xor	a, #0x80
00131$:
	jp	P, 00102$
	pop	hl
	push	hl
	ld	a, 4 (ix)
	ld	(hl), a
00102$:
;./inc/spritesManager.h:130: if(posY > -1){ spr->y = posY; }
	ld	hl, #0x0005
	add	hl, bc
	ex	de, hl
	ld	a, #0xff
	sub	a, 5 (ix)
	jp	PO, 00132$
	xor	a, #0x80
00132$:
	jp	P, 00104$
	ld	a, 5 (ix)
	ld	(de), a
00104$:
;./inc/spritesManager.h:131: if(aniIndex > -1){ spr->i = aniIndex;
	ld	hl, #0x0011
	add	hl, bc
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	a, #0xff
	sub	a, 6 (ix)
	jp	PO, 00133$
	xor	a, #0x80
00133$:
	jp	P, 00106$
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, 6 (ix)
	ld	(hl), a
00106$:
;./inc/spritesManager.h:134: load_palette(spr->pal);
	push	bc
	pop	iy
	ld	l, 6 (iy)
;	spillPairReg hl
	ld	h, 7 (iy)
;	spillPairReg hl
	push	bc
	push	de
	call	_load_palette
	pop	de
	pop	bc
;./inc/spritesManager.h:137: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF) + spr->yAddress;//spr->id;  // 0 + row; //
	ld	hl, (__VRAM_SPRITE_INFO_Y)
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, -2 (ix)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:138: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F)); // 0x3f;// // 0x40
	ld	a, -1 (ix)
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:139: VDP_DATA = spr->y;
	ld	a, (de)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:140: if(last > 0){ VDP_DATA = _VRAM_SPRITE_END; } // end of sprite list (sprite_y = 208)
	ld	a, 7 (ix)
	or	a, a
	jr	Z, 00108$
	ld	a, (__VRAM_SPRITE_END+0)
	out	(_VDP_DATA), a
00108$:
;./inc/spritesManager.h:143: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress;//spr->id + 1;// * 2;       // 0x80 + col; //
	ld	de, (__VRAM_SPRITE_INFO_X)
	ld	a, e
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:144: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
	ld	a, d
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:145: VDP_DATA = spr->x;
	pop	hl
	push	hl
	ld	a, (hl)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:147: VDP_DATA = spr->ani[spr->i]; // tile number of sprite tile
	ld	hl, #18
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	l, (hl)
;	spillPairReg hl
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:148: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;./inc/spritesManager.h:151: void toAniIndex(sGraphic *spr, int8_t aniIndex){
;	---------------------------------
; Function toAniIndex
; ---------------------------------
_toAniIndex::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	ld	c, l
	ld	b, h
;./inc/spritesManager.h:152: if(!spr || !spr->dirty){ return; } // si no es redibujable sale
	ld	a, b
	or	a, c
	jr	Z, 00106$
	ld	hl, #0x0015
	add	hl, bc
	ex	de, hl
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	bit	0,a
	jr	Z, 00106$
;./inc/spritesManager.h:153: if(aniIndex > -1){ spr->i = aniIndex; }
	ld	hl, #0x0011
	add	hl, bc
	ex	(sp), hl
	ld	a, #0xff
	sub	a, 4 (ix)
	jp	PO, 00118$
	xor	a, #0x80
00118$:
	jp	P, 00105$
	pop	hl
	push	hl
	ld	a, 4 (ix)
	ld	(hl), a
00105$:
;./inc/spritesManager.h:158: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress + 1;//spr->id + 1 + 1;// * 2 + 1;       // se salta la X
	ld	hl, (__VRAM_SPRITE_INFO_X)
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, -2 (ix)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	inc	a
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:159: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
	ld	a, -1 (ix)
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:161: VDP_DATA = spr->ani[spr->i]; // tile number of sprite tile
	ld	hl, #18
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	pop	hl
	push	hl
	ld	l, (hl)
;	spillPairReg hl
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:162: spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
	xor	a, a
	ld	(de), a
00106$:
;./inc/spritesManager.h:163: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;./inc/spritesManager.h:167: void toAniPos(sGraphic *spr, int8_t posX, int8_t posY){
;	---------------------------------
; Function toAniPos
; ---------------------------------
_toAniPos::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	c, l
	ld	b, h
;./inc/spritesManager.h:168: if(!spr || !spr->dirty){ return; } // si no es redibujable sale
	ld	a, b
	or	a, c
	jp	Z,00108$
	ld	hl, #0x0015
	add	hl, bc
	ex	(sp), hl
	pop	hl
	push	hl
	ld	e, (hl)
	bit	0, e
	jp	Z,00108$
;./inc/spritesManager.h:169: if(posX > -1){ spr->x = posX; }
	ld	hl, #0x0004
	add	hl, bc
	ex	de, hl
	ld	a, #0xff
	sub	a, 4 (ix)
	jp	PO, 00125$
	xor	a, #0x80
00125$:
	jp	P, 00105$
	ld	a, 4 (ix)
	ld	(de), a
00105$:
;./inc/spritesManager.h:170: if(posY > -1){ spr->y = posY; }
	ld	hl, #0x0005
	add	hl, bc
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	a, #0xff
	sub	a, 5 (ix)
	jp	PO, 00126$
	xor	a, #0x80
00126$:
	jp	P, 00107$
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, 5 (ix)
	ld	(hl), a
00107$:
;./inc/spritesManager.h:175: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF) + spr->yAddress;//spr->id;          // 0 + row; //
	ld	hl, (__VRAM_SPRITE_INFO_Y)
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, -2 (ix)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:176: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F)); // 0x3f;// // 0x40
	ld	a, -1 (ix)
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:177: VDP_DATA = spr->y;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:181: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress;//spr->id + 1;// * 2;          // 0x80 + col; //
	ld	hl, (__VRAM_SPRITE_INFO_X)
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, -2 (ix)
	ld	l, c
	ld	h, b
	inc	hl
	ld	c, (hl)
	add	a, c
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:182: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
	ld	a, -1 (ix)
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:183: VDP_DATA = spr->x;
	ld	a, (de)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:184: spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
	pop	hl
	push	hl
	ld	(hl), #0x00
00108$:
;./inc/spritesManager.h:185: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
;./inc/spritesManager.h:191: void toAniIndexPos(sGraphic *spr, int8_t aniIndex, int8_t posX, int8_t posY){
;	---------------------------------
; Function toAniIndexPos
; ---------------------------------
_toAniIndexPos::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-8
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
;./inc/spritesManager.h:192: if(!spr || !spr->dirty){ return; } // si no es redibujable sale
	ld	a, b
	or	a, c
	jp	Z,00110$
	ld	hl, #0x0015
	add	hl, bc
	ex	(sp), hl
	pop	hl
	push	hl
	ld	e, (hl)
	bit	0, e
	jp	Z,00110$
;./inc/spritesManager.h:193: if(aniIndex > -1){ spr->i = aniIndex; }
	ld	hl, #0x0011
	add	hl, bc
	ex	de, hl
	ld	a, #0xff
	sub	a, 4 (ix)
	jp	PO, 00132$
	xor	a, #0x80
00132$:
	jp	P, 00105$
	ld	a, 4 (ix)
	ld	(de), a
00105$:
;./inc/spritesManager.h:194: if(posX > -1){ spr->x = posX; }
	ld	hl, #0x0004
	add	hl, bc
	ld	-6 (ix), l
	ld	-5 (ix), h
	ld	a, #0xff
	sub	a, 5 (ix)
	jp	PO, 00133$
	xor	a, #0x80
00133$:
	jp	P, 00107$
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a, 5 (ix)
	ld	(hl), a
00107$:
;./inc/spritesManager.h:195: if(posY > -1){ spr->y = posY; }
	ld	hl, #0x0005
	add	hl, bc
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	a, #0xff
	sub	a, 6 (ix)
	jp	PO, 00134$
	xor	a, #0x80
00134$:
	jp	P, 00109$
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, 6 (ix)
	ld	(hl), a
00109$:
;./inc/spritesManager.h:200: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF) + spr->yAddress;//spr->id;          // 0 + row; //
	ld	hl, (__VRAM_SPRITE_INFO_Y)
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, -2 (ix)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:201: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F)); // 0x3f;// // 0x40
	ld	a, -1 (ix)
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:202: VDP_DATA = spr->y;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:206: VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress;//spr->id + 1;// * 2;          // 0x80 + col; //
	ld	hl, (__VRAM_SPRITE_INFO_X)
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, -2 (ix)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:207: VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
	ld	a, -1 (ix)
	and	a, #0x3f
	or	a, #0x40
	out	(_VDP_ADDRESS), a
;./inc/spritesManager.h:208: VDP_DATA = spr->x;
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	a, (hl)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:209: VDP_DATA = spr->ani[spr->i]; // tile number of sprite tile
	ld	hl, #18
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	out	(_VDP_DATA), a
;./inc/spritesManager.h:210: spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
	pop	hl
	push	hl
	ld	(hl), #0x00
00110$:
;./inc/spritesManager.h:211: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	inc	sp
	jp	(hl)
;./inc/spritesManager.h:219: void moveDef(oMove *oM, int8_t xIncr, uint8_t xMin, uint8_t xMax, int8_t yIncr, uint8_t yMin, uint8_t yMax){
;	---------------------------------
; Function moveDef
; ---------------------------------
_moveDef::
	push	ix
	ld	ix,#0
	add	ix,sp
;./inc/spritesManager.h:220: oM->xCount = 0;
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;./inc/spritesManager.h:221: oM->xIncr = xIncr;
	ld	hl, #0x0004
	add	hl, de
	ld	a, 4 (ix)
	ld	(hl), a
;./inc/spritesManager.h:222: oM->xMin = xMin;
	ld	hl, #0x0005
	add	hl, de
	ld	a, 5 (ix)
	ld	(hl), a
;./inc/spritesManager.h:223: oM->xMax = xMax;
	ld	hl, #0x0006
	add	hl, de
	ld	a, 6 (ix)
	ld	(hl), a
;./inc/spritesManager.h:224: oM->yCount = 0;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;./inc/spritesManager.h:225: oM->yIncr = yIncr;
	ld	hl, #0x0007
	add	hl, de
	ld	a, 7 (ix)
	ld	(hl), a
;./inc/spritesManager.h:226: oM->yMin = yMin;
	ld	hl, #0x0008
	add	hl, de
	ld	a, 8 (ix)
	ld	(hl), a
;./inc/spritesManager.h:227: oM->yMax = yMax;
	ld	hl, #0x0009
	add	hl, de
	ld	a, 9 (ix)
	ld	(hl), a
;./inc/spritesManager.h:228: }
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	jp	(hl)
;./inc/spritesManager.h:240: int8_t moveWith(sGraphic* sG, bool autoChange){
;	---------------------------------
; Function moveWith
; ---------------------------------
_moveWith::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-12
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
;./inc/spritesManager.h:241: int8_t limit = -1;
	ld	-12 (ix), #0xff
;./inc/spritesManager.h:242: int8_t change = (autoChange ? -1 : 0);
	bit	0, 4 (ix)
	jr	Z, 00119$
	ld	bc, #0xffff
	jr	00120$
00119$:
	ld	bc, #0x0000
00120$:
	ld	-11 (ix), c
;./inc/spritesManager.h:244: if(sG->oM == NULL){ return limit; }
	ld	a, -2 (ix)
	add	a, #0x16
	ld	-10 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-9 (ix), a
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	ld	-7 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-6 (ix), a
	or	a, -7 (ix)
	jr	NZ, 00102$
	ld	a, #0xff
	jp	00117$
00102$:
;./inc/spritesManager.h:245: sG->x += sG->oM->xIncr;
	ld	a, -2 (ix)
	add	a, #0x04
	ld	-4 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	ld	-5 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	de, #0x0004
	add	hl, de
	ld	a, (hl)
	ld	-6 (ix), a
	ld	a, -5 (ix)
	add	a, -6 (ix)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), a
;./inc/spritesManager.h:246: if (sG->x >= sG->oM->xMax){
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	ld	-7 (ix), a
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	ld	-4 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	ld	-6 (ix), a
	ld	a, -3 (ix)
	ld	-5 (ix), a
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	de, #0x0006
	add	hl, de
	ld	a, (hl)
	ld	-8 (ix), a
;./inc/spritesManager.h:247: sG->oM->xIncr *= change; //-1
	ld	a, -4 (ix)
	add	a, #0x04
	ld	-6 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-5 (ix), a
;./inc/spritesManager.h:246: if (sG->x >= sG->oM->xMax){
	ld	a, -7 (ix)
	sub	a, -8 (ix)
	jr	C, 00106$
;./inc/spritesManager.h:247: sG->oM->xIncr *= change; //-1
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	e, (hl)
	ld	h, -11 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00161$:
	add	hl, hl
	jr	NC, 00162$
	add	hl, de
00162$:
	djnz	00161$
	ld	c, l
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	(hl), c
;./inc/spritesManager.h:248: sG->oM->xCount++;    // CONTADOR INTERNO DE LOS MARKADORES
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	dec	hl
	inc	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
;./inc/spritesManager.h:249: limit = 0;
	ld	-12 (ix), #0x00
	jr	00107$
00106$:
;./inc/spritesManager.h:250: } else if (sG->x <= sG->oM->xMin){
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	de, #0x0005
	add	hl, de
	ld	a, (hl)
	sub	a, -7 (ix)
	jr	C, 00107$
;./inc/spritesManager.h:251: sG->oM->xIncr *= change; // 1
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	e, (hl)
	ld	h, -11 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00163$:
	add	hl, hl
	jr	NC, 00164$
	add	hl, de
00164$:
	djnz	00163$
	ld	c, l
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	(hl), c
;./inc/spritesManager.h:252: sG->oM->xCount++;     // CONTADOR INTERNO DE LOS MARKADORES
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	dec	hl
	inc	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
;./inc/spritesManager.h:253: limit = 1;
	ld	-12 (ix), #0x01
00107$:
;./inc/spritesManager.h:255: sG->y += sG->oM->yIncr;
	ld	a, -2 (ix)
	add	a, #0x05
	ld	-4 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	ld	-5 (ix), a
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	ld	-7 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-6 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	de, #0x0007
	add	hl, de
	ld	a, (hl)
	ld	-6 (ix), a
	ld	a, -5 (ix)
	add	a, -6 (ix)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), a
;./inc/spritesManager.h:256: if (sG->y >= sG->oM->yMax){
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	ld	-8 (ix), a
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	ld	-7 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-6 (ix), a
	ld	a, -7 (ix)
	ld	-4 (ix), a
	ld	a, -6 (ix)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	de, #0x0009
	add	hl, de
	ld	a, (hl)
	ld	-5 (ix), a
;./inc/spritesManager.h:257: sG->oM->yIncr *= change; // -1
	ld	a, -7 (ix)
	add	a, #0x07
	ld	-4 (ix), a
	ld	a, -6 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
;./inc/spritesManager.h:256: if (sG->y >= sG->oM->yMax){
	ld	a, -8 (ix)
	sub	a, -5 (ix)
	jr	C, 00111$
;./inc/spritesManager.h:257: sG->oM->yIncr *= change; // -1
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	e, (hl)
	ld	h, -11 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00165$:
	add	hl, hl
	jr	NC, 00166$
	add	hl, de
00166$:
	djnz	00165$
	ld	c, l
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), c
;./inc/spritesManager.h:258: sG->oM->yCount++;        // CONTADOR INTERNO DE LOS MARKADORES
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ex	de, hl
	inc	hl
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	dec	hl
	inc	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
;./inc/spritesManager.h:259: limit = 2;
	ld	-12 (ix), #0x02
	jr	00112$
00111$:
;./inc/spritesManager.h:260: } else if (sG->y <= sG->oM->yMin){
	ld	c, -7 (ix)
	ld	b, -6 (ix)
	ld	hl, #8
	add	hl, bc
	ld	a, (hl)
	sub	a, -8 (ix)
	jr	C, 00112$
;./inc/spritesManager.h:261: sG->oM->yIncr *= change; // 1
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	e, (hl)
	ld	h, -11 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00167$:
	add	hl, hl
	jr	NC, 00168$
	add	hl, de
00168$:
	djnz	00167$
	ld	c, l
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	(hl), c
;./inc/spritesManager.h:262: sG->oM->yCount++;        // CONTADOR INTERNO DE LOS MARKADORES
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	dec	hl
	inc	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
;./inc/spritesManager.h:263: limit = 3;
	ld	-12 (ix), #0x03
00112$:
;./inc/spritesManager.h:266: if (sG->oM->xCount >= 65534){
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	ld	-4 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, c
	sub	a, #0xfe
	ld	a, b
	sbc	a, #0xff
	jr	C, 00114$
;./inc/spritesManager.h:267: sG->oM->xCount = 0;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
00114$:
;./inc/spritesManager.h:269: if (sG->oM->yCount >= 65534){
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	ld	-4 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	add	a, #0x02
	ld	-6 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-5 (ix), a
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, c
	sub	a, #0xfe
	ld	a, b
	sbc	a, #0xff
	jr	C, 00116$
;./inc/spritesManager.h:270: sG->oM->yCount = 0;
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
00116$:
;./inc/spritesManager.h:272: sG->dirty = true; // lo marca como redibujable porque ha cambiado de posición
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	de, #0x0015
	add	hl, de
	ld	(hl), #0x01
;./inc/spritesManager.h:273: return limit;
	ld	a, -12 (ix)
00117$:
;./inc/spritesManager.h:274: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;./inc/spritesManager.h:281: bool isColission(sGraphic* sG1, sGraphic* sG2){
;	---------------------------------
; Function isColission
; ---------------------------------
_isColission::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	c, l
	ld	b, h
	ld	-2 (ix), e
	ld	-1 (ix), d
;./inc/spritesManager.h:291: if (sG1->x + (sG1->w * 8) < sG2->x) return false; // s1 está a la izquierda de s2
	push	bc
	pop	iy
	ld	e, 4 (iy)
	ld	d, #0x00
	push	bc
	pop	iy
	ld	l, 15 (iy)
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ex	(sp), hl
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	-4 (ix), a
	ld	-3 (ix), #0x00
	ld	a, -6 (ix)
	sub	a, -4 (ix)
	ld	a, -5 (ix)
	sbc	a, -3 (ix)
	jp	PO, 00131$
	xor	a, #0x80
00131$:
	jp	P, 00102$
	xor	a, a
	jp	00109$
00102$:
;./inc/spritesManager.h:292: if (sG1->x > sG2->x + (sG2->w * 8)) return false; // s1 está a la derecha de s2
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	ld	bc, #0x000f
	add	hl, bc
	pop	bc
	ld	l, (hl)
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, -4 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -3 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	sub	a, e
	ld	a, h
	sbc	a, d
	jp	PO, 00132$
	xor	a, #0x80
00132$:
	jp	P, 00104$
	xor	a, a
	jr	00109$
00104$:
;./inc/spritesManager.h:293: if (sG1->y + (sG1->h * 8) < sG2->y)  return false; // s1 está arriba de s2
	ld	e, c
	ld	d, b
	ld	hl, #5
	add	hl, de
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #16
	add	hl, bc
	ld	l, (hl)
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	c, -2 (ix)
	ld	b, -1 (ix)
	ld	hl, #5
	add	hl, bc
	ld	c, (hl)
	ld	b, #0x00
	ld	a, -4 (ix)
	sub	a, c
	ld	a, -3 (ix)
	sbc	a, b
	jp	PO, 00133$
	xor	a, #0x80
00133$:
	jp	P, 00106$
	xor	a, a
	jr	00109$
00106$:
;./inc/spritesManager.h:294: if (sG1->y > sG2->y + (sG2->h * 8))  return false; // s1 está debajo de s2
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	ld	bc, #0x0010
	add	hl, bc
	pop	bc
	ld	l, (hl)
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, l
	sub	a, e
	ld	a, h
	sbc	a, d
	jp	PO, 00134$
	xor	a, #0x80
00134$:
	jp	P, 00108$
	xor	a, a
	jr	00109$
00108$:
;./inc/spritesManager.h:296: return true; // Hay colisión
	ld	a, #0x01
00109$:
;./inc/spritesManager.h:297: }
	ld	sp, ix
	pop	ix
	ret
;./inc/spritesManager.h:318: void update_jumpV(sGraphic *sG){
;	---------------------------------
; Function update_jumpV
; ---------------------------------
_update_jumpV::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-8
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
;./inc/spritesManager.h:319: if (sG->sJ && sG->sJ->is_jumping) {
	ld	a, -2 (ix)
	add	a, #0x18
	ld	c, a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	b, a
	ld	l, c
	ld	h, b
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	l,a
	or	a,h
	jp	Z, 00106$
	bit	0, (hl)
	jp	Z, 00106$
;./inc/spritesManager.h:321: sG->y -= sG->sJ->jump_velocity;
	ld	a, -2 (ix)
	add	a, #0x05
	ld	e, a
	ld	a, -1 (ix)
	inc	hl
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	l, (hl)
;	spillPairReg hl
	sub	a, l
	ld	(de), a
;./inc/spritesManager.h:324: sG->sJ->jump_velocity -= sG->sJ->gravity;
	ld	a, (bc)
	ld	-4 (ix), a
	inc	bc
	ld	a, (bc)
	ld	-3 (ix), a
	dec	bc
	ld	a, -4 (ix)
	add	a, #0x01
	ld	-8 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-7 (ix), a
	pop	hl
	push	hl
	ld	a, (hl)
	ld	-6 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-5 (ix), a
	ld	l, -4 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -3 (ix)
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -6 (ix)
	sub	a, l
	ld	-4 (ix), a
	ld	a, -5 (ix)
	sbc	a, h
	ld	-3 (ix), a
	pop	hl
	push	hl
	ld	a, -4 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -3 (ix)
	ld	(hl), a
;./inc/spritesManager.h:327: if (sG->y >= sG->sJ->ground_y) {
	ld	a, (de)
	ld	-4 (ix), a
	ld	l, c
	ld	h, b
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	sub	a, -3 (ix)
	jr	C, 00102$
;./inc/spritesManager.h:328: sG->y = sG->sJ->ground_y;
	ld	a, -3 (ix)
	ld	(de), a
;./inc/spritesManager.h:329: sG->sJ->is_jumping = false;
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	xor	a, a
	ld	(de), a
;./inc/spritesManager.h:330: sG->sJ->jump_velocity = 0;
	ld	l, c
	ld	h, b
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	bc
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
00102$:
;./inc/spritesManager.h:332: sG->dirty = true; // lo marca como redibujable porque ha cambiado de posición
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	de, #0x0015
	add	hl, de
	ld	(hl), #0x01
00106$:
;./inc/spritesManager.h:334: }
	ld	sp, ix
	pop	ix
	ret
;./inc/spritesManager.h:338: void trigger_jumpV(sGraphic *sG, int16_t vel){
;	---------------------------------
; Function trigger_jumpV
; ---------------------------------
_trigger_jumpV::
	ld	c, l
	ld	b, h
;./inc/spritesManager.h:339: if (sG->sJ && !sG->sJ->is_jumping) {
	ld	iy, #0x0018
	add	iy, bc
	ld	l, 0 (iy)
;	spillPairReg hl
	ld	h, 1 (iy)
;	spillPairReg hl
	ld	a, h
	or	a, l
	ret	Z
	bit	0, (hl)
	ret	NZ
;./inc/spritesManager.h:340: sG->sJ->is_jumping = true;
	ld	(hl), #0x01
;./inc/spritesManager.h:341: sG->sJ->jump_velocity = vel; //8; // Velocidad inicial del salto (impulso hacia arriba)
	ld	l, 0 (iy)
;	spillPairReg hl
	ld	h, 1 (iy)
;	spillPairReg hl
	inc	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
;./inc/spritesManager.h:343: }
	ret
;src/stage_intro.h:26: game_state_e init_intro(void){
;	---------------------------------
; Function init_intro
; ---------------------------------
_init_intro::
;src/stage_intro.h:27: game_state = game_intro;
	ld	hl, #_game_state
	ld	(hl), #0x00
;src/stage_intro.h:28: last_state = game_state;
	ld	hl, #_last_state
	ld	(hl), #0x00
;src/stage_intro.h:29: count = 0;
	ld	hl, #0x0000
	ld	(_count), hl
;src/stage_intro.h:30: _DELTA = 0;
	xor	a, a
	ld	(__DELTA+0), a
	ld	(__DELTA+1), a
	ld	(__DELTA+2), a
	ld	(__DELTA+3), a
;src/stage_intro.h:31: _MASTER = 0;
	ld	hl, #__MASTER
	ld	(hl), #0x00
;src/stage_intro.h:32: _FINISH = false;
	ld	hl, #__FINISH
	ld	(hl), #0x00
;src/stage_intro.h:33: _PAUSE = false;
	ld	hl, #__PAUSE
	ld	(hl), #0x00
;src/stage_intro.h:34: mute(-1);
	ld	a, #0xff
	call	_mute
;src/stage_intro.h:35: __asm__("di"); //; Des-Habilitar interrupciones
	di
;src/stage_intro.h:37: VDP_ADDRESS = 0b00100000; // 0x60; // 96
	ld	a, #0x20
	out	(_VDP_ADDRESS), a
;src/stage_intro.h:38: VDP_ADDRESS = 0x81;
	ld	a, #0x81
	out	(_VDP_ADDRESS), a
;src/stage_intro.h:40: PSG = 0x9F;
	ld	a, #0x9f
	out	(_PSG), a
;src/stage_intro.h:42: draw_bg(_intro_pal, _intro_til, (uint16_t)_intro_size, _intro_tilemap);
	ld	hl, #__intro_tilemap
	push	hl
	ld	hl, #0x16a0
	push	hl
	ld	de, #__intro_til
	ld	hl, #__intro_pal
	call	_draw_bg
;src/stage_intro.h:45: VDP_ADDRESS = 0b01100000; // 0x60; // 96
	ld	a, #0x60
	out	(_VDP_ADDRESS), a
;src/stage_intro.h:46: VDP_ADDRESS = 0x81;
	ld	a, #0x81
	out	(_VDP_ADDRESS), a
;src/stage_intro.h:49: playBeep(100, 2);
	ld	l, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x64
	call	_playBeep
;src/stage_intro.h:50: __asm__("ei"); //; Habilitar interrupciones
	ei
;src/stage_intro.h:51: return game_state;
	ld	a, (_game_state+0)
;src/stage_intro.h:52: }
	ret
__intro_pal:
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x1b	; 27
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x13	; 19
	.db #0x3f	; 63
__intro_tilemap:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x13	; 19
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x01	; 1
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x01	; 1
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x01	; 1
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x01	; 1
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x48	; 72	'H'
	.db #0x01	; 1
	.db #0x49	; 73	'I'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
	.db #0x6f	; 111	'o'
	.db #0x70	; 112	'p'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x71	; 113	'q'
	.db #0x72	; 114	'r'
	.db #0x73	; 115	's'
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x78	; 120	'x'
	.db #0x79	; 121	'y'
	.db #0x7a	; 122	'z'
	.db #0x7b	; 123
	.db #0x7c	; 124
	.db #0x7d	; 125
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x85	; 133
	.db #0x86	; 134
	.db #0x87	; 135
	.db #0x88	; 136
	.db #0x89	; 137
	.db #0x8a	; 138
	.db #0x8b	; 139
	.db #0x8c	; 140
	.db #0x8d	; 141
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x90	; 144
	.db #0x91	; 145
	.db #0x92	; 146
	.db #0x93	; 147
	.db #0x94	; 148
	.db #0x95	; 149
	.db #0x96	; 150
	.db #0x97	; 151
	.db #0x98	; 152
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x99	; 153
	.db #0x9a	; 154
	.db #0x9b	; 155
	.db #0x9c	; 156
	.db #0x9d	; 157
	.db #0x9e	; 158
	.db #0x9f	; 159
	.db #0xa0	; 160
	.db #0xa1	; 161
	.db #0xa2	; 162
	.db #0xa3	; 163
	.db #0xa4	; 164
	.db #0xa5	; 165
	.db #0xa6	; 166
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xa7	; 167
	.db #0xa8	; 168
	.db #0xa9	; 169
	.db #0xaa	; 170
	.db #0xab	; 171
	.db #0xac	; 172
	.db #0xad	; 173
	.db #0xae	; 174
	.db #0xaf	; 175
	.db #0xb0	; 176
	.db #0xb1	; 177
	.db #0xb2	; 178
	.db #0xb3	; 179
	.db #0xb4	; 180
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
__intro_til:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xbc	; 188
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xb8	; 184
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x43	; 67	'C'
	.db #0x00	; 0
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xb8	; 184
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0xbe	; 190
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x7d	; 125
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x7b	; 123
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x7b	; 123
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xb7	; 183
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0xda	; 218
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x5b	; 91
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0x73	; 115	's'
	.db #0x00	; 0
	.db #0xad	; 173
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xbc	; 188
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0x8d	; 141
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0xfa	; 250
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x9b	; 155
	.db #0x00	; 0
	.db #0x9c	; 156
	.db #0x00	; 0
	.db #0x7b	; 123
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x9b	; 155
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0xed	; 237
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xb8	; 184
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xb7	; 183
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xf4	; 244
	.db #0x00	; 0
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xd5	; 213
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0x5b	; 91
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xaf	; 175
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x43	; 67	'C'
	.db #0x00	; 0
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x5b	; 91
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xd7	; 215
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xde	; 222
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xd7	; 215
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xd3	; 211
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x9c	; 156
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xb8	; 184
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xde	; 222
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x37	; 55	'7'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0xed	; 237
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0xbe	; 190
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x00	; 0
	.db #0xd7	; 215
	.db #0x00	; 0
	.db #0xce	; 206
	.db #0x00	; 0
	.db #0x3d	; 61
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xde	; 222
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x00	; 0
	.db #0xde	; 222
	.db #0x00	; 0
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x73	; 115	's'
	.db #0x00	; 0
	.db #0xad	; 173
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xb6	; 182
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf6	; 246
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xf6	; 246
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x00	; 0
	.db #0xdd	; 221
	.db #0x00	; 0
	.db #0xee	; 238
	.db #0x00	; 0
	.db #0x5d	; 93
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x6b	; 107	'k'
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xd7	; 215
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xd3	; 211
	.db #0x00	; 0
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xd5	; 213
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x7d	; 125
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xd8	; 216
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xd8	; 216
	.db #0x00	; 0
	.db #0xa7	; 167
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x39	; 57	'9'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf4	; 244
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xaf	; 175
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xb7	; 183
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xb7	; 183
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe9	; 233
	.db #0x00	; 0
	.db #0x16	; 22
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7d	; 125
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xa6	; 166
	.db #0x00	; 0
	.db #0x59	; 89	'Y'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xce	; 206
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf1	; 241
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x89	; 137
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb5	; 181
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8c	; 140
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8c	; 140
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x17	; 23
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x8c	; 140
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x23	; 35
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6e	; 110	'n'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x46	; 70	'F'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xd0	; 208
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xa1	; 161
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xa2	; 162
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc4	; 196
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2b	; 43
	.db #0xc4	; 196
	.db #0xc4	; 196
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x67	; 103	'g'
	.db #0x67	; 103	'g'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x4e	; 78	'N'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x96	; 150
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x4f	; 79	'O'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0xd0	; 208
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xa3	; 163
	.db #0x5c	; 92
	.db #0x5c	; 92
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x72	; 114	'r'
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x16	; 22
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0x9a	; 154
	.db #0x64	; 100	'd'
	.db #0x64	; 100	'd'
	.db #0x00	; 0
	.db #0x29	; 41
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x53	; 83	'S'
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0xc1	; 193
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x61	; 97	'a'
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0xa1	; 161
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa1	; 161
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0xa4	; 164
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0xe4	; 228
	.db #0xe4	; 228
	.db #0x00	; 0
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa5	; 165
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0xa9	; 169
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x46	; 70	'F'
	.db #0x46	; 70	'F'
	.db #0x00	; 0
	.db #0xa4	; 164
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x2f	; 47
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0xd2	; 210
	.db #0x2c	; 44
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x32	; 50	'2'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0xdc	; 220
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x37	; 55	'7'
	.db #0xc8	; 200
	.db #0xc8	; 200
	.db #0x00	; 0
	.db #0xb8	; 184
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0x97	; 151
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x00	; 0
	.db #0x74	; 116	't'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xa7	; 167
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x23	; 35
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x61	; 97	'a'
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0x94	; 148
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x23	; 35
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
;src/stage_intro.h:54: game_state_e draw_intro(uint32_t delta, uint8_t master){
;	---------------------------------
; Function draw_intro
; ---------------------------------
_draw_intro::
;src/stage_intro.h:57: return game_state;
	ld	a, (_game_state+0)
;src/stage_intro.h:58: }
	pop	hl
	inc	sp
	jp	(hl)
;src/stage_intro.h:59: game_state_e update_intro(uint32_t delta, uint8_t master){
;	---------------------------------
; Function update_intro
; ---------------------------------
_update_intro::
;src/stage_intro.h:65: return game_state;
	ld	a, (_game_state+0)
;src/stage_intro.h:66: }
	pop	hl
	inc	sp
	jp	(hl)
;src/stage_intro.h:67: game_state_e update_fast_intro(uint16_t count, uint32_t delta){
;	---------------------------------
; Function update_fast_intro
; ---------------------------------
_update_fast_intro::
;src/stage_intro.h:70: return game_state;
	ld	a, (_game_state+0)
;src/stage_intro.h:71: }
	pop	hl
	pop	bc
	pop	bc
	jp	(hl)
;src/stage_intro.h:73: void load_intro(uint8_t index){
;	---------------------------------
; Function load_intro
; ---------------------------------
_load_intro::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-8
	add	hl, sp
	ld	sp, hl
	ld	e, a
;src/stage_intro.h:74: sStatesF o_sf = {
	ld	-8 (ix), #<(_update_fast_intro)
	ld	-7 (ix), #>(_update_fast_intro)
	ld	-6 (ix), #<(_update_intro)
	ld	-5 (ix), #>(_update_intro)
	ld	-4 (ix), #<(_draw_intro)
	ld	-3 (ix), #>(_draw_intro)
	ld	-2 (ix), #<(_init_intro)
	ld	-1 (ix), #>(_init_intro)
;src/stage_intro.h:80: sFs[index] = o_sf;
	ld	bc, #_sFs+0
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ex	de, hl
	ld	hl, #0
	add	hl, sp
	ld	bc, #0x0008
	ldir
;src/stage_intro.h:81: }
	ld	sp, ix
	pop	ix
	ret
;src/states.h:33: uint8_t loadStatesFunctions(void){
;	---------------------------------
; Function loadStatesFunctions
; ---------------------------------
_loadStatesFunctions::
;src/states.h:36: load_intro(index++);
	xor	a, a
	call	_load_intro
;src/states.h:37: return index;
	ld	a, #0x01
;src/states.h:38: }
	ret
;src/load_commons.h:38: void spritesInit(void){
;	---------------------------------
; Function spritesInit
; ---------------------------------
_spritesInit::
;src/load_commons.h:39: address_til = _VRAM_SPRITE_PATT;
	ld	hl, (__VRAM_SPRITE_PATT)
	ld	(_address_til), hl
;src/load_commons.h:52: }
	ret
;src/load_commons.h:54: void spritesDefine(void){
;	---------------------------------
; Function spritesDefine
; ---------------------------------
_spritesDefine::
;src/load_commons.h:57: }
	ret
;src/load_commons.h:60: void load_commons(void){
;	---------------------------------
; Function load_commons
; ---------------------------------
_load_commons::
;src/load_commons.h:61: next_id = 0;
	ld	hl, #_next_id
	ld	(hl), #0x00
;src/load_commons.h:62: address_til = 0x2000; //__VRAM_SPRITE_PATT__;
	ld	hl, #0x2000
	ld	(_address_til), hl
;src/load_commons.h:63: next_x_address = 0;
	ld	iy, #_next_x_address
	ld	0 (iy), #0x00
;src/load_commons.h:64: next_y_address = 0;
	ld	iy, #_next_y_address
	ld	0 (iy), #0x00
;src/load_commons.h:65: prev_tiles = 0;
	ld	iy, #_prev_tiles
	ld	0 (iy), #0x00
;src/load_commons.h:66: __asm__("di"); //; Des-Habilitar interrupciones
	di
;src/load_commons.h:68: VDP_ADDRESS = 0b00100000; // 0x60; // 96
	ld	a, #0x20
	out	(_VDP_ADDRESS), a
;src/load_commons.h:69: VDP_ADDRESS = 0x81;
	ld	a, #0x81
	out	(_VDP_ADDRESS), a
;src/load_commons.h:72: clear_vram(0);
	xor	a, a
	call	_clear_vram
;src/load_commons.h:76: spritesInit();
	call	_spritesInit
;src/load_commons.h:79: spritesDefine();
	call	_spritesDefine
;src/load_commons.h:82: VDP_ADDRESS = 0b01100000; // 0x60; // 96
	ld	a, #0x60
	out	(_VDP_ADDRESS), a
;src/load_commons.h:83: VDP_ADDRESS = 0x81;
	ld	a, #0x81
	out	(_VDP_ADDRESS), a
;src/load_commons.h:84: _DELTA = 0;
	xor	a, a
	ld	(__DELTA+0), a
	ld	(__DELTA+1), a
	ld	(__DELTA+2), a
	ld	(__DELTA+3), a
;src/load_commons.h:85: _MASTER = 0;
	ld	iy, #__MASTER
	ld	0 (iy), #0x00
;src/load_commons.h:88: __asm__("ei"); //; Habilitar interrupciones
	ei
;src/load_commons.h:89: }
	ret
;src/hello-world.c:44: void init(void){
;	---------------------------------
; Function init
; ---------------------------------
_init::
;src/hello-world.c:45: count = 0;
	ld	hl, #0x0000
	ld	(_count), hl
;src/hello-world.c:46: load_commons();
	call	_load_commons
;src/hello-world.c:47: game_state = sFs[game_state].init();
	ld	a, (_game_state+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_sFs
	add	hl, de
	ld	de, #0x0006
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ex	de, hl
	call	___sdcc_call_hl
	ld	(_game_state+0), a
;src/hello-world.c:48: }
	ret
;src/hello-world.c:53: void draw(uint32_t delta, uint8_t master)
;	---------------------------------
; Function draw
; ---------------------------------
_draw::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	inc	sp
	inc	sp
	push	de
	ld	-2 (ix), l
	ld	-1 (ix), h
;src/hello-world.c:58: game_state = sFs[game_state].draw(delta, master);
	ld	a, (_game_state+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_sFs
	add	hl, de
	ld	de, #0x0004
	add	hl, de
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, 4 (ix)
	push	af
	inc	sp
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	pop	iy
	call	___sdcc_call_iy
	ld	(_game_state+0), a
;src/hello-world.c:59: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;src/hello-world.c:64: void update(uint32_t delta, uint8_t master){
;	---------------------------------
; Function update
; ---------------------------------
_update::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	inc	sp
	inc	sp
	push	de
	ld	-2 (ix), l
	ld	-1 (ix), h
;src/hello-world.c:67: game_state = sFs[game_state].update(delta, master);
	ld	a, (_game_state+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_sFs
	add	hl, de
	inc	hl
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, 4 (ix)
	push	af
	inc	sp
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	pop	iy
	call	___sdcc_call_iy
	ld	(_game_state+0), a
;src/hello-world.c:68: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;src/hello-world.c:73: void update_fast(void){
;	---------------------------------
; Function update_fast
; ---------------------------------
_update_fast::
;src/hello-world.c:74: count++;
	ld	hl, (_count)
	inc	hl
;src/hello-world.c:77: if ((count & 0b111101011) && 
	ld	(_count), hl
	ld	a, l
	and	a, #0xeb
	jr	NZ, 00124$
	bit	0, h
	jr	Z, 00102$
00124$:
;src/hello-world.c:78: (((isPress(B1) && isPress(B2))) || 
	ld	a, #0x10
	call	_isPress
	or	a, a
	jr	Z, 00105$
	ld	a, #0x20
	call	_isPress
	or	a, a
	jr	NZ, 00101$
00105$:
;src/hello-world.c:79: ((isPress(B12) && isPress(B22))))
	ld	a, #0x84
	call	_isPress
	or	a, a
	jr	Z, 00102$
	ld	a, #0x88
	call	_isPress
	or	a, a
	jr	Z, 00102$
00101$:
;src/hello-world.c:81: _PAUSE = !_PAUSE;
	ld	a, (__PAUSE+0)
	xor	a, #0x01
	ld	(__PAUSE+0), a
;src/hello-world.c:82: count = 0;
	ld	hl, #0x0000
	ld	(_count), hl
00102$:
;src/hello-world.c:84: _DELTA++;
	ld	iy, #__DELTA
	inc	0 (iy)
	jr	NZ, 00125$
	inc	1 (iy)
	jr	NZ, 00125$
	inc	2 (iy)
	jr	NZ, 00125$
	inc	3 (iy)
00125$:
;src/hello-world.c:86: game_state = sFs[game_state].update_fast(count, _DELTA);
	ld	a, (_game_state+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_sFs
	add	hl, de
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, (__DELTA + 2)
	push	hl
	ld	hl, (__DELTA)
	push	hl
	ld	hl, (_count)
	push	bc
	pop	iy
	call	___sdcc_call_iy
	ld	(_game_state+0), a
;src/hello-world.c:87: }
	ret
;src/hello-world.c:92: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/hello-world.c:93: game_state = game_intro;
	ld	hl, #_game_state
	ld	(hl), #0x00
;src/hello-world.c:94: loadStatesFunctions();
	call	_loadStatesFunctions
;src/hello-world.c:95: mute(-1);
	ld	a, #0xff
	call	_mute
;src/hello-world.c:96: while(1){
00102$:
;src/hello-world.c:97: init();
	call	_init
;src/hello-world.c:99: loop();// si sale del loop esque ha cambiado de pantalla
	call	_loop
;src/hello-world.c:101: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
__xinit__point1:
	.db #0x00	; 0
__xinit__point2:
	.db #0x00	; 0
__xinit__lastPoint:
	.db #0x00	; 0
__xinit__win1:
	.db #0x00	;  0
__xinit__win2:
	.db #0x00	;  0
__xinit__lives1:
	.db #0x03	; 3
__xinit__lives2:
	.db #0x03	; 3
__xinit__vdp_status:
	.db #0x00	; 0
__xinit__debounce_count:
	.db #0x00	; 0
__xinit__vblank_ocurrido:
	.db #0x00	; 0
__xinit__next_id:
	.db #0x00	; 0
__xinit__address_til:
	.dw #0x2000
__xinit__next_x_address:
	.db #0x00	; 0
__xinit__next_y_address:
	.db #0x00	; 0
__xinit__prev_tiles:
	.db #0x00	; 0
__xinit___FINISH:
	.db #0x00	;  0
__xinit___PAUSE:
	.db #0x00	;  0
__xinit___DELTA:
	.byte #0x00, #0x00, #0x00, #0x00	; 0
__xinit___MASTER:
	.db #0x00	; 0
__xinit__game_state:
	.db #0x00	; 0
__xinit__last_state:
	.db #0x00	; 0
__xinit__count:
	.dw #0x0000
	.area _CABS (ABS)
