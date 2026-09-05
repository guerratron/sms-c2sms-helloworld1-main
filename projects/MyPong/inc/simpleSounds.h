#ifndef __SIMPLE_SOUNDS_H__
#define __SIMPLE_SOUNDS_H__

#include <stdint.h>
#include <stdbool.h>
#include <newTypes.h>
#include <defines.h>
#include <basic.h>

extern void delay(uint16_t count);

/** Reproduce sonidos simples (tipo beep) permitiendo elegir los milisegundos de duración, 16 tonos (de 0x0 [alto] a 0xF[bajo]), 16 niveles de volumen (de 0x0[max] a 0xf[min]) y la cantidad de repeticiones (<1 no reproduce nada)
 * Detiene la ejecución del bucle principal durante la reproducción.
 */
void playEffectSound(uint8_t msg, uint8_t tono, uint8_t vol, int8_t rep);
void playEffectSound(uint8_t msg, uint8_t tono, uint8_t vol, int8_t rep){
    if (rep > 0){
        // delay(32255);
        //  1. Configurar Tono del Canal 0
        //  Valor de tono = 440 (Frecuencia: aprox. 872 Hz)
        //  Byte bajo: 1000 xxxx -> 1000 1011 (0x8B)
        //  Byte alto: 0000 xxxx -> 0000 0001 (0x01)
        PSG = 0x8B; // Byte bajo de tono (Canal 0)
        PSG = tono; // Byte alto de tono (Canal 0)
        // 2. Configurar Volumen del Canal 0
        // 1001 VVVV -> VVVV es el volumen (0 = Máximo, 15 = Mute)
        PSG = 0x90 + vol; // 1001 0000 (Canal 0, Volumen Máximo)
        // 3. Esperar un momento (dejar sonar el beep)
        delay(msg * 10);
        // 4. Silenciar el Canal 0
        // 1001 VVVV -> 1001 1111 (Volumen 15 = Silencio)
        PSG = 0x9F;
        // 3. Esperar un momento (en silencio)
        delay(msg * 10);
        // volver a reproducir
        playEffectSound(msg, tono, vol, --rep);
    }
}

/** Reproduce un simple beep (admite duración y repetición).
 * Detiene la ejecución del bucle principal durante la reproducción. */
void playBeep(uint8_t msg, int8_t rep);
void playBeep(uint8_t msg, int8_t rep){
    playEffectSound(msg, 0x09, 0, rep);
}

/** Silencia canales de sonido.  
 * indicar el canal a silenciar (0-1-2-3) o -1 para silenciarlos todos. */
void mute(int8_t canal);
void mute(int8_t canal) {
    // Canal 0 (Atenuación máxima = volumen off)
    if(canal < 1){ PSG = 0x9F; } // 10011111
    // Canal 1
    if(canal == -1 || canal == 1){ PSG = 0xBF; } // 10111111
    // Canal 2
    if(canal == -1 || canal == 2){ PSG = 0xDF; } // 11011111
    // Canal de Ruido (Volume off)
    if(canal == -1 || canal == 3){ PSG = 0xFF; } // 11111111
}

#endif //__SIMPLE_SOUNDS_H__