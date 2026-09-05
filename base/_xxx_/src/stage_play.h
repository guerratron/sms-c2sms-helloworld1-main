/**
 * @file stage_play.h
 * @brief Archivo para implementar todas las funciones de esta pantalla.
 * @details Este archivo variará en función de la app. Realiza la inicialización e implementa el dibujado y actualización de sprites y sonido, así como el control y la lógica que se necesite. 
 * @author GuerraTron26
 * @date 2026
 * @version 1.0
 */

#ifndef __STAGE_PLAY_H__
#define __STAGE_PLAY_H__

#include <stdlib.h> // Necesario para abs()
#include <basic.h>
#include <defines.h>
#include <simpleSounds.h>
#include <spritesManager.h>
#include "const.h"
#include "states.h"

// GRAPHICS

extern sGraphic sMiniheart;
extern sGraphic sLogo;

extern bool _FINISH;
extern bool _PAUSE;
extern uint8_t point1;
extern uint8_t point2;
extern uint8_t lastPoint;
extern bool win1;
extern bool win2;
extern uint8_t lives1;
extern uint8_t lives2;
extern uint16_t count;

// LOCALES
uint8_t jump_steeps = 1;
uint8_t jump_steeps2 = 1;

// #include "stage_menu.h"

game_state_e init_play(void){
    game_state = game_play;
    last_state = game_state;
    count = 0;
    _DELTA = 0;
    _MASTER = 0;
    _FINISH = false;
    //_PAUSE = false;
    point1 = 0;
    point2 = 0;
    lastPoint = 0;
    win1 = false;
    win2 = false;
    lives1 = 3;
    lives2 = 100;

    jump_steeps = 1;
    jump_steeps2 = 1;

    mute(-1);
    //__asm__("di"); //; Des-Habilitar interrupciones
    // draw background image
    //draw_bg(_mo_pal, _mo_til, (uint16_t)_mo_size, _mo_tilemap);

    // enable display (0x8160)
    //VDP_ADDRESS = 0b01100000; // 0x60; // 96
    //VDP_ADDRESS = 0x81;
    // load music
    load_music(ARKANOID_TITLE_SCREEN_VGM);
    
    // Habilitar el dibujado de los sprites (si se comentan no se dibujarán hasta que no se cambien: movimiento, animación, ..)
    sMiniheart.dirty = true;
    sLogo.dirty = true;
    
    //__asm__("ei"); //; Habilitar interrupciones
    return game_state;
}

/** retorna 1 o -1 pseudo-aleatoriamente (en función del tiempo pasado) */
int8_t plusMinus(uint32_t delta){
    int8_t result = delta & 0b01;
    result = result == 0 ? -1 : result;
    return result;
}

game_state_e draw_play(uint32_t delta, uint8_t master){
    // para evitar "parámetros sin usar": warning 85: in function draw unreferenced function argument : 'delta'
    delta;
    master;
    // if (isPress(0, _RIGHT_)){
    toAniPos(&sMiniheart, -1, -1);
    //}
    // LOGO
    toTilesgifyDefineUpdate(&sLogo, -1, -1, -1, 1);
    // if(_pals == 2){ toTilesgifyDefineUpdate(&sLogo, -1, -1, -1); }
    //if (master % 25 == 0){ // 25 en 50Hz o 30 en 60Hz
        // play_sound();
        //__asm__("call play_sound1");
        //__asm__("jp play_sound1");
        // play_sound1();
    //}
    return game_state;
}

/** Realiza algunas acciones comunes al abandonar la pantalla (emite un beep, silencia canales, marca objetos gráficos 
  * como no dibujables en pantallas sucesivas, ..) */
void toStageFinish(void);
void toStageFinish(void){
    delay(100);
    playBeep(50, 2);
    // 4. Silenciar el Canal 0 // 1001 VVVV -> 1001 1111 (Volumen 15 = Silencio)
    PSG = 0x9F;
    // Inhabilitar el dibujado de los sprites (evita que se dibujen en la siguiente pantalla)
    sMiniheart.dirty = false;
    sLogo.dirty = false;
}

game_state_e update_play(uint32_t delta, uint8_t master){
    delta;
    master;
    if (_FINISH){
        toStageFinish();
        //_toMenu1();
        return game_over;//game_over;
    }
    _FINISH = false;
    //_PAUSE = false;
    win1 = false;
    win2 = false;
    if (++sMiniheart.i >= sMiniheart.ani_size){
        sMiniheart.i = 0;
    }
    moveWith(&sMiniheart, true);

    // LOGO
    moveWith(&sLogo, true); //, &oBallMove);
    // SALTO DEL LOGO
    if (isPress(B1) && isPress(B12)){ trigger_jumpV(&sLogo, _guerraTron_jump_velocity); }
    update_jumpV(&sLogo);

    //ACELERADOR 1
    if(jump_steeps > 1){ jump_steeps = jump_steeps >> 1; } // ../=2
    if (isPress(B1) && (jump_steeps == 1)){ jump_steeps = 4; }
    // ACELERADOR 2
    if(jump_steeps2 > 1){ jump_steeps2 = jump_steeps2 >> 1; } // ../=2
    if (isPress(B12) && (jump_steeps2 == 1)){ jump_steeps2 = 4; }

    if (isColission(&sMiniheart, &sLogo)){
        playEffectSound(5, 0x19, 3, 1);
        // sMiniheart.oM->xIncr *= -1;
        sMiniheart.oM->yIncr *= plusMinus(delta); //-1;
        // puntos 2
        point1 -= lastPoint == 1 ? 1 : 0;
        point2 -= lastPoint == 2 ? 1 : 0;
        lastPoint = 0;
        if (plusMinus(delta) == -1){ lives2--; }
    }

    if (lives2 == 0){
        // STAGE WINNER 1
        win1 = true;
        _FINISH = true;
    }

    // update music
    vgm_tick(&vgm);

    return game_state;
}

game_state_e update_fast_play(uint16_t count, uint32_t delta){
    count;
    delta;
    return game_state;
}

void load_play(uint8_t index){
    sStatesF o_sf = {
        update_fast_play,
        update_play,
        draw_play,
        init_play
    };
    sFs[index] = o_sf;
}

#endif // __STAGE_PLAY_H__