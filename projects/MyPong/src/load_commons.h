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

extern sGraphic sBall;
extern oMove oBallMove;
extern sGraphic sMark1;
extern oMove oMark1Move;
extern sGraphic sMark2;
extern oMove oMark2Move;
extern sGraphic sPad1;
extern oMove oPad1Move;
extern sGraphic sPad2;
extern oMove oPad2Move;
extern sGraphic sLogo;
extern oMove oLogo;
extern sJumpV oLogoJumpV;

extern uint8_t next_id;
extern uint16_t address_til; //__VRAM_SPRITE_PATT__;
extern uint8_t next_x_address;
extern uint8_t next_y_address;
extern uint8_t prev_tiles;

extern uint8_t lives1;
extern uint8_t lives2;

/** Inicializa los datos de algunos sprites */
void spritesInit(void);
/** Define los datos de algunos sprites */
void spritesDefine(void);
/** carga gráficos comunes (sprites, images, anis, ..) */
void load_commons(void);

/** Se encarga de definir todos los objetos gráficos existentes en el array 'Gs' y de cargar sus tiles.  
 * Antes de este se deben definir su función de definiciones (obligatorio) y 
 * los subObjetos (si existen) 'oM' para el movimiento y 'sJ' para el salto. */
void sprLoad(sGraphic* Gs[], uint8_t len);
void sprLoad(sGraphic* Gs[], uint8_t len){
    address_til = _VRAM_SPRITE_PATT;
    uint8_t i = 0;
    uint8_t x = 0;
    uint8_t y = 0;
    for(i = 0; i < len; i++){
        if(Gs[i]->oM){
           x = Gs[i]->oM->xMin + ((Gs[i]->oM->xMax - Gs[i]->oM->xMin) / 2);
            y = Gs[i]->oM->yMin + ((Gs[i]->oM->yMax - Gs[i]->oM->yMin) / 2);
        }
        Gs[i]->_def(Gs[i], next_id++, next_x_address, next_y_address, prev_tiles, x, y, Gs[i]->oM, Gs[i]->sJ);
        load_sprite(Gs[i], address_til);
        // incrementamos para el siguiente sprite
        next_x_address += (Gs[i]->w * 2); // 0 + 2 (1 tile, 2 = x + index)
        next_y_address += Gs[i]->w;             // 0 + 1 (1 tile, 1 = y)
        // se comenta porque el siguiente sprite utiliza el mismo tileset
        address_til += Gs[i]->size; // 0x2000 + 96 (3 * 32) = 8288
        prev_tiles += Gs[i]->nTiles;
    }
    /*i = 0;
    while(i < len){
        sGraphic* G = Gs[i++];
        if(G->oM){
            x = G->oM->xMin + ((G->oM->xMax - G->oM->xMin) / 2);
            y = G->oM->yMin + ((G->oM->yMax - G->oM->yMin) / 2);
        }
        G->_def(G, next_id++, next_x_address, next_y_address, prev_tiles, x, y, G->oM, G->sJ);
        load_sprite(G, address_til);
        // incrementamos para el siguiente sprite
        next_x_address += (G->w * 2);    // 0 + 2 (1 tile, 2 = x + index)
        next_y_address += G->h;          // 0 + 1 (1 tile, 1 = y)
        // se comenta porque el siguiente sprite utiliza el mismo tileset
        address_til += G->size; // 0x2000 + 96 (3 * 32) = 8288
        prev_tiles += G->nTiles;
        //Gs++;
        //++i;
    }
    */
}

void reInit(void);
void reInit(void){
    moveDef(&oBallMove, 1, 1, (_SCREEN_WIDTH + 1 - (8 * 1)), 1, 0, (_SCREEN_HEIGHT - (8 * 1)));
    sBall.oM = &oBallMove;
    sBall._def = _ballDef;
    moveDef(&oMark1Move, 1, 8 * _mark_img_w, 8 * _mark_img_w * 3, 0, 0, 8 * _mark_img_h);
    sMark1.oM = &oMark1Move;
    sMark1._def = _markDef;
    moveDef(&oMark2Move, 1, _SCREEN_WIDTH + 1 - (8 * _mark_img_w * 3), _SCREEN_WIDTH + 1 - (8 * _mark_img_w), 0, 0, 8 * _mark_img_h);
    sMark2.oM = &oMark2Move;
    sMark2._def = _markDef;
    moveDef(&oPad1Move, 0, 8 * 2, (8 * _pad_img_w), 2, 0, (_SCREEN_HEIGHT - (8 * _pad_img_h)));
    sPad1.oM = &oPad1Move;
    sPad1._def = _padDef;
    moveDef(&oPad2Move, 0, (_SCREEN_WIDTH - (8 * (_pad_img_w + 2))), (_SCREEN_WIDTH - (8 * 2)), 2, 0, (_SCREEN_HEIGHT - (8 * _pad_img_h)));
    sPad2.oM = &oPad2Move;
    sPad2._def = _padDef;
    moveDef(&oLogo, 0, (_SCREEN_WIDTH >> 1) - ((8 * _guerraTron_img_w) >> 1), (_SCREEN_WIDTH >> 1) + ((8 * _guerraTron_img_w) >> 1), -1, 0, (_SCREEN_HEIGHT - (8 * _guerraTron_img_h)));
    sLogo.oM = &oLogo;
    sLogo.sJ = &oLogoJumpV;
    sLogo._def = _guerraTronDef;

    sGraphic* Gs[] = {&sBall, &sMark1, &sMark2, &sPad1, &sPad2, &sLogo};
    sprLoad(Gs, 6); // la longitud del array anterior
}

/** Inicializa los datos de algunos sprites */
void spritesInit(void){
    /*reInit();
    address_til = _VRAM_SPRITE_PATT;
     */
    /*
     */
    // BALL1 // ID = 0, xAddr = 0, yAddr = 0, addess_til = 0x2000, prev_tiles = 0
    moveDef(&oBallMove, 1, 1, (_SCREEN_WIDTH + 1 - (8 * 1)), 1, 0, (_SCREEN_HEIGHT - (8 * 1)));
    // load_sprite(_miniheart_pal, _miniheart_til, (uint16_t)_miniheart_size);
    _ballDef(&sBall, next_id++, next_x_address, next_y_address, prev_tiles, 40, 40, &oBallMove, NULL);
    load_sprite(&sBall, address_til);
    next_x_address += (1 * 2); // 0 + 2 (1 tile, 2 = x + index)
    next_y_address += 1;       // 0 + 1 (1 tile, 1 = y)
    // se comenta porque el siguiente sprite utiliza el mismo tileset
    address_til += sBall.size; // 0x2000 + 96 (3 * 32) = 8288
    prev_tiles += sBall.nTiles;

    // MARK1 // ID = 0, xAddr = 0, yAddr = 0, addess_til = 0x2000, prev_tiles = 0
    moveDef(&oMark1Move, 1, 8 * _mark_img_w, 8 * _mark_img_w * 3, 0, 0, 8 * _mark_img_h);
    // load_sprite(_miniheart_pal, _miniheart_til, (uint16_t)_miniheart_size);
    _markDef(&sMark1, next_id++, next_x_address, next_y_address, prev_tiles, oMark1Move.xMin, oMark1Move.yMax, &oMark1Move, NULL);
    load_sprite(&sMark1, address_til);
    next_x_address += (1 * 2); // 0 + 2 (1 tile, 2 = x + index)
    next_y_address += 1;       // 0 + 1 (1 tile, 1 = y)
    // se comenta porque el siguiente sprite utiliza el mismo tileset
    address_til += sMark1.size; // 0x2000 + 96 (3 * 32) = 8288
    prev_tiles += sMark1.nTiles;

    // MARK2 // ID = 0, xAddr = 0, yAddr = 0, addess_til = 0x2000, prev_tiles = 0
    moveDef(&oMark2Move, 1, _SCREEN_WIDTH + 1 - (8 * _mark_img_w * 3), _SCREEN_WIDTH + 1 - (8 * _mark_img_w), 0, 0, 8 * _mark_img_h);
    // load_sprite(_miniheart_pal, _miniheart_til, (uint16_t)_miniheart_size);
    _markDef(&sMark2, next_id++, next_x_address, next_y_address, prev_tiles, oMark2Move.xMin, oMark2Move.yMax, &oMark2Move, NULL);
    load_sprite(&sMark2, address_til);
    next_x_address += (1 * 2); // 0 + 2 (1 tile, 2 = x + index)
    next_y_address += 1;       // 0 + 1 (1 tile, 1 = y)
    // se comenta porque el siguiente sprite utiliza el mismo tileset
    address_til += sMark2.size; // 0x2000 + 96 (3 * 32) = 8288
    prev_tiles += sMark2.nTiles;

    // PAD1 // ID = 1, xAddr = 2, yAddr = 1, addess_til = 0x2000, prev_tiles = 0
    moveDef(&oPad1Move, 0, 8 * 2, (8 * _pad_img_w), 2, 0, (_SCREEN_HEIGHT - (8 * _pad_img_h)));
    _padDef(&sPad1, next_id++, next_x_address, next_y_address, prev_tiles, (8 * _pad_img_w), (_SCREEN_HEIGHT >> 1) - ((8 * _pad_img_h) >> 1), &oPad1Move, NULL);
    load_sprite(&sPad1, address_til);
    next_x_address += (3 * 2); // 0 + 2 + 2 (1 tile, 2 = x + index)
    next_y_address += 3;       // 0 + 1 + 1 (1 tile, 1 = y)
    address_til += sPad1.size; // 0x2000 + 96 (3 * 32) = 8288 (+96 = 8384)
    prev_tiles += sPad1.nTiles;

    //oLogoJumpV.gravity = 1;
    //oLogoJumpV.ground_y = 120;
    //oLogoJumpV.is_jumping = false;
    //oLogoJumpV.jump_velocity = 0;

    // PAD2 // ID = 1, xAddr = 2, yAddr = 1, addess_til = 0x2000, prev_tiles = 0
    moveDef(&oPad2Move, 0, (_SCREEN_WIDTH - (8 * (_pad_img_w + 2))), (_SCREEN_WIDTH - (8 * 2)), 2, 0, (_SCREEN_HEIGHT - (8 * _pad_img_h)));
    _padDef(&sPad2, next_id++, next_x_address, next_y_address, prev_tiles, (_SCREEN_WIDTH - (8 * (_pad_img_w + 1))), (_SCREEN_HEIGHT >> 1) - ((8 * _pad_img_h) >> 1), &oPad2Move, NULL);
    load_sprite(&sPad2, address_til);
    next_x_address += (3 * 2); // 0 + 2 + 2 (1 tile, 2 = x + index)
    next_y_address += 3;       // 0 + 1 + 1 (1 tile, 1 = y)
    address_til += sPad2.size; // 0x2000 + 96 (3 * 32) = 8288 (+96 = 8384)
    prev_tiles += sPad2.nTiles;

    // LOGO // ID = 2, xAddr = 4, yAddr = 2, addess_til = 0x2000 + 96, prev_tiles = 0 + 3
    moveDef(&oLogo, 0, (_SCREEN_WIDTH >> 1) - ((8 * _guerraTron_img_w) >> 1), (_SCREEN_WIDTH >> 1) + ((8 * _guerraTron_img_w) >> 1), -1, 0, (_SCREEN_HEIGHT - (8 * _guerraTron_img_h)));
    _guerraTronDef(&sLogo, next_id++, next_x_address, next_y_address, prev_tiles, (_SCREEN_WIDTH >> 1) - ((8 * _guerraTron_img_w) >> 1), (_SCREEN_HEIGHT >> 1) - ((8 * _guerraTron_img_h) >> 1), &oLogo, &oLogoJumpV);
    load_sprite(&sLogo, address_til);
    next_x_address += (sLogo.w * 2); // 0 + 2 + 2 + (6 * 2) (36 tile, 2 = x + index)
    next_y_address += sLogo.h;       // 0 + 1 + 1 + 6       (36 tile, 1 = y)
    address_til += sLogo.size;       // 0x2000 + 96 + 896 = 9184
    prev_tiles += sLogo.nTiles;
    // NEXT // ID = 3, xAddr = 16, yAddr = 8
}

void spritesDefine(void){
    // BALL
    // toTilesgifyDefine(_miniheart_img, sprite_tilesWidth, sprite_tilesHeight);
    //  toTilesgifyDefine(_guerraTron_img, sprite_tilesWidth, sprite_tilesHeight);
    // toTilesgifyDefine(0, _ball_img, sprite_tilesWidth, sprite_tilesHeight, sprite_x, sprite_y);
    // toAniDefine(0, ani_arr, ani_index, sprite_x, sprite_y);
    toAniDefine(&sBall, -1, -1, -1, 0);
    // MARK1
    toAniDefine(&sMark1, -1, -1, lives1 - 1, 0);
    // MARK2
    toAniDefine(&sMark2, -1, -1, lives2 - 1, 0);
    // PAD1
    // toAniDefine(&sPad1, -1, -1, -1, 0);
    toTilesgifyDefineUpdate(&sPad1, -1, -1, -1, 0);
    // PAD2
    // toAniDefine(&sPad2, -1, -1, -1, 0);
    toTilesgifyDefineUpdate(&sPad2, -1, -1, -1, 0);

    // LOGO
    toTilesgifyDefineUpdate(&sLogo, -1, -1, -1, 1);
    /* */
}

/** carga gráficos comunes de todas las pantallas (sprites, images, anis, ..) */
void load_commons(void){
    next_id = 0;
    address_til = _VRAM_SPRITE_PATT; //0x2000; //__VRAM_SPRITE_PATT__;
    next_x_address = 0;
    next_y_address = 0;
    prev_tiles = 0;
    lives1 = 3;
    lives2 = 3;
    __asm__("di"); //; Des-Habilitar interrupciones
    // unable display (0x8160)
    VDP_ADDRESS = 0b00100000; // 0x60; // 96
    VDP_ADDRESS = 0x81;
    // remove backgrounds
    // remove_bg();
    clear_vram(0);
    // draw background image
    draw_bg(_mo_pal, _mo_til, (uint16_t)_mo_size, _mo_tilemap);
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
    // load_music(ARKANOID_TITLE_SCREEN_VGM);
    __asm__("ei"); //; Habilitar interrupciones
}

#endif // __STAGE_COMMONS_H__