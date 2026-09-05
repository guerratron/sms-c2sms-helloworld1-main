// Made with 'Img2SMS' - by GuerraTron26 <dinertron@gmail.com>

/*
BALL (animación de 3 tiles)
La idea es formar una serie de arrays para representar de forma distinta un array de tiles.
Aplicándolos a un sprite podríamos conseguir un sprite monotile o multitile, incluso animado.
En función de lo que se quiera conseguir se utilizarían unos arrays u otros y funciones específicas
para esto en el "main.c" como: draw_sprite(), toTilesgifyDefine(), toTilesgifyUpdate(), o sus versiones 
animadas como toAniIndex(), toAniPos(), ...
// Ej:
```c
* #include <ball_def.h>
* load_sprite((uint8_t *)_ball_pal, (uint8_t *)_ball_til, (uint16_t)_ball_size);
* toTilesgifyDefine((uint8_t *)_ball_img, tilesWidth, tilesHeight);
```
*/

#ifndef  __BALL_DEF_H__
#define  __BALL_DEF_H__

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
//#define _ball_pal_size 4
//#define _ball_pal_size _pal_base_size
/// @brief Paleta de trabajo (hasta 16 colores). Los valores son los índices de la paleta global SMS
/*const uint8_t _ball_pal[_ball_pal_size] = {
    0x00, 0x0b, 0x1f, 0x3f
};*/
/// RAM.  Por si se quisiera cambiar dinámicamente la paleta del sprite
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
//uint8_t _ball_pal_clon[_ball_pal_size];

// IMAGE
// MODIFICAR EL ANCHO Y ALTO ACORDE A LOS DATOS DEL ARRAY '*_img'

/// @brief Ancho DEL SPRITE MULTI-TILE, UNA IMÁGEN DE SPRITE COMPLETA DE 3 TILES de ancho
#define _ball_img_w 3
/// @brief Alto DEL SPRITE MULTI-TILE, UNA IMÁGEN DE SPRITE COMPLETA DE 1 TILE de alto
#define _ball_img_h 1
/// @brief TAMAÑO DEL SPRITE MULTI-TILE, UNA IMÁGEN DE SPRITE COMPLETA DE 3 TILES (w * h)
#define _ball_img_size _ball_img_w * _ball_img_h
/// @brief SIRVE PARA CREAR SPRITES MULTI-TILES, UNA IMÁGEN DE SPRITE COMPLETA DE 3 TILES (3 x 1 tiles).  
/// Los índices se refieren a la posición de cada tile en el 'tileset'
const uint8_t _ball_img[_ball_img_size] = {
    0x00, 0x01, 0x02
};
/// RAM. 
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es 
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
uint8_t _ball_img_clon[_ball_img_size];

// ANIMATION
// MODIFICAR EL TAMAÑO ACORDE A LOS DATOS DEL ARRAY '*_ani'

/// @brief TAMAÑO DEL SPRITE ANIMADO (para el array "_ball_ani"), UNA ANIMACIÓN DE SPRITE DE SECUENCIAS DE 3 TILES
#define _ball_ani_size 3
/// @brief PARA CREAR SPRITES CON ANIMACIONES, UNA BOLA ANIMADA DE 3 TILES.  Es un array de índices de tiles del sprite.
const uint8_t _ball_ani[_ball_ani_size] = {
    0x00, 0x01, 0x02
};
/// RAM.
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
uint8_t _ball_ani_clon[_ball_ani_size];

// MAIN: BITPLANES  
// MODIFICAR SOLO EL NÚMERO DE TILES ACORDE A LOS DATOS DEL ARRAY '*_til'  

/// @brief Número de tiles de los que se compone el array de tiles "_ball_til"
#define _ball_ntiles 3
/// @brief Tamaño en bytes de todos los tiles que se compone el array de tiles "_ball_til"
#define _ball_size _ball_ntiles * 32 // 96
/** BitPlanes:
 * - TileSet, Patterns, Charset (bitplanes). Unique-Tiles
 * - UNIQUE TILES:: [tiles 3 * 32 bytes]
 */
const uint8_t _ball_til[_ball_size] = {
    //Tile 0
    0x00, 0x00, 0x00, 0x00, 
    0x3c, 0x00, 0x00, 0x00, 
    0x6e, 0x1c, 0x00, 0x00, 
    0x4e, 0x3c, 0x00, 0x00, 
    0x42, 0x3c, 0x00, 0x00, 
    0x66, 0x18, 0x00, 0x00, 
    0x3c, 0x00, 0x00, 0x00, 
    0x00, 0x00, 0x00, 0x00, 
    //Tile 1
    0x3c, 0x00, 0x00, 0x00, 
    0x7e, 0x00, 0x00, 0x00, 
    0xef, 0x1c, 0x00, 0x00, 
    0xcf, 0x3c, 0x00, 0x00, 
    0xc3, 0x3c, 0x00, 0x00, 
    0xe7, 0x18, 0x00, 0x00, 
    0x7e, 0x00, 0x00, 0x00, 
    0x3c, 0x00, 0x00, 0x00, 
    //Tile 2
    0x00, 0x00, 0x00, 0x00, 
    0x00, 0x3c, 0x00, 0x00, 
    0x18, 0x66, 0x00, 0x00, 
    0x3c, 0x5a, 0x00, 0x00, 
    0x3c, 0x5a, 0x00, 0x00, 
    0x18, 0x66, 0x00, 0x00, 
    0x00, 0x3c, 0x00, 0x00, 
    0x00, 0x00, 0x00, 0x00
 }; //'un_tile_patterns'


/** Función Inicializadora de sprites.
 * Gráfico (fondo, img, sprite o animación) representando una Bola
 * TOTAL: 15 bytes (1 + 1 + 1 + 1 + 2 + 1 + 1 + 1 + 6) + pal_size + tiles_size + img_size + ani_size
 * TOTAL: 121 bytes (1 + 1 + 1 + 4 + 1 + 2 + 96 + 3 + 1 + 1 + 1 + 3 + 6)  
 * 
 * Llamar a esta función antes de utilizar el "sGraphic" para rellenarlo adecuadamente.
 * No se sabe muy bien, pero a través de un "inicializador de struct" no se inicializaban bien los arrays. */
sGraphic *_ballDef(sGraphic *sG, const uint8_t id, const uint8_t xAddress, const uint8_t yAddress, const uint16_t prev_tiles, const uint8_t x, const uint8_t y, oMove *oM){
    // ROM->RAM
    // copia de los array original en la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
    // A través de pruebas he observado que la mejor manera (si se quieren editar tiles) es tener un array "const" en la
    // ROM y hacer una copia "volátil" (NO-CONST) en la RAM
    // pal
    // uint8_t _pal_clon[_ball_pal_size];
    //memcpy(_ball_pal_clon, _ball_pal, _ball_pal_size);
    //memcpy(_ball_pal_clon, _pal_base, _ball_pal_size);
    _palBaseDef(sG); // establece "sG->pal"
    // img
    memcpy(_ball_img_clon, _ball_img, _ball_img_size);
    // ani
    memcpy(_ball_ani_clon, _ball_ani, _ball_ani_size);
    sG->id = id;
    sG->xAddress = xAddress;
    sG->yAddress = yAddress;
    sG->prevTiles = prev_tiles;
    sG->x = x;
    sG->y = y;
    //sG->pal = _ball_pal_clon;
    sG->tiles = _ball_til;
    sG->size = _ball_size;
    sG->nTiles = _ball_ntiles;
    sG->img = _ball_img_clon;
    sG->w = _ball_img_w;
    sG->h = _ball_img_h;
    sG->i = 0;
    sG->ani_size = _ball_ani_size;
    sG->ani = _ball_ani_clon;
    sG->oM = oM;
    // corrección desplazamiento índices de tilesets en img y ani
    uint8_t i = 0;
    // img
    for (i = 0; i < _ball_img_size; i++){
        sG->img[i] += sG->prevTiles;
    }
    // ani
    for (i = 0; i < sG->ani_size; i++){
        sG->ani[i] += sG->prevTiles;
    }
    return sG;
}

#endif //  __BALL_DEF_H__
