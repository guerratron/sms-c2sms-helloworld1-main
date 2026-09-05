// Made with 'Img2SMS' - by GuerraTron26 <dinertron@gmail.com>
/*
Paleta base de 16 colores común para sprites.
Para evitar que cada sprite maneje su propia paleta personalizada se deberia trabajar con esta
en común para todos ellos, para evitar así problemas con paletas múltiples que no pueden mostrarse
en una SMS. (sólo dos, bg y sprites)
Tan sólo importar este archivo desde el archivo de definiciones del sprite o imágen y así tendríamos
disponible el array "_pal_base[16]"
// Ej:
```c
* #include <pal_base_def.h>
* ...
* // Ya está disponible el array "_pal_base" ( y el clon "_pal_base_clon" para posibles modificaciones, No da lugar)
* // y función "_palBaseDef(..)" para utilizar en cada gráfico, que es la encargada de copiar el "clon"
```
*/

#ifndef  __PAL_BASE_DEF_H__
#define  __PAL_BASE_DEF_H__

// PAL_BASE (16 COLS)
// TOTAL: 16 + 16 = 32 bytes

#include <stdint.h> // uint8_t
#include <string.h> // memcpy()

// PALETTE

/// @brief Tamaño de la paleta: 16 colores de 16 posibles
#define _pal_base_size 16
/// ROM.  
/// Paleta de trabajo (16 colores). Los valores son los índices de la paleta global SMS
/// Trabajar todos los sprites dentro de estos 16 colores.
const uint8_t _pal_base[_pal_base_size] = {
    0x00, 0x04, 0x24, 0x10, 0x14, 0x06, 0x02, 0x01, 0x11, 0x15, // guerraTron Logo
    0x0b, 0x1f, 0x3f, 0x00, 0x00, 0x00                          // ball sprite
};
/// RAM.  Por si se quisiera cambiar dinámicamente la paleta del sprite.  
/// copia el array original de la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
/// A través de pruebas he observado que la mejor manera (o quizás la única, si se quieren editar tiles) es
/// tener un array "const" en la ROM y hacer una copia "volátil" (NO-CONST) en la RAM
//uint8_t _pal_base_clon[_pal_base_size];

/** Función para inicializar las paletas comunes de sprites.  
 * Sólo ocupa 1 lugar, se toma una referencia en cada sprite.
 * sG: Estructura para un Gráfico (fondo, img, sprite o animación)
 * Llamar a esta función antes de utilizar el "sGraphic" para rellenarlo adecuadamente. Por ejemplo desde dentro 
 * de la llamada de cada sprite ``` _[SPRITE]Def(sG) ``` */
void _palBaseDef(sGraphic *sG){
    // ROM->RAM
    // copia de los array original en la ROM para permitir modificación en el puntero (básicamente de ROM a RAM)
    // A través de pruebas he observado que la mejor manera (si se quieren editar tiles) es tener un array "const" en la
    // ROM y hacer una copia "volátil" (NO-CONST) en la RAM
    // pal
//memcpy(_pal_base_clon, _pal_base, _pal_base_size);
//sG->pal = _pal_base_clon;
    // marca un warning avisando que el puntero pierde el calificador de constante (por eso el casting)
    sG->pal = (uint8_t *)_pal_base; // &(_pal_base[0]); 
    // corrección desplazamiento índices de tilesets
    /*uint8_t i = 0;
    // tiles
    for (i = 0; i < _pal_base_size; i++){
        sG->tiles[i] += sG->prevTiles;
    }*/
}

#endif //  __PAL_BASE_DEF_H__
