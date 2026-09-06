    .module crt0sms
    .globl _main
    .globl _vblankISR
    .globl _nmISR
    .area _HEADER (ABS)

    .org 0x0000     ;INICIO (RESET)

    di
    im 1                            ; SMS runs in z80 interrupt mode 1
    jp init

    .org 0x0038     ;VECTOR INTERRUPCIONES ENMASCARABLE

    jp _vblankISR

    .org 0x0066     ;VECTOR INTERRUPCIONES NO ENMASCARABLE (BOTON PAUSE)

    jp _nmISR

; con los siguientes comandos el VDP queda correctamente inicializado
init_vdp_data:
    .db #0x04, #0x80, #0x00, #0x81, #0xff, #0x82, #0xff, #0x85, #0xff, #0x86, #0xff, #0x87, #0x00, #0x88, #0x00, #0x89, #0xff, #0x8a
init_vdp_data_end:

init:
    ; init stack pointer
    ld sp, #0xDFF0                  ; at end of onboard RAM (DESDE 0xC000 HASTA 0xDFF0)
    ; init memory mapper
    ld hl,#0x0008                   ; first page of cartridge RAM (NO-VOLATIL) at 0x8000 (PARTIDAS GUARDADAS)
    ld (#0xfffc),hl                 ; [0xfffc] = 0x08, [0xfffd] = 0x00
    ld hl,#0x0201
    ld (#0xfffe),hl                 ; [0xfffe] = 0x01, [0xffff] = 0x02
    ; init vdp
    ld hl, #init_vdp_data
    ld b, #init_vdp_data_end - #init_vdp_data
    ld c, #0xbf
    otir
    ; clear vram
    ld a, #0x00
    out (#0xbf), a
    ld a, #0x40
    out (#0xbf), a
    ld bc, #0x4000    ; 16384 bytes of vram
clear_vram_loop:
    ld a, #0x00
    out (#0xbe), a
    dec bc
    ld a, b
    or c
    jp nz, clear_vram_loop
    ; init global variables
    call gsinit
    ; main function
    ei
    call _main
inf_loop:
    jp inf_loop

    ; ordering of segments for the linker.
    .area   _HOME
    .area   _CODE
    .area   _INITIALIZER
    .area   _GSINIT
    .area   _GSFINAL

    .area   _CODE
    .area   _GSINIT
gsinit::
    .area   _GSFINAL
    ret

    .area   _DATA
    .area   _INITIALIZED
    .area   _BSEG
    .area   _BSS
    .area   _HEAP

    .area _TAIL (ABS)

    .org 0x7FF0     ;INFO CARTUCHO (16 BYTES): TIPO ROM, SIZE, FIRMA ASCII

    .ascii "TMR SEGA"         ; cartridge "header" (https://www.smspower.org/Development/ROMHeader)
    .db #0x00, #0x00          ; reserved
    .db #0x00, #0x00          ; checksum
    .db #0x26, #0x70, #0xA0   ; product code 107026, version 0
    .db #0x4C                 ; SMS export, rom size = 32 Kb
