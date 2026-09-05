#include <stdio.h>
#include <stdint.h>

/*
RETILESGIFY v1.0
    Remapea un tileset SMS (bitplanes) a los índices de una nueva paleta. 
    
 Modificar los arrais "tabla_indices[16]" y "_til[]", así como el #define de número de tiles: "_ntiles". 
 Recompilarlo (ej: > gcc retilesgify.c) y ejecutarlo (ej: > a.exe)
 *existe una bandera "hexadecimal" activada a 1, si se desea "decimal" desactivarla.
*/

/*
# PREGUNTA: tengo un tileset de bitplanes y quiero establecer nuevos índices de esos colores de paleta
# RESPUESTA (IA):
# Para establecer nuevos índices de paleta en un tileset de bitplanes en la Sega Master System, debes reordenar los bits de los planos (bitplanes) dentro de los 32 bytes de cada tile.
# En la SMS, los gráficos usan formato Planar de 4 bits (4bpp). Cada píxel obtiene su índice final combinando 1 bit de cada uno de los 4 planos: 
# BitFinal = (b3 * 8) + (b2 * 4) + (b1 * 2) + (b0 * 1)
# Si cambias el índice de la paleta (por ejemplo, que el color original 1 ? %0001 pase a ser el color 4 ? %0100), debes aplicar una operación lógica bit a bit en las filas del tile para 
# mover los bits entre los planos 0 y 2.

# 1. Descomponer las filas del TileCada tile de 8 × 8 píxeles se compone de 8 filas. 
# Cada fila ocupa exactamente 4 bytes consecutivos en la VRAM (un byte por cada bitplane):
# - Byte 0 = Bitplane 0 (b0) (Bit menos significativo)
# - Byte 1 = Bitplane 1 (b1)
# - Byte 2 = Bitplane 2 (b2)
# - Byte 3 = Bitplane 3 (b3) (Bit más significativo)
# 2. Mapear la conversión de Índices
# Define una función de remapeo "I_viejo = I_nuevo" para los 16 colores posibles. 
# Por ejemplo, si deseas hacer el siguiente cambio de índices: 
# - Píxeles con índice 1 (%0001) ? pasan a índice 2 (%0010)
# - Píxeles con índice 3 (%0011) ? pasan a índice 6 (%0110)

# 03. Reconstruir los Bitplanes en código
# Para cambiar los índices de un píxel individual dentro de una fila (posición x de 0 a 7, de izquierda a derecha), se extrae su bit de cada byte original, 
# se calcula el nuevo índice y se reconstruyen los nuevos bytes.
# La fórmula para extraer el índice original de un píxel en la posición horizontal x es:

# Iviejo = ( ((Byte3 & (1 << (7 - x))) / (2 ^ (7 - x))) * 8 ) + 
#          ( ((Byte2 & (1 << (7 - x))) / (2 ^ (7 - x))) * 4 ) + 
#          ( ((Byte1 & (1 << (7 - x))) / (2 ^ (7 - x))) * 2 ) + 
#          ( ((Byte0 & (1 << (7 - x))) / (2 ^ (7 - x))) * 1 )

# Una vez hallado "I_viejo", buscas su "I_nuevo" y separas sus 4 bits binarios (n3, n2, n1, n0) para encender o apagar los bits correspondientes en los nuevos 4 bytes de la fila.
# Código automatizado de conversión (Python)Modificar esto a mano en ensamblador Z80 consume demasiados ciclos de CPU en tiempo de ejecución. Lo ideal es procesar el tileset antes de compilarlo 
# usando un script como este:
*/

void remapear_fila_bitplanes(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, 
                             const int8_t tabla_mapeo[16],
                             uint8_t *nuevo_b0, uint8_t *nuevo_b1, uint8_t *nuevo_b2, uint8_t *nuevo_b3) {
    
    // Inicializar los nuevos bytes en cero utilizando los punteros
    *nuevo_b0 = 0;
    *nuevo_b1 = 0;
    *nuevo_b2 = 0;
    *nuevo_b3 = 0;
    
    // Procesar cada uno de los 8 píxeles de la fila (de izquierda a derecha)
    for (int x = 0; x < 8; x++) {
        int shift = 7 - x;
        
        // 1. Extraer los bits individuales de cada bitplane original
        uint8_t bit0 = (b0 >> shift) & 1;
        uint8_t bit1 = (b1 >> shift) & 1;
        uint8_t bit2 = (b2 >> shift) & 1;
        uint8_t bit3 = (b3 >> shift) & 1;
        
        // 2. Reconstruir el índice de color original (0-15)
        uint8_t indice_viejo = (bit3 << 3) | (bit2 << 2) | (bit1 << 1) | bit0;
        
        // 3. Obtener el nuevo índice directamente desde el array de mapeo
        int8_t indice_nuevo = tabla_mapeo[indice_viejo];
        
        if(indice_nuevo == -1){ continue; }
        
        // 4. Descomponer el nuevo índice en sus componentes de bitplane
        uint8_t n0 = (uint8_t) ((indice_nuevo >> 0) & 1);
        uint8_t n1 = (uint8_t) ((indice_nuevo >> 1) & 1);
        uint8_t n2 = (uint8_t) ((indice_nuevo >> 2) & 1);
        uint8_t n3 = (uint8_t) ((indice_nuevo >> 3) & 1);
        
        // 5. Insertar los bits mediante máscaras OR en las variables apuntadas
        *nuevo_b0 |= (n0 << shift);
        *nuevo_b1 |= (n1 << shift);
        *nuevo_b2 |= (n2 << shift);
        *nuevo_b3 |= (n3 << shift);
    }
}


/*
# EJEMPLO DE USO:
# Diccionario de conversión: índice = índice-viejo, valor = índice-nuevo
# Los índices no especificados (-1) mantendrán su valor original
*/
const int8_t tabla_indices[16] = {
    -1, //10,   // lo que era 0 será 10
    6,   // Lo que era color 1 se vuelve color 11
    10, 
    1,
    5,  // el color 2 será color 12 
    12,
    11,
    4,   // # Lo que era color 3 se vuelve color 13
    -1, -1, -1, -1, -1, -1, -1, -1
    //4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    //0   // # Lo que era color 15 se vuelve color 0 (transparente)
};

// TILESETS
/// @brief Número de tiles de los que se compone el array de tiles "_til"
#define _ntiles 3
/// @brief Tamaño en bytes de todos los tiles que se compone el array de tiles "_til"
#define _size _ntiles * 32 // 96
/** BitPlanes:
 * - TileSet, Patterns, Charset (bitplanes). Unique-Tiles
 * - UNIQUE TILES:: [tiles 3 * 32 bytes]
 */
uint8_t _til[_size] = {
    // Tile 0
    0x3c, 0x00, 0x00, 0x00, 
    0x7e, 0x00, 0x00, 0x00, 
    0xef, 0x00, 0x1c, 0x00, 
    0xcf, 0x00, 0x3c, 0x00, 
    0xc3, 0x00, 0x3c, 0x00, 
    0xe7, 0x00, 0x18, 0x00, 
    0x7e, 0x00, 0x00, 0x00, 
    0x3c, 0x00, 0x00, 0x00, 
    //Tile 2
    0x00, 0x3c, 0x00, 0x00, 
    0x00, 0x7e, 0x00, 0x00, 
    0x0c, 0xf3, 0x1c, 0x00, 
    0x0c, 0xf3, 0x3c, 0x00, 
    0x00, 0xff, 0x3c, 0x00, 
    0x00, 0xff, 0x18, 0x00, 
    0x00, 0x7e, 0x00, 0x00, 
    0x00, 0x3c, 0x00, 0x00, 
    //Tile 3
    0x3c, 0x3c, 0x00, 0x00, 
    0x7e, 0x7e, 0x00, 0x00, 
    0xff, 0xf3, 0x1c, 0x00, 
    0xff, 0xf3, 0x3c, 0x00, 
    0xff, 0xff, 0x3c, 0x00, 
    0xff, 0xff, 0x18, 0x00, 
    0x7e, 0x7e, 0x00, 0x00, 
    0x3c, 0x3c, 0x00, 0x00
}; //'un_tile_patterns'


void main(void){
    uint8_t hexadecimal = 1;
    printf("// Tilesets:\nuint8_t _til[%d] = {\n", _size);
    for (int y = 0; y < _size; y += 4) {
        uint8_t nb0 = 0;
        uint8_t nb1 = 0;
        uint8_t nb2 = 0;
        uint8_t nb3 = 0;
        remapear_fila_bitplanes(_til[y + 0], _til[y + 1], _til[y + 2], _til[y + 3], 
                             tabla_indices,
                             &nb0, &nb1, &nb2, &nb3);
        _til[y + 0] = nb0; 
        _til[y + 1] = nb1;
        _til[y + 2] = nb2;
        _til[y + 3] = nb3;
        if(y % 32 == 0){
            printf("  // Tile %d\n", y/32);
        }
        if(hexadecimal){
            printf("  0x%02X, 0x%02X, 0x%02X, 0x%02X, \n", nb0, nb1, nb2, nb3);
        }else{
            printf("  %d, %d, %d, %d, \n", nb0, nb1, nb2, nb3);
        }
        
    }
    printf("};\n");
}

/*
 // SALIDA: 
 
 // Tilesets:
 uint8_t _til[96] = {
    // Tile 0
    0, 255, 0, 255,
    60, 255, 0, 255,
    110, 227, 28, 255,
    78, 195, 60, 255,
    66, 195, 60, 255,
    102, 231, 24, 255,
    60, 255, 0, 255,
    0, 255, 0, 255,
    // Tile 1
    60, 255, 0, 255,
    126, 255, 0, 255,
    239, 227, 28, 255,
    207, 195, 60, 255,
    195, 195, 60, 255,
    231, 231, 24, 255,
    126, 255, 0, 255,
    60, 255, 0, 255,
    // Tile 2
    0, 255, 0, 255,
    0, 195, 60, 255,
    24, 153, 102, 255,
    60, 165, 90, 255,
    60, 165, 90, 255,
    24, 153, 102, 255,
    0, 195, 60, 255,
    0, 255, 0, 255,
 };
*/