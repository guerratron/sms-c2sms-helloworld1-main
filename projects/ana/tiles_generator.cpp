

#include <cstdint>
#include <iostream>
#include <iomanip>
#include "ana_sms_128x120x16.h"


using namespace std;

void generate_palette() {
    cout << "const uint8_t palette[16] = {" << endl << "    ";
    for (int i = 0; i < 16; i++) {
        if (i > 0)
            cout << ", ";
        uint8_t r = header_data_cmap[i][0];
        uint8_t g = header_data_cmap[i][1];
        uint8_t b = header_data_cmap[i][2];
        uint8_t rgb = ((r >> 6) & 0b0000'0011) | ((g >> 4) & 0b0000'1100) | ((b >> 2) & 0b0011'0000);
        cout << "0x" << hex << setw(2) << setfill('0') << ((int) rgb);
    }
    cout << endl << "};" << endl << endl << endl;
}


void generate_tile_map() {
    cout << "const uint8_t tile_map[" << dec << (32 * 24) << "] = {" << endl;
    // 4 rows empty
    for (int i = 0; i < 4; i++)
        cout << "    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00," << endl;
    // 15 rows height (120 px height)
    int tile_index = 1;
    for (int i = 0; i < 15; i++) {
        cout <<"    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00";
        for (int j = 0; j < 16; j++, tile_index++)
            cout << ", 0x" << hex << setw(2) << setfill('0') << ((int) tile_index);
        cout <<", 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00," << endl;
    }
    // 5 rows empty
    for (int i = 0; i < 5; i++) {
        cout << "    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,";
        if (i < 4)
            cout << ",";
        cout << endl;
    }
    cout << "};" << endl << endl << endl;
}


void generate_tile_patterns() {
    cout << "const uint8_t tile_patterns[" << dec << ((240 + 1) * 4 * 8) << "] = {" << endl;
    // force tile 0 to be all zeros
    cout << "    0x00, 0x00, 0x00, 0x00,     // tile 0 (screen black background)" << endl;
    cout << "    0x00, 0x00, 0x00, 0x00," << endl;
    cout << "    0x00, 0x00, 0x00, 0x00," << endl;
    cout << "    0x00, 0x00, 0x00, 0x00," << endl;
    cout << "    0x00, 0x00, 0x00, 0x00," << endl;
    cout << "    0x00, 0x00, 0x00, 0x00," << endl;
    cout << "    0x00, 0x00, 0x00, 0x00," << endl;
    cout << "    0x00, 0x00, 0x00, 0x00," << endl;
    // start with tile 1
    uint16_t tile_index = 1;
    for (int src_y_offset = 0; src_y_offset < 120; src_y_offset += 8) {
        for (int src_x_offset = 0; src_x_offset < 128; src_x_offset += 8, tile_index++) {
            for (int tile_row = 0; tile_row < 8; tile_row++) {
                cout << "    ";
                for (int tile_byte_index = 0; tile_byte_index < 4; tile_byte_index++) {
                    uint8_t tile_byte = 0;
                    for (int tile_byte_bit_index = 0; tile_byte_bit_index < 8; tile_byte_bit_index++) {
                        uint8_t px = header_data[((src_y_offset + tile_row) * 128) + (src_x_offset + tile_byte_bit_index)];   // 0..15
                        uint8_t bit = (px >> tile_byte_index) & 1;
                        tile_byte |= bit << (7 - tile_byte_bit_index);
                    }
                    cout << "0x" << hex << setw(2) << setfill('0') << ((int) tile_byte) << ", ";
                }
                if (tile_row == 0)
                    cout << "    // tile " << dec << tile_index << " at (" << src_x_offset << ", " << src_y_offset << ")";
                cout << endl;
            }
        }
    }
    cout << "};" << endl;
}


int main() {
    generate_palette();
    generate_tile_map();
    generate_tile_patterns();
    return 0;
}
