/**
 * @file states.h
 * @brief Archivo para administrar el ciclo de vida de las pantallas a cargar.
 * @details Este archivo variará en función de las pantallas a cargar. Hay que definir todo el ciclo de vida en cada una de las pantallas cargadas (init, update, draw, ..)  
 * En el código principal habría que llamar a "loadStatesFunctions()" una vez para quedar preparado el array que alberga las pantallas. 
 * @author GuerraTron26
 * @date 2026
 * @version 1.0
 */

#ifndef __STATES_H__
#define __STATES_H__

/// FUNCIONES EXTRAÍDAS DEL MARAVILLOSO BLOG DE "AVELINO HERRERA" :
/// https://avelinoherrera.com/

//#include <sdcc-lib.h>
#include <stdint.h>
#include <newTypes.h>
#include <defines.h>
#include "stage_intro.h"

//extern game_state_e game_state;
void load_intro(uint8_t index);
game_state_e init_intro(void);
game_state_e update_fast_intro(uint16_t cont, uint32_t delta);
game_state_e update_intro(uint32_t delta, uint8_t master);
game_state_e draw_intro(uint32_t delta, uint8_t master);

/** PRIMERA FUNCIÓN A LLAMAR PARA CARGAR LOS RECURSOS.  
 * Rellena el array de las funciones de estado de las distintas pantallas "stage" cargadas en memoria */
uint8_t loadStatesFunctions(void);
uint8_t loadStatesFunctions(void){
    // memset(sFs, NULL, _STATES_FUNCTIONS_MAX);
    uint8_t index = 0;
    load_intro(index++);
    return index;
}

#endif // __STATES_H__