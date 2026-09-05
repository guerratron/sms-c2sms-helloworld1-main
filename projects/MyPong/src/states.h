#ifndef __STATES_H__
#define __STATES_H__

/// FUNCIONES EXTRAÍDAS DEL MARAVILLOSO BLOG DE "AVELINO HERRERA" :
/// https://avelinoherrera.com/

//#include <sdcc-lib.h>
#include <stdint.h>
#include <newTypes.h>
#include <defines.h>
#include "stage_intro.h"
#include "stage_play.h"
#include "stage_gameover.h"

//extern game_state_e game_state;
void load_intro(uint8_t index);
game_state_e init_intro(void);
game_state_e update_fast_intro(uint16_t cont, uint32_t delta);
game_state_e update_intro(uint32_t delta, uint8_t master);
game_state_e draw_intro(uint32_t delta, uint8_t master);

void load_play(uint8_t index);
game_state_e init_play(void);
game_state_e update_fast_play(uint16_t cont, uint32_t delta);
game_state_e update_play(uint32_t delta, uint8_t master);
game_state_e draw_play(uint32_t delta, uint8_t master);

void load_gameover(uint8_t index);
game_state_e init_gameover(void);
game_state_e update_fast_gameover(uint16_t cont, uint32_t delta);
game_state_e update_gameover(uint32_t delta, uint8_t master);
game_state_e draw_gameover(uint32_t delta, uint8_t master);

/** PRIMERA FUNCIÓN A LLAMAR PARA CARGAR LOS RECURSOS.  
 * Rellena el array de las funciones de estado de las distintas pantallas "stage" cargadas en memoria */
uint8_t loadStatesFunctions(void);
uint8_t loadStatesFunctions(void){
    // memset(sFs, NULL, _STATES_FUNCTIONS_MAX);
    uint8_t index = 0;
    load_intro(index++);
    load_play(index++);
    load_gameover(index++);
    return index;
}

#endif // __STATES_H__