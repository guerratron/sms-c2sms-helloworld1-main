// Made with 'Img2SMS' - by GuerraTron26 <dinertron@gmail.com>

// PAD1 (1 Tile)

#ifndef  __PAD1_DEF_H__
#define  __PAD1_DEF_H__

#include <stdint.h>

// MODIFICAR SOLO EL NÚMERO DE TILES
#define _pad1_ntiles 1
#define _pad1_size _pad1_ntiles * 32 // 32

// Paleta de trabajo (16 colores). Los valores son los índices de la paleta global SMS
const uint8_t _pad1_pal[2] = {
  0x38, 0x00 
};

// TileSet, Patterns, Charset (bitplanes). Unique-Tiles
// UNIQUE TILES:: [tiles 1 * 32 bytes]
const uint8_t _pad1_til[_pad1_size] = {
     //Tile 0
     0x1f, 0x00, 0x00, 0x00, 
     0x1f, 0x00, 0x00, 0x00, 
     0x1f, 0x00, 0x00, 0x00, 
     0x1f, 0x00, 0x00, 0x00, 
     0x1f, 0x00, 0x00, 0x00, 
     0x1f, 0x00, 0x00, 0x00, 
     0x1f, 0x00, 0x00, 0x00, 
     0x1f, 0x00, 0x00, 0x00
 }; //'un_tile_patterns'

#endif //  __PAD1_DEF_H__
