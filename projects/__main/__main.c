
#include <stdint.h>


__sfr __at (0xBE) VDP_DATA;
__sfr __at (0xBF) VDP_ADDRESS;
__sfr __at (0x7F) PSG;


const uint8_t SPRITE_PALETTE[16] = {
//        red   white
    0x00, 0x03, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};


/*
     color | symbol | sprite palette index
    -------+--------+----------------------
    transp |   -    | 0b0000 (0)
    red    |   *    | 0b0001 (1)
    white  |   +    | 0b0010 (2)

    --------
    -++-++--
    +**+**+-
    +*****+-
    -+***+--
    --+*+---
    ---+----
    --------
*/
const uint8_t SPRITE_PATTERN[32] = {
    /*
    0x18, 0x18, 0x18, 0x18,
    0x24, 0x24, 0x24, 0x24,
    0x42, 0x42, 0x42, 0x42,
    0x81, 0x81, 0x81, 0x81,
    0x81, 0x81, 0x81, 0x81,
    0x42, 0x42, 0x42, 0x42,
    0x24, 0x24, 0x24, 0x24,
    0x18, 0x18, 0x18, 0x18
    */
//  bit
//  0     1     2     3       each byte: msb=leftmost pixel, lsb=rightmost pixel
    0x00, 0x00, 0x00, 0x00,
    0x00, 0x6C, 0x00, 0x00,
    0x6C, 0x92, 0x00, 0x00,
    0x7C, 0x82, 0x00, 0x00,
    0x38, 0x44, 0x00, 0x00,
    0x10, 0x28, 0x00, 0x00,
    0x00, 0x10, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00
};


#define  PALETTE_OFFSET_TILES    0
#define  PALETTE_OFFSET_SPRITES  16


void write_palette(uint8_t offset, const uint8_t *palette) {
    VDP_ADDRESS = offset;    // start at color 0
    VDP_ADDRESS = 0b11000000;
    uint8_t n = 16;
    while (n > 0) {
        VDP_DATA = *palette;
        palette++;
        n--;
    }
}


void write_vram(const uint8_t *src, uint16_t size, uint16_t vram_addr) {
    VDP_ADDRESS = (uint8_t) (vram_addr & 0x00FF);
    VDP_ADDRESS = 0b01000000 | ((uint8_t) ((vram_addr >> 8) & 0x3F));
    while (size > 0) {
        VDP_DATA = *src;
        src++;
        size--;
    }
}


void write_vram_2(const uint8_t *src, uint16_t size, uint16_t vram_addr) {
    VDP_ADDRESS = (uint8_t) (vram_addr & 0x00FF);
    VDP_ADDRESS = 0b01000000 | ((uint8_t) ((vram_addr >> 8) & 0x3F));
    while (size > 0) {
        VDP_DATA = *src;
        VDP_DATA = 0;
        src++;
        size--;
    }
}


typedef struct {
    const uint8_t *first_byte;
    const uint8_t *next_byte;
    uint16_t wait_counter;
} vgm_info;


void vgm_init(vgm_info *vgm, const uint8_t *file_data) {
    uint32_t version = *((uint32_t *) (file_data + 0x08));
    if (version < 0x00000150)
        vgm->next_byte = file_data + 0x40;
    else {
        uint32_t data_offset = *((uint32_t *) (file_data + 0x34));
        if (data_offset == 0x0000000C)
            vgm->next_byte = file_data + 0x40;
        else
            vgm->next_byte = file_data + data_offset + 0x34;
    }
    vgm->first_byte = vgm->next_byte;
    vgm->wait_counter = 0;
}


void vgm_tick(vgm_info *vgm) {
    if (vgm->wait_counter > 0) {
        vgm->wait_counter--;
        return;
    }
    const uint8_t *p = vgm->next_byte;
    if (*p == 0x50) {
        vgm->wait_counter = 0;
        while (*p == 0x50) {
            p++;
            PSG = *p;
            p++;
        }
    }
    while ((*p == 0x61) || (*p == 0x62) || (*p == 0x63)) {
        if ((*p == 0x62) || (*p == 0x63)) {
            vgm->wait_counter++;
            p++;
        }
        else {
            p++;
            uint16_t num_samples = *((uint16_t *) p);
            p += 2;
            //vgm->wait_counter += num_samples / 882;    // convert samples to ticks (requires stdlib because of integer division)
            //
            // aproximate num_samples / 882 with num_samples / 768 = num_samples / (256 * 3)
            // (1 / 3) * 65536 = 21845, so:
            // num_samples / 768 = ((num_samples / 256) * 21845) / 65536
            // num_samples / 768 = ((num_samples >> 8) * 21845) >> 16
            // num_samples / 768 = (ns * 21845) >> 24
            // num_samples / 768 = (ns * (16384 + 4096 + 512 + 256 + 32 + 4)) >> 24
            // num_samples / 768 = (ns * (16384 + 4096 + 512 + 256 + 32 + 4)) >> 24
            // num_samples / 768 = ((ns << 14) + (ns << 12) + (ns << 8) + (ns << 5) + (ns << 2) + ns) >> 24
            uint32_t aux = num_samples;
            aux = ((aux << 14) + (aux << 12) + (aux << 8) + (aux << 5) + (aux << 2)) >> 24;
            vgm->wait_counter = aux;
        }
    }
    while ((*p & 0x70) == 0x70)    // wait n + 1 samples, 1 tick = 882 samples, so ignore 0x7X commands
        p++;
    if (*p == 0x66) {
        vgm->wait_counter = 0;
        vgm->next_byte = vgm->first_byte;
    }
    else
        vgm->next_byte = p;
}


uint8_t sprite_x;
uint8_t sprite_y;
int8_t sprite_x_inc;
int8_t sprite_y_inc;
vgm_info vgm;


void vblankISR(void) __critical __interrupt(0) {
    uint8_t vdp_status = VDP_ADDRESS;
    // apply (sprite_x, sprite_y) coordinates to sprite vram
    VDP_ADDRESS = 0;
    VDP_ADDRESS = 0b01000000 | 0x3F;
    VDP_DATA = sprite_y;
    VDP_ADDRESS = 0x80;
    VDP_ADDRESS = 0b01000000 | 0x3F;
    VDP_DATA = sprite_x;
    // update (sprite_x, sprite_y)
    sprite_x += sprite_x_inc;
    if (sprite_x == (256 - 8))
        sprite_x_inc = -1;
    else if (sprite_x == 0)
        sprite_x_inc = 1;
    sprite_y += sprite_y_inc;
    if (sprite_y == (192 - 8))
        sprite_y_inc = -1;
    else if (sprite_y == 0)
        sprite_y_inc = 1;
    // update music
    vgm_tick(&vgm);
}


void nmISR(void) __critical __interrupt {
}


void main(void) {
    __asm__ ("di");
    // draw background image
    
    // draw sprite
    write_palette(PALETTE_OFFSET_SPRITES, SPRITE_PALETTE);
    VDP_ADDRESS = 0;      // border color = color 0 of sprite palette
    VDP_ADDRESS = 0x87;
    write_vram(SPRITE_PATTERN, 4 * 8, 0x2000);
    // locate sprite
    sprite_x = 80;
    sprite_y = 80;
    sprite_x_inc = 1;
    sprite_y_inc = 1;
    VDP_ADDRESS = (uint8_t) (0x3F00 & 0x00FF);
    VDP_ADDRESS = 0b01000000 | ((uint8_t) ((0x3F00 >> 8) & 0x3F));
    VDP_DATA = sprite_y;
    VDP_DATA = 208;         // end of sprite list (sprite_y = 208)
    VDP_ADDRESS = (uint8_t) (0x3F80 & 0x00FF);
    VDP_ADDRESS = 0b01000000 | ((uint8_t) ((0x3F80 >> 8) & 0x3F));
    VDP_DATA = sprite_x;
    VDP_DATA = 0;           // tile 0 of sprite tiles
    // enable display
    VDP_ADDRESS = 0b01100000;
    VDP_ADDRESS = 0x81;
    // load music
    
    __asm__ ("ei");
    while (1)
        ;
}
