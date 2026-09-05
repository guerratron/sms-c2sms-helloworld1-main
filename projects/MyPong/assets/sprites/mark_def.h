// Made with 'Img2SMS' - by GuerraTron26 <dinertron@gmail.com>

/*
MARK (animación de 3 tiles)
La idea es formar una serie de arrays para representar de forma distinta un array de tiles.
Aplicándolos a un sprite podríamos conseguir un sprite monotile o multitile, incluso animado.
En función de lo que se quiera conseguir se utilizarían unos arrays u otros y funciones específicas
para esto en el "main.c" como: moveDef(), load_sprite(), toTilesgifyDefineUpdate(), o sus versiones
animadas como toAniIndex(), toAniPos(), ...
// Ej:
```c
    #include <ball_def.h>
    load_sprite((sGraphic *) &sBall, (uint16_t) vram_addr);
    toTilesgifyDefineUpdate((sGraphic *) &sBall, -1, -1, -1);
```
*/

#ifndef  __MARK_DEF_H__
#define  __MARK_DEF_H__

#include <stdint.h>
#include <defines.h>
#include "pal_base_def.h"

// TOTAL: (4 + 3 + 3 + 96) 106 bytes

// EN LAS DEFINICIONES DE TAMAÑOS SE HA OPTADO POR 'DEFINES'
// PORQUE CON CONSTANTES ME DABA PROBLEMAS EN LOS TAMAÑOS DE ARRAYS VARIABLES

// 1. Definir el tipo de la función
/*typedef void (*on_load)();

typedef struct screen_t
{
    void (*on_load)(struct _sGraphic *);
    const struct screen_t *(*on_vblank)(uint8_t, struct _sGraphic *);
    void (*on_unload)(struct _sGraphic *);
} xScr;*/

/// @brief Tamaño de la paleta: 4 colores de 16 posibles
//#define _mark_pal_size 4
//#define _mark_pal_size _pal_base_size
/// @brief Paleta de trabajo (hasta 16 colores). Los valores son los índices de la paleta global SMS
/*const uint8_t _mark_pal[_mark_pal_size] = {
    0x00, 0x0b, 0x1f, 0x3f
};*/
/// RAM.  Por si se quisiera cambiar dinámicamente la paleta del sprite
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
//uint8_t _mark_pal_clon[_mark_pal_size];

// IMAGE
// MODIFICAR EL ANCHO Y ALTO ACORDE A LOS DATOS DEL ARRAY '*_img'

/// @brief Ancho DEL SPRITE MULTI-TILE, UNA IMÁGEN DE SPRITE COMPLETA DE 1 TILES de ancho
#define _mark_img_w 3
/// @brief Alto DEL SPRITE MULTI-TILE, UNA IMÁGEN DE SPRITE COMPLETA DE 1 TILE de alto
#define _mark_img_h 1
/// @brief TAMAÑO DEL SPRITE MULTI-TILE, UNA IMÁGEN DE SPRITE COMPLETA DE 1 TILES (w * h)
#define _mark_img_size _mark_img_w * _mark_img_h
/// @brief SIRVE PARA CREAR SPRITES MULTI-TILES, UNA IMÁGEN DE SPRITE COMPLETA DE 1 TILES (1 x 1 tiles).  
/// Los índices se refieren a la posición de cada tile en el 'tileset'
const uint8_t _mark_img[_mark_img_size] = {
    0x00, 0x01, 0x02
};
/// RAM. 
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es 
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
uint8_t _mark_img_clon[_mark_img_size];

// ANIMATION
// MODIFICAR EL TAMAÑO ACORDE A LOS DATOS DEL ARRAY '*_ani'

/// @brief TAMAÑO DEL SPRITE ANIMADO (para el array "_mark_ani"), UNA ANIMACIÓN DE SPRITE DE SECUENCIAS DE 3 TILES
#define _mark_ani_size 3
/// @brief PARA CREAR SPRITES CON ANIMACIONES, UNA BOLA ANIMADA DE 3 TILES.  Es un array de índices de tiles del sprite.
const uint8_t _mark_ani[_mark_ani_size] = {
    0x00, 0x01, 0x02
};
/// RAM.
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
uint8_t _mark_ani_clon[_mark_ani_size];

/// JUMP (VERTICAL)
// bool
#define _mark_is_jumping false
// int16_t
#define _mark_jump_velocity 2
// Nivel del suelo [uint8_t]
#define _mark_jump_ground_y 120
// Fuerza de gravedad (ajustable) [int16_t]
#define _mark_jump_gravity 1

// MAIN: BITPLANES  
// MODIFICAR SOLO EL NÚMERO DE TILES ACORDE A LOS DATOS DEL ARRAY '*_til'  

/// @brief Número de tiles de los que se compone el array de tiles "_mark_til"
#define _mark_ntiles 3
/// @brief Tamaño en bytes de todos los tiles que se compone el array de tiles "_mark_til"
#define _mark_size _mark_ntiles * 32 // 96
/** BitPlanes:
 * - TileSet, Patterns, Charset (bitplanes). Unique-Tiles
 * - UNIQUE TILES:: [tiles 3 * 32 bytes]
 */
 const uint8_t _mark_til[_mark_size] = {
    // Tile 0 ROJO
    0x00, 0x3C, 0x3C, 0x00,
    0x00, 0x7E, 0x7E, 0x00,
    0x10, 0xE3, 0xFF, 0x0C,
    0x30, 0xC3, 0xFF, 0x0C,
    0x3C, 0xC3, 0xFF, 0x00,
    0x18, 0xE7, 0xFF, 0x00,
    0x00, 0x7E, 0x7E, 0x00,
    0x00, 0x3C, 0x3C, 0x00,
    // Tile 2 AMARILLO
    0x00, 0x3C, 0x00, 0x3C,
    0x00, 0x7E, 0x00, 0x7E,
    0x10, 0xF3, 0x0C, 0xFF,
    0x30, 0xF3, 0x0C, 0xFF,
    0x3C, 0xFF, 0x00, 0xFF,
    0x18, 0xFF, 0x00, 0xFF,
    0x00, 0x7E, 0x00, 0x7E,
    0x00, 0x3C, 0x00, 0x3C,
    // Tile 2 VERDE
    0x3C, 0x00, 0x00, 0x00,
    0x7E, 0x00, 0x00, 0x00,
    0xE3, 0x00, 0x1C, 0x0C,
    0xC3, 0x00, 0x3C, 0x0C,
    0xC3, 0x00, 0x3C, 0x00,
    0xE7, 0x00, 0x18, 0x00,
    0x7E, 0x00, 0x00, 0x00,
    0x3C, 0x00, 0x00, 0x00,
 };


/** Función Inicializadora de sprites.
 * Gráfico (fondo, img, sprite o animación) representando una Bola
 * TOTAL: 15 bytes (1 + 1 + 1 + 1 + 2 + 1 + 1 + 1 + 6) + pal_size + tiles_size + img_size + ani_size
 * TOTAL: 121 bytes (1 + 1 + 1 + 4 + 1 + 2 + 96 + 3 + 1 + 1 + 1 + 3 + 6)  
 * 
 * Llamar a esta función antes de utilizar el "sGraphic" para rellenarlo adecuadamente.
 * No se sabe muy bien, pero a través de un "inicializador de struct" no se inicializaban bien los arrays. */
void _markDef(sGraphic *sG, const uint8_t id, const uint8_t xAddress, const uint8_t yAddress, const uint16_t prev_tiles, const uint8_t x, const uint8_t y, oMove *oM, sJumpV * sJ){
    // ROM->RAM
    // copia de los array original en la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
    // A través de pruebas he observado que la mejor manera (si se quieren editar tiles) es tener un array "const" en la
    // ROM y hacer una copia "volátil" (NO-CONST) en la RAM
    // pal
    // uint8_t _pal_clon[_mark_pal_size];
    //memcpy(_mark_pal_clon, _mark_pal, _mark_pal_size);
    //memcpy(_mark_pal_clon, _pal_base, _mark_pal_size);
    _palBaseDef(sG); // establece "sG->pal" 
    // img
    memcpy(_mark_img_clon, _mark_img, _mark_img_size);
    // ani
    memcpy(_mark_ani_clon, _mark_ani, _mark_ani_size);
    sG->id = id;
    sG->xAddress = xAddress;
    sG->yAddress = yAddress;
    sG->prevTiles = prev_tiles;
    sG->x = x;
    sG->y = y;
    //sG->pal = _mark_pal_clon;
    sG->tiles = _mark_til;
    sG->size = _mark_size;
    sG->nTiles = _mark_ntiles;
    sG->img = _mark_img_clon;
    sG->w = _mark_img_w;
    sG->h = _mark_img_h;
    sG->i = 0;
    sG->ani_size = _mark_ani_size;
    sG->ani = _mark_ani_clon;
    sG->oM = oM;
    sG->sJ = sJ;
    
    // AJUSTES
    if (sG->sJ){
        sG->sJ->is_jumping = _mark_is_jumping;
        sG->sJ->jump_velocity = _mark_jump_velocity; // 0;
        sG->sJ->ground_y = _mark_jump_ground_y;           // 120; // Nivel del suelo
        sG->sJ->gravity = _mark_jump_gravity;             // 1;    // Fuerza de gravedad (ajustable)
    }
    // corrección desplazamiento índices de tilesets en img y ani
    uint8_t i = 0;
    // img
    for (i = 0; i < (sG->w * sG->h); i++){  //_mark_img_size
        sG->img[i] += sG->prevTiles;
    }
    // ani
    for (i = 0; i < sG->ani_size; i++){     //_mark_ani_size
        sG->ani[i] += sG->prevTiles;
    }
}

#endif //  __MARK_DEF_H__
