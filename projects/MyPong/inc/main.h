#ifndef __MAIN_H__
#define __MAIN_H__

#include <stdint.h>
#include <stdbool.h>
#include <defines.h>
#include <basic.h>

/** Funciones que hay que definir en el "main.c" obligatoriamente.  
 * Siguen la lógica "Update-Draw" de cualquier juego típico
 */

extern bool _FINISH;
extern bool _PAUSE;
extern uint32_t _DELTA;
extern uint8_t _MASTER;
extern uint8_t vblank_ocurrido;
extern game_state_e game_state;
extern game_state_e last_state;
extern void delay(uint16_t count);

//-------------
/* MÉTODOS A IMPLEMENTAR OBLIGATORIAMENTE*/

/** para configuración de variables y banderas de inicio */
void init(void);
/** Aquí todas las acciones de dibujado seguro de la pantalla (screen, tiles, sprites, music, ..)
 * @param delta {uint32_t} Es el número de ciclos de reloj pasados desde el último retrazado vertical
 * @param master {uint8_t} Es el número de retrazados verticales (de 0 a 255)
 */
void draw(uint32_t delta, uint8_t master);
/** Se ejecuta en cada trazado vertical (al final del sincronismo vertical)
 * Puede aprovecharse para actualizar movimientos o cálculos más pesados.
 * @param delta {uint32_t} Es el número de ciclos de reloj pasados desde el último retrazado vertical
 * @param master {uint8_t} Es el número de retrazados verticales (de 0 a 255) 
 */
void update(uint32_t delta, uint8_t master);
/** se ejecuta en cada ciclo de cpu. Para actualizaciones y cálculos rápidos, NADA de dibujo.
 * Activar/Desactivar alguna bandera y poco más. */
void update_fast(void);
/// @brief el punto de entrada de nuestro código. Basta con llamar a "init() y loop()" en su interior.   
/// - FUNCIONAMIENTO: Implementar "update_fast()" [aunque sea vacío], "draw()" y "update()" y llamar a "init() y loop()" 
/// @param
void main(void);

//--------------
/* NO IMPLEMENTAR, UTILIZAR DRAW Y UPDATE. */ 

/** Inicia el bucle principal y de control de vblank. 
 * Aquí dentro se ejecutan automaticamente los tres métodos a implementar [OBLIGATORIOS, aunque sea vacíos]:
 * - ASINCRONOS: "update_fast()": se llama todo lo rápido que lo permite el reloj del "z80". No depende de PAL-NTSC.
 * - SÍNCRONOS: "draw() y update()": "draw" sucede en el interior de vblank y "update" tras finalizar. Depende de PAL-NTSC.
 */
void loop(void){
    while (last_state == game_state){
        //__asm__("halt"); // Instrucción nativa Z80 para esperar la interrupción (V-Blank)
        while (!vblank_ocurrido){
            update_fast();
            // Aquí se dispara el vblank
        }
        // Aquí succede el resto del vblank y el draw()
        toVblankISR();
        // ..
        //vblank_ocurrido = 0; // Reseteamos la bandera

        if (!_PAUSE){
            // 2. ---> LÓGICA DEL JUEGO (Fuera del V-Blank) NADA DE DIBUJADO (VDP) ! <---
            // Aquí tienes todo el tiempo del mundo (el resto del frame) para:
            // - Leer el mando (Joypad)
            // - Calcular colisiones
            // - Utilizar tus PUNTEROS para desplazar los índices de los tiles del sprite en la RAM
            // Al terminar este bloque, los datos en RAM quedarán listos para la siguiente interrupción.
            update(_DELTA, _MASTER);
        }
    }
}

#endif // __MAIN_H__