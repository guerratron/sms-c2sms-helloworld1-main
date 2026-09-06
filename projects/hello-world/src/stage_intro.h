/**
 * @file stage_intro.h
 * @brief Archivo para implementar todas las funciones de esta pantalla.
 * @details Este archivo variará en función de la app. Realiza la inicialización e implementa el dibujado y actualización de sprites y sonido, así como el control y la lógica que se necesite. 
 * @author GuerraTron26
 * @date 2026
 * @version 1.0
 */

#ifndef __STAGE_INTRO_H__
#define __STAGE_INTRO_H__

#include <basic.h>
#include <defines.h>
#include <simpleSounds.h>
#include <spritesManager.h>
#include "const.h"
#include "states.h"
#include "ires.h"

extern bool _FINISH;
extern bool _PAUSE;
extern game_state_e game_state;
extern uint16_t count;

game_state_e init_intro(void){
    game_state = game_intro;
    last_state = game_state;
    count = 0;
    _DELTA = 0;
    _MASTER = 0;
    _FINISH = false;
    _PAUSE = false;
    mute(-1);
    __asm__("di"); //; Des-Habilitar interrupciones
        // unable display (0x8160)
        VDP_ADDRESS = 0b00100000; // 0x60; // 96
        VDP_ADDRESS = 0x81;
        // 4. Silenciar el Canal 0 // 1001 VVVV -> 1001 1111 (Volumen 15 = Silencio)
        PSG = 0x9F;
        // draw background image
        draw_bg(_intro_pal, _intro_til, (uint16_t)_intro_size, _intro_tilemap);

        // enable display (0x8160)
        VDP_ADDRESS = 0b01100000; // 0x60; // 96
        VDP_ADDRESS = 0x81;
        // load music
        //load_music(ARKANOID_TITLE_SCREEN_VGM);
        playBeep(100, 2);
    __asm__("ei"); //; Habilitar interrupciones
    return game_state;
}

game_state_e draw_intro(uint32_t delta, uint8_t master){
    delta;
    master;
    return game_state;
}
game_state_e update_intro(uint32_t delta, uint8_t master){
    delta;
    master;
    //if (isPress(B1) || isPress(B12)){
        //game_state = game_play; // next stage
    //}
    return game_state;
}
game_state_e update_fast_intro(uint16_t count, uint32_t delta){
    count;
    delta;
    return game_state;
}

void load_intro(uint8_t index){
    sStatesF o_sf = {
        update_fast_intro,
        update_intro,
        draw_intro,
        init_intro
    };
    sFs[index] = o_sf;
}

#endif // __STAGE_INTRO_H__