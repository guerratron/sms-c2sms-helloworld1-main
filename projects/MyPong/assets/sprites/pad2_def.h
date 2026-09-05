// Made with 'Img2SMS' - by GuerraTron26 <dinertron@gmail.com>

// PAD2 (1 Tile)

#ifndef  __PAD2_DEF_H__
#define  __PAD2_DEF_H__

#include <stdint.h>

// MODIFICAR SOLO EL NÚMERO DE TILES
#define _pad2_ntiles 1
#define _pad2_size _pad2_ntiles * 32 // 32

// Paleta de trabajo (16 colores). Los valores son los índices de la paleta global SMS
const uint8_t _pad2_pal[2] = {
  0x00, 0x07 //0xff5500
};

// TileSet, Patterns, Charset (bitplanes). Unique-Tiles
// UNIQUE TILES:: [tiles 1 * 32 bytes]
const uint8_t _pad2_til[_pad2_size] = {
     //Tile 0
     0x07, 0x00, 0x00, 0x00, 
     0x07, 0x00, 0x00, 0x00, 
     0x07, 0x00, 0x00, 0x00, 
     0x07, 0x00, 0x00, 0x00, 
     0x07, 0x00, 0x00, 0x00, 
     0x07, 0x00, 0x00, 0x00, 
     0x07, 0x00, 0x00, 0x00, 
     0x07, 0x00, 0x00, 0x00 
 }; //'un_tile_patterns'

#endif //  __PAD2_DEF_H__
