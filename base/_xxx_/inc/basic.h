/**
 * @file basic.h
 * @brief Funciones de bajo nivel para el manejo de la API.
 * @details Muchas de ellas extraídas del maravilloso blog de "Avelino Herrera" (https://avelinoherrera.com/).
 * @author GuerraTron26
 * @date 2026
 * @version 1.0
 */

#ifndef __BASIC_H__
#define __BASIC_H__

/// FUNCIONES EXTRAÍDAS DEL MARAVILLOSO BLOG DE "AVELINO HERRERA" :
/// https://avelinoherrera.com/

#include <sdcc-lib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <newTypes.h>
#include <defines.h>
    // #include <main.h>

extern bool _FINISH;
extern bool _PAUSE;
extern uint32_t _DELTA;
extern uint8_t _MASTER;
//extern const uint8_t _MASTER_MAX;
extern uint8_t vdp_status;
extern uint8_t vblank_ocurrido;
extern uint8_t debounce_count;
extern void draw(uint32_t delta, uint8_t master);

// Función de retardo muy básica
void delay(uint16_t count);
void delay(uint16_t count) {
    uint16_t i;
    for (i = 0; i < count; i++) {
        __asm__("nop");
    }
}

/*uint8_t isPress(uint8_t pad, uint8_t button){
    uint8_t result = pad == 0 ? _PAD1 : _PAD2;
    return !(result & button); //los botones se presionan a cero.
}*/

/** Comprueba la pulsación de alguno de los dos pads. El pad 2 (UP-DOWN) se comprueba en el mismo puerto 
 * que el pad 1 (0xDC), los demás botones del pad 2 van al puerto (0XDD) (VER "defines.h")
 * Todos los botones tienen lógica negada, osea, se pulsan a nivel bajo (0).
 */
uint8_t isPress(enum eBUTTONS button);
uint8_t isPress(enum eBUTTONS button){
    uint8_t pad = _PAD1;
    //bool result = false;
    if(button == L2 || button == R2 || button == B12 || button == B22){
        pad = _PAD2;
        button &= 0b00001111; //LES ASIGNA SU VALOR CORRECTO (ESTABA DESPLAZADO)
    }
    if(button == res || button == inA){
        pad = _PAD2;
        button &= 0b01010000; //LES ASIGNA SU VALOR CORRECTO (ESTABA DESPLAZADO)
    }
    if(button == inB){
        pad = _PAD2;
        button &= 0b01000001; //LES ASIGNA SU VALOR CORRECTO (ESTABA DESPLAZADO)
    }
    return !(pad & button); //los botones se presionan a cero.
}

/** Pause simulado por software. [No es el botón de "pause" físico de la consola]
 * Si se pulsan los dos botones A+B y ha transcurrido el tiempo establecido como máximo retornará TRUE. */
bool isSoftwarePause(uint16_t count, uint16_t max);
bool isSoftwarePause(uint16_t count, uint16_t max){
    return ((count > max) && ((isPress(B1) && isPress(B2)) || (isPress(B12) && isPress(B22))));
}

//- 0x3F00 + n: es la coordenada "y" del sprite (un valor de 208 aquí significa que este es
// el final de la tabla de sprites y ya no hay más sprites que pintar).
//  - 0x3F80 + (n x 2):es la coordenada "x" del sprite.
//  - 0x3F81 + (n x 2):índice de la baldosa(0 a 255).

/// @brief inicializa una estructura "vgm_info" a partir de los datos de una canción en formato VGM. Desde la función main-init se invoca "vgm_init" indicando un puntero a los datos VGM a procesar.   
/// Detecta automaticamente si es una versión anterior a la 3.36 (0x150) y corrige con un offset para obtener los datos correctos.
/// @param vgm
/// @param file_data
void vgm_init(vgm_info *vgm, const uint8_t *file_data);
void vgm_init(vgm_info *vgm, const uint8_t *file_data){
    uint32_t version = *((uint32_t *)(file_data + 0x08));
    if (version < 0x00000150){
        vgm->next_byte = file_data + 0x40;
    }else{
        uint32_t data_offset = *((uint32_t *)(file_data + 0x34));
        if (data_offset == 0x0000000C){
            vgm->next_byte = file_data + 0x40;
        }else{
            vgm->next_byte = file_data + data_offset + 0x34;
        }
    }
    vgm->first_byte = vgm->next_byte;
    vgm->wait_counter = 0;
}

/// @brief se encarga de escribir los datos en el chip de sonido con la cadencia indicada por la canción VGM. Esta función debe ser invocada en cada vblank del VDP. (el "update" o "draw")
/// @param vgm
void vgm_tick(vgm_info *vgm);
void vgm_tick(vgm_info *vgm){
    if (vgm->wait_counter > 0){
        --vgm->wait_counter;
        return;
    }
    const uint8_t *p = vgm->next_byte;
    if (*p == 0x50){
        vgm->wait_counter = 0;
        while (*p == 0x50){
            ++p;
            PSG = *p;
            ++p;
        }
    }
    while ((*p == 0x61) || (*p == 0x62) || (*p == 0x63)){
        if ((*p == 0x62) || (*p == 0x63)){
            ++vgm->wait_counter;
            ++p;
        }else{ // *p == 0x61
            ++p;
            uint16_t num_samples = *((uint16_t *)p);
            p += 2;
            // vgm->wait_counter += num_samples / 882;    // convert samples to ticks (requires stdlib because of integer division)
            //
            //  aproximate num_samples / 882 with num_samples / 768 = num_samples / (256 * 3)
            //  (1 / 3) * 65536 = 21845, so:
            //  num_samples / 768 = ((num_samples / 256) * 21845) / 65536
            //  num_samples / 768 = ((num_samples >> 8) * 21845) >> 16
            //  num_samples / 768 = (ns * 21845) >> 24
            //  num_samples / 768 = (ns * (16384 + 4096 + 512 + 256 + 32 + 4)) >> 24
            //  num_samples / 768 = ((ns << 14) + (ns << 12) + (ns << 8) + (ns << 5) + (ns << 2) + ns) >> 24
            uint32_t aux = num_samples;
            aux = ((aux << 14) + (aux << 12) + (aux << 8) + (aux << 5) + (aux << 2)) >> 24;
            vgm->wait_counter = aux;
        }
    }
    while ((*p & 0x70) == 0x70){
        // wait n + 1 samples, 1 tick = 882 samples, so ignore 0x7X commands
        ++p;
    }
    if (*p == 0x66){
        vgm->wait_counter = 0;
        vgm->next_byte = vgm->first_byte;
    }else{
        vgm->next_byte = p;
    }
}

// #include <arkanoid_title_screen_vgm.h>
// Carga la música en formato vgm. Luego habría que llamar en el "update" al métod "vgm_tick(..)"
void load_music(uint8_t *mus);
void load_music(uint8_t *mus){
    vgm_init(&vgm, mus); // vgm es una estructura de tipo "vgm_info" definida en "defines.h"
}
// END: SONIDOS-VGM

// BEGIN: GRAPHICS (PALETTE, SPRITES, TILES)
// Función para rellenar la VRAM con algún valor. Si se entrega '0' se limpiará la pantalla
void clear_vram(uint8_t fill);
void clear_vram(uint8_t fill) {
    // 1. Configurar dirección inicial de VRAM en $0000 y código de escritura
    //VDP_CTRL = 0x00;
    //VDP_CTRL = 0x40;
    VDP_ADDRESS = 0x00; // start at color 0
    VDP_ADDRESS = 0x40; //0b01000000; // 64 // 0x40

    // 2. Escribir 16 KB (16384 bytes) con ceros
    // La memoria de video de la Master System tiene 16 KB
    uint16_t i = 0;
    for(i = 0; i < 16384; i++) {
        VDP_DATA = fill;//0x00;
    }
}

// Escribe 16 valores en la paleta de fondos (en el "0xc000") o de sprites (en el "0xc016")
void write_palette(uint8_t offset, const uint8_t *palette);
void write_palette(uint8_t offset, const uint8_t *palette){
    VDP_ADDRESS = offset; // start at color 0
    VDP_ADDRESS = 0b11000000; // 192 // 0xc0 
    uint8_t n = 16;
    while (n > 0){
        VDP_DATA = *palette;
        ++palette;
        --n;
    }
}
// END: PALETTE

void write_vram(const uint8_t *src, uint16_t size, uint16_t vram_addr);
void write_vram(const uint8_t *src, uint16_t size, uint16_t vram_addr){
    VDP_ADDRESS = (uint8_t)(vram_addr & 0x00FF);
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((vram_addr >> 8) & 0x3F));
    while (size > 0){
        VDP_DATA = *src;
        ++src;
        --size;
    }
}

void write_vram_2(const uint8_t *src, uint16_t size, uint16_t vram_addr);
void write_vram_2(const uint8_t *src, uint16_t size, uint16_t vram_addr){
    VDP_ADDRESS = (uint8_t)(vram_addr & 0x00FF);
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((vram_addr >> 8) & 0x3F));
    while (size > 0){
        VDP_DATA = *src;
        VDP_DATA = 0;
        ++src;
        --size;
    }
}
// END: GRAPHICS (PALETTE, SPRITES, TILES)
void draw_bg(uint8_t *pal, uint8_t *tiles, uint16_t size, uint8_t *tilemap);
void draw_bg(uint8_t *pal, uint8_t *tiles, uint16_t size, uint8_t *tilemap){
    // const uint16_t tilemap_size = _SCREEN_TILES_SIZE; // 32 * 24;
    //  draw background image
    write_palette(PALETTE_OFFSET_TILES, pal);
    write_vram(tiles, size, 0);                        // 3 * 4 * 8, 0); // 240 + 1 tile patterns --> vram pattern address (0x0000)
    write_vram_2(tilemap, _SCREEN_TILES_SIZE, 0x3800); // 32 * 24 tiles --> vram tile map address (0x3800)
    /**/
}
/** rellena el tileset con un unico tile vacío y el tilemap con este tileset */
void remove_bg(void);
void remove_bg(void){
    uint8_t tiles[256];
    memset(tiles, 0, 256); //
    uint8_t tilemap[32 * 24]; //_SCREEN_TILES_SIZE 32 * 24;
    memset(tilemap, 0, _SCREEN_TILES_SIZE); // 32 * 24;
    write_vram(tiles, 1, 0); // --> vram pattern address (0x0000)
    write_vram_2(tilemap, _SCREEN_TILES_SIZE, 0x3800); // 32 * 24 (768) tiles --> vram tile map address (0x3800)
    /**/
}
/*
//#include <string.h>
// #include <miniheart_def.h>
void load_sprite(uint8_t *pal, uint8_t *tiles, uint16_t size)
{
    uint8_t nTilesSprite = size / _TILE_BYTES_SIZE;
    write_palette(PALETTE_OFFSET_SPRITES, pal);
    VDP_ADDRESS = 0; // border color = color 0 of sprite palette
    VDP_ADDRESS = 0x87;
    write_vram(tiles, size, _VRAM_SPRITE_PATT);
}
    */

// DEFINIDAS EN EL "crt0sms.s"

/// rutina de servicio de interrupción sólo interrumpible por una interrupción no enmascarable (NMI).
/// En la práctica es una rutina "normal" de interrupción que lo primero que hacer nada más entrar es
/// deshabilitar las interrupciones y volver a habilitarlas antes de salir.
/// La interrupción vblank es la parte del código donde habitualmente se realiza la escritura o modificación de los sprites, las baldosas, etc.ya que es en ese momento cuando se está produciendo una pausa entre un cuadro y el siguiente.
/// En la práctica se ha separado en dos rutinas para mejorar el ciclo de vida, ésta y "toVblankISR()" que será la encargada realmente del dibujado gráfico. 
/// De momento en esta interrupción nos basta con atender a la bandera "vblank_ocurrido" y ponerla en "true" para salir del 
/// bucle de actualización rápida "update_fast()". 
/// Inmediatamente después hay que atender a la función real de dibujado "toVblankISR()".
void vblankISR(void) __critical __interrupt(0);
void vblankISR(void) __critical __interrupt(0){
    // Notificamos al juego que el volcado de gráficos inició
    vblank_ocurrido = true;
    vdp_status = VDP_ADDRESS;
}

/// Se produce inmediatamente destrués de la rutina de servicio de interrupción V-Blank.
/// Lo primero que hacer nada más entrar es deshabilitar las interrupciones y volver a habilitarlas antes de salir.
/// En esta función es la parte del código donde habitualmente se realiza la escritura o modificación de los sprites, las baldosas, etc.ya que es en ese momento cuando se está produciendo una pausa entre un cuadro y el siguiente.
/// Código para la ejecución de todo lo concerniente al dibujado.
/// Será llamado desde el bucle principal del "main.h" una vez disparado el vBlank.
/// Podemos decir que se ejecuta "DENTRO" del vBlank, aunque físicamente se encuentre fuera.
/// Aquí dentro la variable "vblank_ocurrido" es igual a "true" hasta terminar la función.
void toVblankISR(void);
void toVblankISR(void){
    __asm__("di"); //; Des-Habilitar interrupciones
    //vdp_status = VDP_ADDRESS;
    if (!_PAUSE){
        // update(_DELTA, _MASTER);
        // if(_MASTER % 4 == 0){
        draw(_DELTA, _MASTER); // main.h
        //}
        ++_MASTER;
        if(_MASTER > _MASTER_MAX){ _MASTER = 0; }
    }
    _DELTA = 0;
    __asm__("ei"); //; Habilitar interrupciones
    // ?? salta un warning "modified DOG":
    // warning 110: conditional flow changed by optimizer: so said EVELYN the modified DOG
    vdp_status = VDP_ADDRESS;
    // Notificamos al juego que el volcado de gráficos terminó
    vblank_ocurrido = false;
}


/// rutina de servicio de interrupción no interrumpible y no enmascarable (NMI).
/// Se ejecuta cuando se pulsa en botón "pause" de la consola.
void nmISR(void) __critical __interrupt(1);
void nmISR(void) __critical __interrupt(1) {}

#endif // __BASIC_H__