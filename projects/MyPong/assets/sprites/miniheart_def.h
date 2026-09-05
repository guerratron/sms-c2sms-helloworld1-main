/*
MINIHEART (logo de 1 tile)
La idea es formar una serie de arrays para representar de forma distinta un array de tiles.
Aplicándolos a un sprite podríamos conseguir un sprite monotile o multitile, incluso animado.
En función de lo que se quiera conseguir se utilizarían unos arrays u otros y funciones específicas
para esto en el "main.c" como: moveDef(), load_sprite(), toTilesgifyDefineUpdate(), o sus versiones
animadas como toAniIndex(), toAniPos(), ...
// Ej:
```c
    #include <miniheart_def.h>
    load_sprite((sGraphic *) &sMiniheart, (uint16_t) vram_addr);
    toTilesgifyDefineUpdate((sGraphic *) &sminiHeart, -1, -1, -1);
```
*/

#ifndef __MINIHEART_DEF_H__
#define __MINIHEART_DEF_H__

// MINIHEART (1 tile)

#include <stdint.h> // uint8_t
#include <string.h> // memcpy()
#include <defines.h>
#include "pal_base_def.h"

// MODIFICAR SÓLO EL NÚMERO DE TILES
//#define _miniheart_ntiles 1
//#define _miniheart_size _miniheart_ntiles * 32 // 32

/* LA PALETA LA TOMARÁ REFERENCIADA A LA PALETA-BASE DE TODOS LOS SPRITES
const uint8_t _miniheart_pal[16] = {
    //        red   white
    0x00, 0x03, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
*/

// IMAGE
// MODIFICAR EL ANCHO Y ALTO ACORDE A LOS DATOS DEL ARRAY '*_img'

/// @brief Ancho DEL SPRITE MULTI-TILE, UNA IMÁGEN O SPRITE COMPLETO DE 1 TILES de ancho
#define _miniheart_img_w 1
/// @brief Alto DEL SPRITE MULTI-TILE, UNA IMÁGEN O SPRITE COMPLETO DE 1 TILE de alto
#define _miniheart_img_h 1
/// @brief TAMAÑO DEL SPRITE MULTI-TILE, UNA IMÁGEN O SPRITE COMPLETO DE 1 TILES (w * h)
#define _miniheart_img_size _miniheart_img_w *_miniheart_img_h
/// ROM.
/// @brief SIRVE PARA CREAR IMAGENES MULTI-TILES, UNA IMÁGEN O SPRITE COMPLETO DE 1 TILES (1 x 1 tiles).
/// NO puede tener más de 8 tiles de ancho (limitación SMS)
/// Los índices se refieren a la posición de cada tile en el 'tileset'
const uint8_t _miniheart_img[_miniheart_img_size] = {
    0x00
};

/// RAM.
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
uint8_t _miniheart_img_clon[_miniheart_img_size];

// ANIMATION
// MODIFICAR EL TAMAÑO ACORDE A LOS DATOS DEL ARRAY '*_ani'

/// @brief TAMAÑO DEL SPRITE ANIMADO (para el array "_miniheart_ani"), UNA ANIMACIÓN DE SPRITE DE SECUENCIAS DE 2 TILES
#define _miniheart_ani_size 2
/// @brief PARA CREAR SPRITES CON ANIMACIONES, UNA BOLA ANIMADA DE 2 TILES.  Es un array de índices de tiles del sprite.
const uint8_t _miniheart_ani[_miniheart_ani_size] = {
    0x00, 0x01};
/// RAM.
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
uint8_t _miniheart_ani_clon[_miniheart_ani_size];

/// JUMP (VERTICAL)
// bool
#define _miniheart_is_jumping false
// int16_t
#define _miniheart_jump_velocity 2
// Nivel del suelo [uint8_t]
#define _miniheart_jump_ground_y 120
// Fuerza de gravedad (ajustable) [int16_t]
#define _miniheart_jump_gravity 1

// MAIN: BITPLANES
// MODIFICAR SOLO EL NÚMERO DE TILES ACORDE A LOS DATOS DEL ARRAY '*_til'

/// @brief Número de tiles de los que se compone el array de tiles "_miniheart_til"
#define _miniheart_ntiles 2
/// @brief Tamaño en bytes de todos los tiles que se compone el array de tiles "_miniheart_til"  // 2 * 32 = 64
#define _miniheart_size _miniheart_ntiles * 32
/** BitPlanes:
 * - TileSet, Patterns, Charset (bitplanes). Unique-Tiles
 * - UNIQUE TILES:: [tiles 2 * 32 bytes]
 */
// TileSet, Patterns, Charset (bitplanes). Unique-Tiles
// UNIQUE TILES:: [tiles 27 * 32 bytes]:: 22% reduc.
/*
     color | symbol | sprite palette index
    -------+--------+----------------------
    transp |   -    | 0b0000 (0)
    red    |   *    | 0b0001 (1)
    white  |   +    | 0b0010 (2)

    --------
    -++-++--
    +**+**+-
    +*****+-
    -+***+--
    --+*+---
    ---+----
    --------
*/
const uint8_t _miniheart_til[_miniheart_size] = {
    // Tile 1
    0x00, 0x00, 0x00, 0x00,
    0x6C, 0x00, 0x6C, 0x6C,
    0x92, 0x00, 0xFE, 0xFE,
    0x82, 0x00, 0xFE, 0xFE,
    0x44, 0x00, 0x7C, 0x7C,
    0x28, 0x00, 0x38, 0x38,
    0x10, 0x00, 0x10, 0x10,
    0x00, 0x00, 0x00, 0x00,
    // Tile 2
    0x00, 0x00, 0x66, 0x66,
    0x66, 0x00, 0xFF, 0xFF,
    0x7E, 0x00, 0xFF, 0xFF,
    0x7E, 0x00, 0xFF, 0xFF,
    0x7E, 0x00, 0xFF, 0xFF,
    0x3C, 0x00, 0x7E, 0x7E,
    0x18, 0x00, 0x3C, 0x3C,
    0x00, 0x00, 0x18, 0x18,
};

/** Función Inicializadora de sprites.
 * Gráfico (fondo, img, sprite o animación) representando un Logo
 * TOTAL: 15 bytes (1 + 1 + 1 + 1 + 2 + 1 + 1 + 1 + 6) + pal_size + tiles_size + img_size + ani_size
 * TOTAL: 66 bytes (1 + 1 + 1 + 16 + 1 + 2 + 32 + 1 + 1 + 1 + 1 + 2 + 6)
 *
 * Llamar a esta función antes de utilizar el "sGraphic" para rellenarlo adecuadamente.
 * No se sabe muy bien, pero a través de un "inicializador de struct" no se inicializaban bien los arrays. */
void _miniheartDef(sGraphic *sG, const uint8_t id, const uint8_t xAddress, const uint8_t yAddress, const uint16_t prev_tiles, const uint8_t x, const uint8_t y, oMove *oM, sJumpV *sJ){
    // ROM->RAM
    // copia de los array original en la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
    // A través de pruebas he observado que la mejor manera (si se quieren editar tiles) es tener un array "const" en la
    // ROM y hacer una copia "volátil" (NO-CONST) en la RAM
    // pal
    // uint8_t _pal_clon[_miniheart_pal_size];
    // memcpy(_miniheart_pal_clon, _miniheart_pal, _miniheart_pal_size);
    // memcpy(_miniheart_pal_clon, _pal_base, _miniheart_pal_size);
    _palBaseDef(sG); // establece "sG->pal"
    // img
    memcpy(_miniheart_img_clon, _miniheart_img, _miniheart_img_size);
    // ani
    memcpy(_miniheart_ani_clon, _miniheart_ani, _miniheart_ani_size);
    sG->id = id;
    sG->xAddress = xAddress;
    sG->yAddress = yAddress;
    sG->prevTiles = prev_tiles;
    sG->x = x;
    sG->y = y;
    // sG->pal = _miniheart_pal_clon; //_miniheart_pal;
    sG->tiles = _miniheart_til;
    sG->size = _miniheart_size;
    sG->nTiles = _miniheart_ntiles;
    sG->img = _miniheart_img_clon; //_miniheart_img;
    sG->w = _miniheart_img_w;
    sG->h = _miniheart_img_h;
    sG->i = 0;
    sG->ani_size = _miniheart_ani_size;
    sG->ani = _miniheart_ani_clon; // _miniheart_ani;
    sG->oM = oM;
    sG->sJ = sJ;
    
    // AJUSTES
    if (sG->sJ){
        sG->sJ->is_jumping = _miniheart_is_jumping;
        sG->sJ->jump_velocity = _miniheart_jump_velocity; // 0;
        sG->sJ->ground_y = _miniheart_jump_ground_y;           // 120; // Nivel del suelo
        sG->sJ->gravity = _miniheart_jump_gravity;             // 1;    // Fuerza de gravedad (ajustable)
    }

    // NO USAR % USAR  if (indice >= maximo) indice = cero;

    // corrección desplazamiento índices de tilesets en img y ani
    uint8_t i = 0;
    // img
    for (i = 0; i < (sG->w * sG->h); i++){  //_miniheart_img_size
        sG->img[i] += sG->prevTiles;
    }
    //  ani
    for (i = 0; i < sG->ani_size; i++){     //_miniheart_ani_size
        sG->ani[i] += sG->prevTiles;
    }
}

#endif //  __MINIHEART_DEF_H__