#ifndef __SPRITES_MANAGER_H__
#define __SPRITES_MANAGER_H__

#include <sdcc-lib.h>
#include <stdint.h>
#include <stdbool.h>
#include <newTypes.h>
#include <defines.h>
#include <basic.h>
//#include "const.h"
//#include "ires.h"

/* Alberga las funciones de carga en memoria y dibujado de los sprites 
 * sobre el VDP utilizando las "macros de SDCC" */

void load_palette(uint8_t *pal){
    write_palette(PALETTE_OFFSET_SPRITES, pal);
    //VDP_ADDRESS = 0; // border color = color 0 of sprite palette
    //VDP_ADDRESS = 0x87;
}

/** Carga en memoria el array de tiles que representará un sprite.
 * Posteriormente habría que utilizar las funciones toTilesgifyDefine() y toTilesgifyUpdate(), 
 * o sus versiones de sprite toAniDefine(), toAniIndex y toAniPos(),  
 * para representarlos en pantalla en el lugar correcto. */
void load_sprite(const sGraphic *spr, uint16_t vram_addr){
    //uint8_t nTilesSprite = size / _TILE_BYTES_SIZE;
    load_palette(spr->pal);
    //vram_addr = _VRAM_SPRITE_PATT;
    write_vram(spr->tiles, spr->size, vram_addr); //, _VRAM_SPRITE_PATT);
}

/** Establece y define las coordenadas de un sprite multi-tile y sus índices de tile correspondientes.
 * Si se definen números negativos en id, posX y posY se utilizarán los definidos en su archivo de definiciones.
 * Posteriormente se podrían actualizar esas coordenadas a través de toTilesgifyUpdate(w, h) sin tener que
 * volver a definir los índices.  
 * Hay que especificar si es el último a visualizar o no  
 * Antes de esta función se supone que se habrán cargado los tiles a la zona de sprites en el VDP por ejemplo
 * con draw_sprite(..);
 * Ej:
 ```c
    #include <ball_def.h>
    load_sprite((sGraphic *) &sBall, (uint16_t) vram_addr);
    toTilesgifyDefineUpdate((sGraphic *) &sBall, -1, -1, -1);
 ```
 */
void toTilesgifyDefineUpdate(sGraphic *spr, int8_t id, int8_t posX, int8_t posY, uint8_t last){
    if(!spr || (spr->dirty == false)){ return; } // si no es redibujable sale
    if(id > -1){ spr->id = id; }
    if(posX > -1){ spr->x = posX; }
    if(posY > -1){ spr->y = posY; }
    uint8_t row = 0;
    uint8_t col = 0;
    // PALETTE
    //load_palette(spr->pal);
    /*
    (1 byte = int8 / uint8) (H | L)
    0x3f =  63 = 0b00111111
    0x40 =  64 = 0b01000000
    0xff = 255 = 0b11111111 (uint8)
    (2 bytes = int16/uint16) (HL)
    _VRAM_SPRITE_INFO_Y = 0x3f 00 = 16128 = 0b00111111 00000000
    _VRAM_SPRITE_INFO_X = 0x3f 80 = 16256 = 0b00111111 10000000
    _VRAM_SPRITE_END    = 0x00 D0 =   208 = 0b00000000 11010000 (1 byte uint8)
    */
    // Posición Y: Base 0x3F00 (\(0x7F00\) combinando con escritura)
    // El segundo registro al hacer 'OR' con 0x40 (0b01000000) activamos la parte alta de los tilesets
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF) + spr->yAddress; //spr->id;  // 0 + row; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F));  // 0x3f;// // 0x40
    // or #0x40            ; Activamos el bit de escritura en VRAM (0x4000)
    // and #0x3F           ; Nos aseguramos de limpiar los dos bits superiores
    for (row = 0; row < spr->h; row++){
        for (col = 0; col < spr->w; col++){
            VDP_DATA = spr->y + (row*8);// siguiente fila es * 8 pixels;
        }
    }
    if(last > 0){ VDP_DATA = _VRAM_SPRITE_END; } // end of sprite list (sprite_y = 208)

    // Posición X e Índice: Base 0x3F80 (\(0x7F80\) para escribir)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress; //spr->id;       // 0x80 + col; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
    for (row = 0; row < spr->h; row++){
        for (col = 0; col < spr->w; col++){
            VDP_DATA = spr->x + (col*8); // siguiente columna es * 8 pixels
            VDP_DATA = spr->img[(row * spr->w) + col]; // tile number of sprite tiles
            //VDP_DATA = *(spr->img + (row * spr->w) + col); //[(row * spr->w) + col]; // tile number of sprite tiles
        }
    }
    spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
}

/** Define de una sola pasada tanto índices como posición en los sprites animados de 1 sólo tile de ancho.
 * Posteriormente puede utilizarse toAniIndex() o toAniPos() para mover sólo índices o posición.  
 * Hay que especificar si es el último a visualizar o no
 */
void toAniDefine(sGraphic *spr, int8_t posX, int8_t posY, int8_t aniIndex, uint8_t last){
    if(posX > -1){ spr->x = posX; }
    if(posY > -1){ spr->y = posY; }
    if(aniIndex > -1){ spr->i = aniIndex;
    }
    // PALETTE
    load_palette(spr->pal);
    // Y
    // Solo permite la primera posición 'y' (el primer tile)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF) + spr->yAddress;//spr->id;  // 0 + row; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F)); // 0x3f;// // 0x40
    VDP_DATA = spr->y;
    if(last > 0){ VDP_DATA = _VRAM_SPRITE_END; } // end of sprite list (sprite_y = 208)
    //X
    // Posición X e Índice: Base 0x3F80 (\(0x7F80\) para escribir)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress;//spr->id + 1;// * 2;       // 0x80 + col; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
    VDP_DATA = spr->x;
    //VDP_DATA = *(spr->ani + spr->i);
    VDP_DATA = spr->ani[spr->i]; // tile number of sprite tile
    spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
}
/** Actualiza el índex en sprites animados de 1 sólo tile de ancho.  Mantiene su posición.
 * Utilizar toAniPos() si se desea actualizar también su posición. */
void toAniIndex(sGraphic *spr, int8_t aniIndex){
    if(!spr || (spr->dirty == false)){ return; } // si no es redibujable sale
    if(aniIndex > -1){ spr->i = aniIndex; }
    // PALETTE
    //load_palette(spr->pal);
    // ANI[i]
    // Posición X e Índice: Base 0x3F80 (\(0x7F80\) para escribir)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress + 1;//spr->id + 1 + 1;// * 2 + 1;       // se salta la X
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
    //VDP_DATA = *(spr->ani + spr->i);
    VDP_DATA = spr->ani[spr->i]; // tile number of sprite tile
    spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
}
/** Actualiza la posición de sprites animados de 1 sólo tile de ancho. Mantiene su índex.
 * Utilizar toAniIndex() si se desea actualizar también el índice de tile representado. */
void toAniPos(sGraphic *spr, int8_t posX, int8_t posY){
    if(!spr || (spr->dirty == false)){ return; } // si no es redibujable sale
    if(posX > -1){ spr->x = posX; }
    if(posY > -1){ spr->y = posY; }
    // PALETTE
    //load_palette(spr->pal);
    // Y
    // Solo permite la primera posición 'y' (el primer tile)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF) + spr->yAddress;//spr->id;          // 0 + row; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F)); // 0x3f;// // 0x40
    VDP_DATA = spr->y;
    //if(last > 0){ VDP_DATA = _VRAM_SPRITE_END; } // end of sprite list (sprite_y = 208)
    // X
    // Posición X e Índice: Base 0x3F80 (\(0x7F80\) para escribir)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress;//spr->id + 1;// * 2;          // 0x80 + col; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
    VDP_DATA = spr->x;
    spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
}
/** Aglomera ambas funcinciones "toAniIndex() + toAniPos()" en una. */
void toAniIndexPos(sGraphic *spr, int8_t aniIndex, int8_t posX, int8_t posY){
    if(!spr || (spr->dirty == false)){ return; } // si no es redibujable sale
    if(aniIndex > -1){ spr->i = aniIndex; }
    if(posX > -1){ spr->x = posX; }
    if(posY > -1){ spr->y = posY; }
    // PALETTE
    //load_palette(spr->pal);
    // Y
    // Solo permite la primera posición 'y' (el primer tile)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF) + spr->yAddress;//spr->id;          // 0 + row; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F)); // 0x3f;// // 0x40
    VDP_DATA = spr->y;
    //if(last > 0){ VDP_DATA = _VRAM_SPRITE_END; } // end of sprite list (sprite_y = 208)
    // X
    // Posición X e Índice: Base 0x3F80 (\(0x7F80\) para escribir)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF) + spr->xAddress;//spr->id + 1;// * 2;          // 0x80 + col; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
    VDP_DATA = spr->x;
    VDP_DATA = spr->ani[spr->i]; // tile number of sprite tile
    spr->dirty = false; // lo marca como no redibujable hasta que vuelva a cambiar
}


/** Desplaza un objeto "Gráfico" con las limitaciones impuestas por su objeto "Move".  
 * Oscila entre dos valores: Máximo y Mínimo tanto en x como en y.  
 * Sirve básicamente para limitar el desplazamiento a un rectángulo (por ej. Screen)  
 * Puede modificar internamente el incremento tanto en x como en y.  
 * De paso también va contando la cantidad de veces que llega a un límite (tanto x como y), aunque este 
 * contador puede utilizarse externamente como se quiera, por ejemplo a modo de "contador de frames".
 * El parámetro "autoChange = 1" permite que el cambio de dirección se producca automáticamente, si por el 
 * contrario se iguala a "0" el objeto se queda quieto al llegar a uno de los límites.
 * Retorna -1, 0, 1, 2, 3 según haya alcanzado el límite xMax, xMin, yMáx o yMin (o -1 si no lo ha alcanzado)
*/
int8_t moveWith(sGraphic* sG, bool autoChange){
    int8_t limit = -1;
    int8_t change = (autoChange ? -1 : 0);
    //oMove* oM = sG->oM;
    if(sG->oM == NULL){ return limit; }
    sG->x += sG->oM->xIncr;
    if (sG->x >= sG->oM->xMax){
        sG->oM->xIncr *= change; //-1
        sG->oM->xCount++;    // CONTADOR INTERNO DE LOS MARKADORES
        limit = 0;
    } else if (sG->x <= sG->oM->xMin){
        sG->oM->xIncr *= change; // 1
        sG->oM->xCount++;     // CONTADOR INTERNO DE LOS MARKADORES
        limit = 1;
    }
    sG->y += sG->oM->yIncr;
    if (sG->y >= sG->oM->yMax){
        sG->oM->yIncr *= change; // -1
        sG->oM->yCount++;        // CONTADOR INTERNO DE LOS MARKADORES
        limit = 2;
    } else if (sG->y <= sG->oM->yMin){
        sG->oM->yIncr *= change; // 1
        sG->oM->yCount++;        // CONTADOR INTERNO DE LOS MARKADORES
        limit = 3;
    }

    if (sG->oM->xCount >= 65534){
        sG->oM->xCount = 0;
    }
    if (sG->oM->yCount >= 65534){
        sG->oM->yCount = 0;
    }
    sG->dirty = true;
    return limit;
}

/** Para definir los valores iniciales en un objeto "oMove"
 * (Ya que en este compilador se presentan problemas para definirlos en un inicializador de struct genérico) */
void moveDef(oMove *oM, int8_t xIncr, uint8_t xMin, uint8_t xMax, int8_t yIncr, uint8_t yMin, uint8_t yMax){
    oM->xCount = 0;
    oM->xIncr = xIncr;
    oM->xMin = xMin;
    oM->xMax = xMax;
    oM->yCount = 0;
    oM->yIncr = yIncr;
    oM->yMin = yMin;
    oM->yMax = yMax;
}

bool isColission(sGraphic* sG1, sGraphic* sG2){
    //if((sG1->dirty == false) && (sG2->dirty == false)){ return false; } // si no se han movido ninguno de los dos no comprobar
    /*if ( 
        ((sG1->x >= sG2->x) && (sG1->x <= (sG2->x + sG2->w))) // : x
        &&
        ((sG1->y >= sG2->y) && (sG1->y <= (sG2->y + sG2->h))) // : y
    ){
        return 1;
    }
    return 0;*/
    if (sG1->x + (sG1->w * 8) < sG2->x) return false; // s1 está a la izquierda de s2
    if (sG1->x > sG2->x + (sG2->w * 8)) return false; // s1 está a la derecha de s2
    if (sG1->y + (sG1->h * 8) < sG2->y)  return false; // s1 está arriba de s2
    if (sG1->y > sG2->y + (sG2->h * 8))  return false; // s1 está debajo de s2

    return true; // Hay colisión
}

/*
sJumpV* makeJumpV(int16_t jump_velocity, uint8_t ground_y, int16_t gravity){
    // Variables para el salto
    sJumpV *jump;
    jump->is_jumping = false;
    jump->jump_velocity = jump_velocity; // 0;
    jump->ground_y = ground_y; // 120; // Nivel del suelo
    jump->gravity = gravity; //1;    // Fuerza de gravedad (ajustable)
    return jump;
}*/

/** Se utiliza con gráficos que tengan definido un objeto "sJumpV".  
 * Hay que utilizarlo en cada refresco del update.
 */
void update_jumpV(sGraphic *sG){
    if (sG->sJ && sG->sJ->is_jumping) {
        // Actualizamos posición
        sG->y -= sG->sJ->jump_velocity;

        // Aplicamos gravedad (reduce velocidad de subida / aumenta velocidad de caída)
        sG->sJ->jump_velocity -= sG->sJ->gravity;

        // Comprobamos si ha tocado el suelo
        if (sG->y >= sG->sJ->ground_y) {
            sG->y = sG->sJ->ground_y;
            sG->sJ->is_jumping = false;
            sG->sJ->jump_velocity = 0;
        }
        sG->dirty = true;
    }
}
/** La función iniciadora del "jump" de este objeto gráfico. Tras ella ya queda habilitado "update_jumpV(..)" */
void trigger_jumpV(sGraphic *sG){
    if (sG->sJ && !sG->sJ->is_jumping) {
        sG->sJ->is_jumping = true;
        sG->sJ->jump_velocity = 8; // Velocidad inicial del salto (impulso hacia arriba)
    }
}

#endif //__SPRITES_MANAGER_H__