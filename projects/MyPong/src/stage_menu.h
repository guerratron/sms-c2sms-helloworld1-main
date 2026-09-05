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
#include <string.h>
#include <newTypes.h>
#include <basic.h>
#include <main.h>

// Definición de puertos de la SMS
#define VDP_DATA_PORT 0xBE
#define VDP_CTRL_PORT 0xBF

// Comandos VDP para escribir en VRAM
#define VRAM_WRITE_CMD 0x4000
#define VREG_WRITE_CMD 0x8000

/*
// Declaración manual de los intrínsecos de SDCC para Z80
// para evitar warnings de "intellisense"
extern void outp(unsigned int port, unsigned char value);
extern unsigned char inp(unsigned int port);
*/
#define OUT_PORT(port, val) __asm \
    ld c, #port                   \
    ld a, #val                    \
    out (c), a                    \
__endasm


// Rutina para enviar un comando/dirección al VDP
void vdp_set_address(uint16_t addr)
{
    uint8_t low = addr & 0xFF;
    uint8_t high = (addr >> 8) | VRAM_WRITE_CMD;

    // Escribir parte baja y luego alta en el puerto de control
    __asm__("di"); // Deshabilitar interrupciones temporalmente
    OUT_PORT(VDP_CTRL_PORT, low);
    OUT_PORT(VDP_CTRL_PORT, high);
    __asm__("ei");
}

// Inicializa el hardware básico (pantalla encendida, modo de fondo)
/*void vdp_init(void)
{
    // Registros estándar de configuración de la Master System
    uint8_t init_regs[] = {
        0x04,
        0b00000110, // Modo 2 (Estándar de 256x192), enable M3, 16K VRAM
        0x01,
        0b10100000, // Despliegue de pantalla activado, interrupciones activadas
        0x02,
        0b11100000, // Name table en 0x3800
        0x05,
        0b01111110, // Sprite Attribute Table (SAT) en 0x3F00
        0x06,
        0b00000111, // Sprite pattern generator base en 0x0000
        0x07,
        0b00000000, // Color de borde 0
    };

    uint8_t i = 0;
    // Enviar registros al VDP
    for (i = 0; i < sizeof(init_regs); i += 2){
        OUT_PORT(VDP_CTRL_PORT, init_regs[i]);
        OUT_PORT(VDP_CTRL_PORT, init_regs[i + 1] | VREG_WRITE_CMD);
    }
}*/

// Carga un Tile de 8x8 en la VRAM
void load_tile(uint8_t tile_index, const uint8_t *tile_data)
{
    vdp_set_address((uint16_t)tile_index * 32);
    uint8_t i = 0;
    for (i = 0; i < 8; i++){
        OUT_PORT(VDP_DATA_PORT, tile_data[i]);
    }
}

// Escribe un texto en una posición específica de la pantalla
void print_text(uint8_t x, uint8_t y, const char *text)
{
    // Calcular dirección en el Tilemap (Name Table)
    uint16_t addr = 0x3800 + (y * 64) + (x * 2);
    vdp_set_address(addr);

    while (*text){
        // Escribir el carácter en ASCII (en la SMS, el índice del Tile)
        // Se le suma un valor base si tus tiles de texto están desplazados
        OUT_PORT(VDP_DATA_PORT, *text);
        OUT_PORT(VDP_DATA_PORT, 0x00); // Byte alto (paleta, flags)
        text++;
    }
}

// Fuente simple de 8x8 para el menú (una 'A' de prueba)
const uint8_t font_A[8] = {
    0b00011000,
    0b00111100,
    0b01100110,
    0b01100110,
    0b01111110,
    0b01100110,
    0b01100110,
    0b00000000};

void _toMenu1(void)
{
    //vdp_init();

    // 1. Cargar el Tile 'A' en la posición 65 (Equivalente al código ASCII de 'A')
    load_tile(65, font_A);

    // 2. Pintar menú en pantalla
    print_text(10, 8, "MENU PRINCIPAL");
    print_text(12, 12, "1. INICIAR JUEGO");
    print_text(12, 14, "2. OPCIONES");
    print_text(12, 16, "3. SALIR");

    // Bucle infinito para congelar el programa
    while (1)
    {
        // Aquí leerías el pad de control leyendo el puerto 0xDC o 0xDD
    }
}