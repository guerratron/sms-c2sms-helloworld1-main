#ifndef __STAGE_PLAY_H__
#define __STAGE_PLAY_H__

#include <stdlib.h> // Necesario para abs()
#include <stdbool.h> // Necesario para boolean
#include <basic.h>
#include <defines.h>
#include <simpleSounds.h>
#include <spritesManager.h>
#include "const.h"
#include "states.h"

#include "vramTask.h"

extern enum eSPR _SPR;

// GRAPHICS

extern sGraphic sBall;
extern sGraphic sMark1;
extern sGraphic sMark2;
extern sGraphic sPad1;
extern sGraphic sPad2;
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

extern unsigned char spr_tiles_count;

// LOCALES
int8_t margen1 = -1;
int8_t margen2 = -1;
int8_t margen_ball = -1;
int8_t last_margen_ball = -1;
int8_t dir = 0; // nos sirve para evitar rebotar desde detrás de la paleta
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
    lives2 = 3;

    spr_tiles_count = 0;

    margen1 = -1;
    margen2 = -1;
    margen_ball = -1;
    last_margen_ball = -1;
    dir = 0;

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
    
    // Habilitar el dibujado de los sprites (si se comentan no se dibujarán las raquetas hasta que no las mueva el player)
    sBall.dirty = true;
    sLogo.dirty = true;
    sPad1.dirty = true;
    sPad2.dirty = true;
    sMark1.dirty = true;
    sMark2.dirty = true;
/*
    spriteDefine(&sBall, -1, -1, -1);
    spriteMultiDefine(&sPad1, -1, -1, -1);
    spriteMultiDefine(&sPad2, -1, -1, -1);
    spriteDefine(&sMark1, -1, -1, -1);
    spriteDefine(&sMark2, -1, -1, -1);
    spriteMultiDefine(&sLogo, -1, -1, -1);
*/
    //__asm__("ei"); //; Habilitar interrupciones
    return game_state;
}

/** retorna 1 o -1 pseudo-aleatoriamente (en función del tiempo pasado) */
int8_t plusMinus(uint32_t delta){
    int8_t result = delta & 0b01;
    result = result == 0 ? -1 : result;
    return result;
}

void toMark(uint8_t numPlayer){
    numPlayer;
    /*memcpy(_mo_tilemap_clon, _mo_tilemap, _mo_tilemap_size);
    _mo_tilemap_clon[numPlayer * 10] = 0x03;
    draw_bg(_mo_pal, _mo_til, (uint16_t)_mo_size, _mo_tilemap_clon);*/
    sMark1.i = (lives1 > 0) ? lives1 - 1 : 0;
    sMark2.i = (lives2 > 0) ? lives2 - 1 : 0;
    sMark1.dirty = true;
    sMark2.dirty = true;
}

game_state_e draw_play(uint32_t delta, uint8_t master){
    // para evitar "parámetros sin usar": warning 85: in function draw unreferenced function argument : 'delta'
    delta;
    master;
    /*if (_SPR == MINIHEART){
        // load_sprite(_miniheart_pal, _miniheart_til, (uint16_t)_miniheart_size);
    }
    if (_SPR == GUERRATRON){
        // load_sprite(_guerraTron_pal, _guerraTron_til, (uint16_t)_guerraTron_size);
        // dibujar_sprite(0, sprite_y + 1, sprite_x + 1, tile_index);
    }*/

    // toTilesgifyUpdate(0, sprite_tilesWidth, sprite_tilesHeight, sprite_x, sprite_y);
    // if(master % 25 == 0){ //25 en 50Hz o 30 en 60Hz
    // if(master > 25){ //25 en 50Hz o 30 en 60Hz
    // toAniIndex(0, ani_arr, ani_index);
    // toAniIndex(&sBall, -1);
    // if(_pals == 0){ toAniIndex(&sBall, -1); }

    toAniIndexPos(&sMark1, -1, -1, -1);

    toAniIndexPos(&sMark2, -1, -1, -1);
    // master = 0;
    //}
    // toAniIndex(&sPad1, -1);
    // toAniIndex(&sPad2, -1);
    // if(_pals == 1){ toAniIndex(&sBall2, -1); }
    // if (isPress(0, _RIGHT_)){
    toAniPos(&sBall, -1, -1);
    //}
    // if(_pals == 0){ toAniPos(&sBall, -1, -1); }
    // toAniPos(&sPad1, -1, -1);
    toTilesgifyDefineUpdate(&sPad1, -1, -1, -1, 0);
    // toAniPos(&sPad2, -1, -1);
    toTilesgifyDefineUpdate(&sPad2, -1, -1, -1, 0);

    // LOGO
    toTilesgifyDefineUpdate(&sLogo, -1, -1, -1, 1);
    // if(_pals == 2){ toTilesgifyDefineUpdate(&sLogo, -1, -1, -1); }
    //if (master % 25 == 0){ // 25 en 50Hz o 30 en 60Hz
        // play_sound();
        //__asm__("call play_sound1");
        //__asm__("jp play_sound1");
        // play_sound1();
    //}
    /*
    sprite_SATVDP_Update();
    sLogo.dirty = false;
    */

    return game_state;
}

void toStageFinish(void){
    delay(100);
    playBeep(50, 2);
    // 4. Silenciar el Canal 0 // 1001 VVVV -> 1001 1111 (Volumen 15 = Silencio)
    PSG = 0x9F;
    // Inhabilitar el dibujado de los sprites (evita que se dibujen en la siguiente pantalla)
    sBall.dirty = false;
    sLogo.dirty = false;
    sPad1.dirty = false;
    sPad2.dirty = false;
    sMark1.dirty = false;
    sMark2.dirty = false;
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
    if (++sBall.i >= sBall.ani_size){
        sBall.i = 0;
    }

    // toAniPos(&sBall, -1, -1);
    margen_ball = moveWith(&sBall, true); //, &oBallMove);
    if (margen_ball == 0){
        playBeep(75, 1);
        point1++;
        lives2--;
        // Marcador
        toMark(1);
        dir = 1;
        if (lives2 == 0){
            // STAGE WINNER 1
            win1 = true;
            _FINISH = true;
        }
    }else if (margen_ball == 1){
        playBeep(75, 1);
        point2++;
        lives1--;
        // Marcador
        toMark(2);
        dir = 0;
        if (lives1 == 0){
            // STAGE WINNER 1
            win2 = true;
            _FINISH = true;
        }
    }
    //if (master % 25 == 0){ // 25 en 50Hz o 30 en 60Hz
    //if (sMark1.oM->xCount > 50){
    if(sMark1.dirty){
        moveWith(&sMark1, true);
        moveWith(&sMark2, true);
        //sMark1.dirty = true;
        //sMark2.dirty = true;
        sMark1.oM->xCount = 0;
    }

    if (isPress(U)){
        if (margen1 != 3){
            sPad1.oM->yIncr = -2 * jump_steeps;
            sPad1.dirty = true;
        }
        margen1 = moveWith(&sPad1, false);
    }
    if (isPress(D)){
        if (margen1 != 2){
            sPad1.oM->yIncr = 2 * jump_steeps;
            sPad1.dirty = true;
        }
        margen1 = moveWith(&sPad1, false);
    }
    if (isPress(U2)){
        if (margen2 != 3){
            sPad2.oM->yIncr = -2 * jump_steeps2;
            sPad2.dirty = true;
        }
        margen2 = moveWith(&sPad2, false);
    }
    if (isPress(D2)){
        if (margen2 != 2){
            sPad2.oM->yIncr = 2 * jump_steeps2;
            sPad2.dirty = true;
        }
        margen2 = moveWith(&sPad2, false);
    }
    
    // LOGO
    moveWith(&sLogo, 1); //, &oBallMove);
    // SALTO DEL LOGO
    if (isPress(B1) && isPress(B12)){ trigger_jumpV(&sLogo); }
    update_jumpV(&sLogo);

    //ACELERADOR 1
    if(jump_steeps > 1){ jump_steeps = jump_steeps >> 1; } // ../=2
    if (isPress(B1) && (jump_steeps == 1)){ jump_steeps = 4; }
    // ACELERADOR 2
    if(jump_steeps2 > 1){ jump_steeps2 = jump_steeps2 >> 1; } // ../=2
    if (isPress(B12) && (jump_steeps2 == 1)){ jump_steeps2 = 4; }

    if (isColission(&sBall, &sPad1)){
        if(dir == 1){
            playEffectSound(25, 0x10, 3, 1);
            sBall.oM->xIncr *= -1;
            // puntos 1
            point1++;
            lastPoint = 1;
            dir = 0;
        }
    }else if (isColission(&sBall, &sPad2)){
        if(dir == 0){
            playEffectSound(25, 0x10, 3, 1);
            sBall.oM->xIncr *= -1;
            // puntos 2
            point2++;
            lastPoint = 2;
            dir = 1;
        }
    }else if (isColission(&sBall, &sLogo)){
        playEffectSound(5, 0x19, 3, 1);
        // sBall.oM->xIncr *= -1;
        sBall.oM->yIncr *= plusMinus(delta); //-1;
        // puntos 2
        point1 -= lastPoint == 1 ? 1 : 0;
        point2 -= lastPoint == 2 ? 1 : 0;
        lastPoint = 0;
    }
    last_margen_ball = margen_ball;

    // update music
    vgm_tick(&vgm);

    return game_state;
}

game_state_e update_fast_play(uint16_t count, uint32_t delta){
    count;
    delta;
    // CONTADOR INTERNO DE LOS MARKADORES
    sMark1.oM->xCount++;
    sMark1.oM->yCount++;
    sMark2.oM->xCount++;
    if (sMark1.oM->xCount > 25){
    //if(sMark1.oM->xCount >= 65535){
        sMark1.oM->xCount = 0;
        sMark1.oM->yCount = 0;
        sMark2.oM->xCount = 0;
        sMark1.dirty = true;
        sMark2.dirty = true;
    }
    // CONTADOR INTERNO PARA SALTOS
    sPad1.oM->xCount++;
    sPad1.oM->yCount++;
    if (sPad1.oM->xCount >= 65535){
        sPad1.oM->xCount = 0;
        sPad1.oM->yCount = 0;
    }
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