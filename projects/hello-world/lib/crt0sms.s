;---------------------------------------------------------------------------------
; ***** this is a modified version aimed to C2SMS homebrew - guerraTron\2026 *****
;---------------------------------------------------------------------------------
    .module crt0sms
    .globl _main
    .globl _vblankISR
    .globl _nmISR
    .area _HEADER (ABS)

    .org 0x0000     ;INICIO (RESET)
    di
    im 1                            ; SMS runs in z80 interrupt mode 1
    jp init
;---------------
    .org 0x0038     ;VECTOR INTERRUPCIONES ENMASCARABLE
    jp _vblankISR
;---------------
    .org 0x0066     ;VECTOR INTERRUPCIONES NO ENMASCARABLE (BOTON PAUSE)
    jp _nmISR
;---------------
; con los siguientes comandos el VDP queda correctamente inicializado
init_vdp_data:
    .db #0x04, #0x80, #0x00, #0x81, #0xff, #0x82, #0xff, #0x85, #0xff, #0x86, #0xff, #0x87, #0x00, #0x88, #0x00, #0x89, #0xff, #0x8a
init_vdp_data_end:
;---------------

;---------------
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
;---------------
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
;---------------
inf_loop:
    jp inf_loop
    
;--------------------------------------------------------------------------
        ; here is a block of 128 OUTI instructions, made for enabling
        ; UNSAFE but FAST short data transfers to VRAM
;--------------------------------------------------------------------------
_OUTI128::                              ; _OUTI128 label points to a block of 128 OUTI and a RET
        .rept 32
        outi
        .endm
_OUTI96::                               ; _OUTI96 label points to a block of 96 OUTI and a RET
        .rept 32
        outi
        .endm
_OUTI64::                               ; _OUTI64 label points to a block of 64 OUTI and a RET
        .rept 32
        outi
        .endm
_OUTI32::                               ; _OUTI32 label points to a block of 32 OUTI and a RET
        .rept 32
        outi
        .endm
_outi_block::                           ; _outi_block label points to END of OUTI block
        ret

    ; ordering of segments for the linker.
    .area   _HOME
    .area   _CODE
    .area   _INITIALIZER
    .area   _GSINIT
    .area   _GSFINAL

    .area   _CODE
    .area   _GSINIT
;---------------
gsinit::
    ;ld bc, #l__INITIALIZER   ; BC = Tamaño en bytes de los datos inicializados
    ld a, b
    or a, c
    jr Z, gsinit_next   ; Si el tamaño es 0, salta el proceso
    ;ld de, #s__INITIALIZED   ; DE = Dirección de destino en la RAM (s__ de 'start')
    ;ld hl, #s__INITIALIZER   ; HL = Dirección de origen en la ROM
    ldir                     ; Copia en bloque: copia BC bytes desde HL hacia DE
gsinit_next:
    .area   _GSFINAL
    ret

    .area   _DATA
    .area   _INITIALIZED
    .area   _BSEG
    .area   _BSS
    .area   _HEAP

    .area _TAIL (ABS)

;---------------
    .org 0x7FF0     ;INFO CARTUCHO (16 BYTES): TIPO ROM, SIZE, FIRMA ASCII

    .ascii "TMR SEGA"         ; cartridge "header" (https://www.smspower.org/Development/ROMHeader) ; Firma obligatoria para saltarse la BIOS de la consola
    .db #0x00, #0x00          ; reserved ; Espacio reservado (generalmente ceros)
    ;----------------
    ;.db #0x00, #0x00          ; checksum
    ;checksum_pos:
    .dw 0x0000            ; <--- TU SCRIPT SOBREESCRIBIRÁ ESTO MÁS TARDE; ESPACIO PARA EL CHECKSUM (Se inicializa en 0) Se rellena con herramienta externa
    ;----------------
    ; Código de producto (3 bytes en formato BCD) + Versión (1 byte)
    .db #0x55, #0x44, #0x00   ; Ejemplo de ID de juego
    ;.db #0x26, #0x70, #0xA0   ; product code 107026, version 0
    ; Región del juego y tamaño máximo de la ROM:
    ; 0x4C = Export/SMS (Europa/América, 32KB)
    ; 0x4F = Export/SMS (Europa/América, 128KB)
    ; 0x3F = Japón/SMS (128KB)
    .db #0x4C                 ; SMS export, rom size = 32 Kb
;---------------        

