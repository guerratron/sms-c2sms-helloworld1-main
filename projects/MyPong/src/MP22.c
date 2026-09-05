// ---------------------------------
// Project _xxx_, view the README.md
// ---------------------------------
/** ATENCIÓN: la paleta para tilesets del dibujado de gráficos deben basarse en la misma paleta.
 *  Todos los sprites cargados deben restringirse a esos 16 colores.
 * Para esto existe una utilidad en "tools/retilesgify/" que desplaza los índices de colores de la
 * paleta por los proporcionados. Hay que modificar en el archivo "retilesgify.c" la parte de los 
 * arrais "tabla_indices[16]" y "_til[]", así como el #define de número de tiles: "_ntiles". 
 * Recompilarlo (ej: > gcc retilesgify.c) y ejecutarlo (ej: > a.exe) 
 * Y guardar el nuevo array de tilesets remapeado en su lugar correspondiente del archivo de 
 * definiciones */
 
#include <sdcc-lib.h>
#include <stdint.h>
#include <stdbool.h>
#include <newTypes.h>
#include <defines.h>
#include <basic.h>
#include <main.h>
#include "states.h"
#include "const.h"
#include "ires.h"
#include "load_commons.h"

extern bool _FINISH;
extern bool _PAUSE;
extern uint32_t _DELTA;
extern uint8_t _MASTER;
extern game_state_e game_state;
extern game_state_e last_state;

extern uint16_t count;

void init(void){
    count = 0;
    load_commons();
    game_state = sFs[game_state].init();
}

/// @brief en el draw() la variable "vblank_ocurrido" es igual a "1"
/// @param delta
/// @param master
void draw(uint32_t delta, uint8_t master){
    // para evitar "parámetros sin usar": warning 85: in function draw unreferenced function argument : 'delta'
    delta;
    master;
    game_state = sFs[game_state].draw(delta, master);
}

/// @brief en el update() la variable "vblank_ocurrido" es igual a "0"
/// @param delta 
/// @param master 
void update(uint32_t delta, uint8_t master){
    delta;
    master;
    game_state = sFs[game_state].update(delta, master);
}

/** se ejecuta en cada ciclo de cpu. Para actualizaciones y cálculos rápidos, NADA de dibujo.
 * Activar/Desactivar alguna bandera y poco más.
 * en el update_fast() la variable "vblank_ocurrido" es igual a "0"*/
void update_fast(void){
    count++;
   
    // CONTROLA PAUSE CADA X MILISG. SEGÚN LA PULSACIÓN CONJUNTA DE LOS DOS BOTONES DEL PAD
    if ((count & 0b111101011) && 
        (((isPress(B1) && isPress(B2))) || 
        ((isPress(B12) && isPress(B22))))
    ){
        _PAUSE = !_PAUSE;
        count = 0;
    }
    _DELTA++;

    game_state = sFs[game_state].update_fast(count, _DELTA);
}
 
/// @brief el punto de entrada de nuestro código.
/// Al "draw()" lo llama la función "vblankISR()" durante el "V-Blank"
/// @param
void main(void) {
    game_state = game_intro;
    loadStatesFunctions();
    mute(-1);
    while(1){
        init();
        //playBeep(100, 2);
        loop();// si sale del loop esque ha cambiado de pantalla
    }
}
