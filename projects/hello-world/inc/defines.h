/**
 * @file defines.h
 * @brief Definiciones, globales y estructuras comunes de la API.
 * @details Definiciones de utilidad para el acceso a registros y direcciones del **Z80**, algunas estructuras de datos útiles y ciertas **globales** comunes.
 * @author GuerraTron26
 * @date 2026
 * @version 1.0
 */

#ifndef __DEFINES_H__
#define __DEFINES_H__

#include <sdcc-lib.h>
#include <stdint.h>
#include <stdbool.h>
#include <newTypes.h>

/** Multiplica un número decimal por 10 utilizando desplazamiento binario (más rápido)
```c
uint16_t multiplicar10(uint8_t n){
    return (n << 3) + (n << 1);
}
```
*/
#define _MULTIPLICA_10(n) ((n << 3) + (n << 1))

/** Puerto de datos del procesador de video (0xBE) */
__sfr __at(0xBE) VDP_DATA;
/** Puerto de direcciones del procesador de video (0xBF) */
__sfr __at(0xBF) VDP_ADDRESS;
/** Puerto de sonido. Puerto de control/datos del PSG en la Master System. */
__sfr __at(0x7F) PSG;
/** Retorna la lectura del pad 1 (botones + cruceta) en un único byte:  PUERTO:(0xDC)  
 * ``` xx-B2-B1-D-U-R-L ``` Comparar contra _BUTTON_2_, .., _UP_, .. */
__sfr __at(0xDC) _PAD1;
/** Retorna la lectura del pad 2 (botones + cruceta) en un único byte:  PUERTO:(0xDD)  
 * ``` xx-B2-B1-D-U-R-L ``` Comparar contra _BUTTON_2_, .., _UP_, .. */
__sfr __at(0xDD) _PAD2;

/**
 ```
 // puerto 0xDC
    U   = 0b00000001,
    D   = 0b00000010,
    L   = 0b00000100,
    R   = 0b00001000,
    B1  = 0b00010000,
    B2  = 0b00100000,
    U2  = 0b01000000,
    D2  = 0b10000000,
    // puerto 0xDD
    L2  = 0b10000001,
    R2  = 0b10000010,
    B12 = 0b10000100,
    B22 = 0b10001000,
 ```
 */
enum eBUTTONS
{
    // puerto 0xDC
    U   = 0b00000001,
    D   = 0b00000010,
    L   = 0b00000100,
    R   = 0b00001000,
    B1  = 0b00010000,
    B2  = 0b00100000,
    U2  = 0b01000000,
    D2  = 0b10000000,
    // puerto 0xDD
    L2  = 0b10000001,
    R2  = 0b10000010,
    B12 = 0b10000100,
    B22 = 0b10001000,
    res = 0b10010000,
    inA = 0b11000000,
    inB = 0b11000001,
} _BUTTONS;

// Variables para el antirebote
uint8_t debounce_count = 0;
#define DEBOUNCE_LIMIT 2

/// @brief numero de ciclos de reloj desde el último trazado vertical
uint32_t _DELTA = 0;
/// @brief número de trazados verticales (hasta un máximo de _MASTER_MAX).
/// Podemos obtener los Hz, el tiempo y las veces por segundo en reproducir algo. Por ej: if(_MASTER % 50){ sg++; }
uint8_t _MASTER = 0;
/// @brief el máximo de masters permitidos (254). A partir de aquí se resetea a '0'
/// Se ha puesto uno menos para evitar un warning "flow changed by optimizer" en el perro guardián (porque de todas formas ya iba a desbordarse el master el solito a 0)
const uint8_t _MASTER_MAX = 254;
uint8_t vdp_status = 0;
// Para Notificar al juego si ha terminado el volcado de gráficos
uint8_t vblank_ocurrido = 0;

#define PALETTE_OFFSET_TILES 0
#define PALETTE_OFFSET_SPRITES 16

/// @brief Ancho del Tile en pixels (cada pixel 4 bits de color)
const uint8_t _TILE_WIDTH = 8;
/// @brief Alto del Tile en pixels (cada pixel 4 bits de color)
const uint8_t _TILE_HEIGHT = 8;
/// @brief Cantidad total de pixels en cada Tile
const uint8_t _TILE_SIZE = (uint8_t)(8 * 8);
/// @brief Cantidad total de bytes por Tile (planos de bits 32 bytes)
const uint8_t _TILE_BYTES_SIZE = (uint8_t)(8 * 4);
/** 255 */
const uint8_t _SCREEN_WIDTH = 255;
/** 192 */
const uint8_t _SCREEN_HEIGHT = 192;
/** 255
#define __SCREEN_WIDTH__ _SCREEN_WIDTH */
/** 192
#define __SCREEN_HEIGHT__ _SCREEN_HEIGHT */
/// @brief Ancho de la pantalla en tiles
const uint8_t _SCREEN_TILES_WIDTH = 32;
/// @brief Alto de la pantalla en tiles
const uint8_t _SCREEN_TILES_HEIGHT = 24;
/// @brief Cantidad total de Tiles en la pantalla
const uint16_t _SCREEN_TILES_SIZE = (uint16_t)(32 * 24);

/// @brief COLS
const uint8_t _SPRITE_WIDTH = 4;
/// @brief ROWS
const uint8_t _SPRITE_HEIGHT = 8;
/// @brief WIDTH x HEIGHT
const uint8_t _SPRITE_SIZE = (uint8_t)(4 * 8);
/// @brief Sprite/tile colors, 0..255
const uint16_t _VRAM_SPRITE_COL = 0x0000;
/// @brief Sprite/tile patterns, 256..447 (8192 == 0x2000)
const uint16_t _VRAM_SPRITE_PATT = 0x2000;
/// @brief Sprite/tile patterns, 256..447 (8192 == 0x2000)
#define __VRAM_SPRITE_PATT__ 0x2000
/// @brief Screen display: 32x28 table of tile numbers/attributes (14336 == 0x3800)
const uint16_t _VRAM_TILES_TABLE = 0x3800;
/// @brief Sprite info table (COORD. Y): contains x,y and tile number for each sprite (16128 .. 16384 == 0x3F00 .. 0x4000)
const uint16_t _VRAM_SPRITE_INFO_Y = 0x3F00;
/// @brief Sprite info table (COORD. X): contains x,y and tile number for each sprite (16256 ..   == 0x3F80 .. 0x4000)
const uint16_t _VRAM_SPRITE_INFO_X = 0x3F80;
/// @brief 208 aquí significa que este es el final de la tabla de sprites y ya no hay más sprites que pintar (208 == 0xD0)
const uint8_t _VRAM_SPRITE_END = 0xD0;

/** Se utiliza para almacenar el incremento actual en x e y, además de sus límites.
 * Esto puede utilizarse con "moveWith()" para mantener un objeto gráfico en una región rectangular.
 * También tiene incorporado dos contadores por si se necesitasen contadores específicos para cada objeto.
 * Total: 10 bytes
 ```c
 {
    // contador para las x (hasta 65535)
    uint16_t xCount;
    // contador para las y (hasta 65535)
    uint16_t yCount;
    // X
    int8_t xIncr;
    uint8_t xMin;
    uint8_t xMax;
    // Y
    int8_t yIncr;
    uint8_t yMin;
    uint8_t yMax;
}
 ```
 */
typedef struct _oMove{
    // contador para las x (hasta 65535)
    uint16_t xCount;
    // contador para las y (hasta 65535)
    uint16_t yCount;
    // X
    int8_t xIncr;
    uint8_t xMin;
    uint8_t xMax;
    // Y
    int8_t yIncr;
    uint8_t yMin;
    uint8_t yMax;
} oMove;

/** Estructura creada para permitir saltos verticales en sprites */
typedef struct _sJumpV{
    bool is_jumping;
    int16_t jump_velocity;  // Velocidad inicial del salto (impulso hacia arriba)
    uint8_t ground_y;       // Nivel del suelo
    int16_t gravity;        // Fuerza de gravedad (ajustable)
} sJumpV;

/** Representa un gráfico (fondo, img, sprite o animación) como los definidos en "ball_def.h"
 * TOTAL: 15 bytes (1 + 1 + 1 + 1 + 2 + 1 + 1 + 1 + 6) + pal_size + tiles_size + img_size + ani_size
 * Algo normal pueden ser entre 100 bytes y 1 kb
 ```c
 {
    /// id de este Graphic
    uint8_t id;
    /// dirección base x
    uint8_t xAddress;
    /// dirección base y
    uint8_t yAddress;
    /// incremento para corrección de los índices de tiles en img y ani (son los que se llevan acumulados hasta ahora)
    uint16_t prevTiles;
    /// posición X
    uint8_t x;
    /// posición Y
    uint8_t y;
    /// Paleta de hasta 16 colores (array de índices de la paleta global SMS)
    uint8_t *pal;
    /// Número de tiles totales
    uint8_t nTiles;
    /// Número de bytes totales
    uint16_t size;
    /// Bitplanes de cada tile
    const uint8_t *tiles;
    // IMAGE
    /// Array de índice de tiles (consecutivos) que se mostrarán como imágen
    uint8_t *img;
    /// Ancho en tiles de la imágen
    uint8_t w;
    /// Alto en tiles de la imágen
    uint8_t h;
    // ANIMATION
    /// Índice del tile actualmente utilizado (para animaciones)
    uint8_t i;
    /// Array de índice de tiles que se mostrarán secuencialmente en la animación
    uint8_t *ani;
    /// El tamaño del array "ani"
    uint8_t ani_size;
    /// controla si el objeto gráfico es "redibujable" porque haya cambiado (posición, animación, ..)
    bool dirty;
    /// Objeto que define los límites de movimiento
    oMove* oM;
    /// Objeto que permite saltos verticales en el sprite
    sJumpV* sJ;
 }
 ```
 */
typedef struct _sGraphic
{
    /// id de este Graphic
    uint8_t id;
    /// dirección base x
    uint8_t xAddress;
    /// dirección base y
    uint8_t yAddress;
    /// incremento para corrección de los índices de tiles en img y ani (son los que se llevan acumulados hasta ahora)
    uint8_t prevTiles;
    /// posición X
    uint8_t x;
    /// posición Y
    uint8_t y;
    /// Paleta de hasta 16 colores (array de índices de la paleta global SMS)
    uint8_t* pal;
    /// Número de tiles totales
    uint8_t nTiles;
    /// Número de bytes totales
    uint16_t size;
    /// Bitplanes de cada tile
    const uint8_t* tiles;
    // IMAGE
    /// Array de índice de tiles (consecutivos) que se mostrarán como imágen
    uint8_t *img;
    /// Ancho en tiles de la imágen
    uint8_t w;
    /// Alto en tiles de la imágen
    uint8_t h;
    // ANIMATION
    /// Índice del tile actualmente utilizado (para animaciones)
    uint8_t i;
    /// Array de índice de tiles que se mostrarán secuencialmente en la animación
    uint8_t *ani;
    /// El tamaño del array "ani"
    uint8_t ani_size;
    /// controla si el objeto gráfico es "redibujable" porque haya cambiado (posición, animación, ..)
    bool dirty;
    /// Objeto que define los límites de movimiento (6 bytes)
    oMove *oM;
    /// Objeto que permite saltos verticales en el sprite
    sJumpV *sJ;
} sGraphic;

/** SONIDOS-VGM  
 * Total: 2 bytes (1 + 1) * longitud del array de sonido + 2 bytes)
*/
typedef struct _vgm_info{
    const uint8_t *first_byte;
    const uint8_t *next_byte;
    uint16_t wait_counter;
} vgm_info;
vgm_info vgm;


/** DEFINIR LOS ESTADOS DE JUEGO POSIBLE (PANTALLAS) EN EL ENUM "game_state_e", cada "game_state" albergará el estado
  * actual del juego y "last_state" se utiliza para detectar cuando cambiar de pantalla.
  * También habría que almacenar un array (sFs) de estructuras "sStatesF" que se rellenarán en los "load" de cada "stage", 
  * teniendo en cuenta que los índices de este array deben coincidir con los enums del estado del juego (game_state_e). */
typedef enum _game_state_e{
    game_intro,
    game_play,
    game_over
} game_state_e;
game_state_e game_state = game_intro;
game_state_e last_state = game_intro;

/** Punteros a funciones de los distintos estados:
 * "update_fast, update, draw e init"
 * Deben ir en consonancia con las funciones definidas en cada "stage" */
typedef struct _sStatesFunctions{
    game_state_e (*update_fast)(uint16_t count, uint32_t delta);
    game_state_e (*update)(uint32_t delta, uint8_t master);
    game_state_e (*draw)(uint32_t delta, uint8_t master);
    game_state_e (*init)(void);
} sStatesF;

//sStatesF *sf;

/** Máximo número de entradas permitidas para el array de punteros a funciones de estado (*sFs).  
 * Esto representa un máximo de pantallas distintas a mostrar (stages).
 */
#define _STATES_FUNCTIONS_MAX 16
/** Array de punteros a funciones de estado (tipo _sStatesF).  
 * Se rellena en los métodos "load" de cada "stage".  
 * Sus índices deben corresponderse con cada uno de los enums "game_state_e" para cargar la pantalla 
 * adecuada en cada índex.
 */
sStatesF sFs[_STATES_FUNCTIONS_MAX];

uint16_t count = 0;

/// spritesManager.h
/** incrementa el id en gráficos. */
uint8_t next_id = 0;
uint16_t address_til = 0x2000; //__VRAM_SPRITE_PATT__;
/** representa el incremento a la siguiente dirección en memoria de las x del dibujado de gráficos. */
uint8_t next_x_address = 0;
/** representa el incremento a la siguiente dirección en memoria de las y del dibujado de gráficos. */
uint8_t next_y_address = 0;
/** representa el incremento a los siguientes tiles (img, ani) del dibujado de gráficos. */
uint8_t prev_tiles = 0;
/** representa el incremento de la paleta para tilesets del dibujado de gráficos.
 * PROBLEMA: Todos los tiles deben basarse en la misma paleta.
 * SOLUCIÓN: Leer previamente todas las paletas y fundirlas en una sóla (los sprites deben restringirse todos a esos 16 colores)
uint8_t incr_pal = 0;
*/

bool _FINISH = false;
bool _PAUSE = false;
uint8_t point1 = 0;
uint8_t point2 = 0;
uint8_t lastPoint = 0;
bool win1 = false;
bool win2 = false;
uint8_t lives1 = 3;
uint8_t lives2 = 3;

#endif  // __DEFINES_H__