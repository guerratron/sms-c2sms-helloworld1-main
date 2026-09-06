/**
 * @file load_commons.h
 * @brief Archivo para cargar y preparar los recursos a utilizar.
 * @details Se encarga de cargar y definir assets comunes para todas las "screen"; sonidos y objetos gráficos como Sprites, Images, logos, fondos, ... Necesita "spritesManager.h" y los recursos importados con "ires.h"
 * @author GuerraTron26
 * @date 2026
 * @version 1.0
 */

#ifndef __STAGE_COMMONS_H__
#define __STAGE_COMMONS_H__

#include <basic.h>
#include <defines.h>
#include <spritesManager.h>
#include "const.h"
#include "ires.h"

extern bool _FINISH;
extern bool _PAUSE;
extern game_state_e game_state;

extern uint8_t next_id;
extern uint16_t address_til; //__VRAM_SPRITE_PATT__;
extern uint8_t next_x_address;
extern uint8_t next_y_address;
extern uint8_t prev_tiles;


/** Inicializa los datos de algunos sprites */
void spritesInit(void);
/** Define los datos de algunos sprites */
void spritesDefine(void);
/** carga gráficos comunes (sprites, images, anis, ..) */
void load_commons(void);

/** Inicializa los datos de algunos sprites */
void spritesInit(void){
    address_til = _VRAM_SPRITE_PATT;
    /*
    // BALL1 // ID = 0, xAddr = 0, yAddr = 0, addess_til = 0x2000, prev_tiles = 0
    moveDef(&oMiniheartMove, 1, 1, (_SCREEN_WIDTH + 1 - (8 * 1)), 1, 0, (_SCREEN_HEIGHT - (8 * 1)));
    // load_sprite(_miniheart_pal, _miniheart_til, (uint16_t)_miniheart_size);
    _miniheartDef(&sMiniheart, next_id++, next_x_address, next_y_address, prev_tiles, 40, 40, &oMiniheartMove, NULL);
    load_sprite(&sMiniheart, address_til);
    next_x_address += (1 * 2); // 0 + 2 (1 tile, 2 = x + index)
    next_y_address += 1;       // 0 + 1 (1 tile, 1 = y)
    // se comenta porque el siguiente sprite utiliza el mismo tileset
    address_til += sMiniheart.size; // 0x2000 + 96 (3 * 32) = 8288
    prev_tiles += sMiniheart.nTiles;
    */
}

void spritesDefine(void){
    /*// BALL
    toAniDefine(&sMiniheart, -1, -1, -1, 0); */
}

/** carga gráficos comunes de todas las pantallas (sprites, images, anis, ..) */
void load_commons(void){
    next_id = 0;
    address_til = 0x2000; //__VRAM_SPRITE_PATT__;
    next_x_address = 0;
    next_y_address = 0;
    prev_tiles = 0;
    __asm__("di"); //; Des-Habilitar interrupciones
    // unable display (0x8160)
    VDP_ADDRESS = 0b00100000; // 0x60; // 96
    VDP_ADDRESS = 0x81;
    // remove backgrounds
    // remove_bg();
    clear_vram(0);
    // draw background image
    //draw_bg(_mo_pal, _mo_til, (uint16_t)_mo_size, _mo_tilemap);
    // draw sprite
    spritesInit();
    // Envía datos directamente a la VRAM
    // write_to_vram(_VRAM_SPRITE_PATT, _guerraTron_til);
    spritesDefine();

    // enable display (0x8160)
    VDP_ADDRESS = 0b01100000; // 0x60; // 96
    VDP_ADDRESS = 0x81;
    _DELTA = 0;
    _MASTER = 0;
    // load music
    //load_music(ARKANOID_TITLE_SCREEN_VGM);
    __asm__("ei"); //; Habilitar interrupciones
}

#endif // __STAGE_COMMONS_H__