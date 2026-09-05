


//-----------    como optimizar el bucle out en c para sdcc ?  ---------------------------
/*
// 
// Para optimizar la transferencia de datos al VDP mediante el puerto OUT en SDCC sin usar librer�as, el compilador de C por s� solo no es suficiente. Un bucle for tradicional en C genera demasiado c�digo de control (incrementos, comparaciones y saltos) que desperdicia ciclos de reloj del Z80.Para lograr la m�xima velocidad, debes recurrir a ensamblador en l�nea (inline assembly) y aprovechar las instrucciones de bloque del Z80, espec�ficamente OTIR (Output IR) o el desenrollado de bucles (loop unrolling) con OUTI.
// Aqu� tienes las tres mejores estrategias para optimizarlo de mayor a menor flexibilidad:

/// Opci�n 1: El m�todo ultra r�pido (OTIR): La instrucci�n OTIR copia un bloque entero de memoria al puerto del VDP en un solo comando de ensamblador. Decrementa autom�ticamente el registro B, incrementa HL y repite hasta que B llega a cero. Esta funci�n en C recibe un puntero a tus datos de p�xeles/tiles y cu�ntos bytes enviar:
void SMS_copyToVDP(const unsigned char *src, unsigned char size) {
    // Evitamos advertencias de SDCC forzando el uso de los par�metros
    src; size; 

    _asm
        ; El compilador SDCC pasa los par�metros en la pila (stack)
        ; o en registros seg�n las opciones, pero usando el puntero de marco (IX):
        ld  hl, #2              ; Desplazamiento para el puntero 'src'
        add hl, sp              ; HL apunta al argumento src
        ld  e, (hl)
        inc hl
        ld  d, (hl)             ; DE = direcci�n de 'src'
        
        ld  hl, #4
        add hl, sp
        ld  b, (hl)             ; B = 'size' (n�mero de bytes)

        ld  c, #0xBE            ; C = Puerto de datos del VDP (siempre 0xBE)
        
        ; Intercambiamos DE a HL porque OTIR requiere que el origen est� en HL
        ex  de, hl              
        
        ; Transferencia en bloque a m�xima velocidad de hardware
        otir                    
    _endasm;
}
/// Rendimiento: Cada byte tarda exactamente 21 ciclos del Z80 (mientras B != 0).Ventaja: Es extremadamente compacto y procesa cualquier cantidad de bytes (hasta 256).

/// Opci�n 2: El m�todo absoluto (Desenrollado con OUTI): Si vas a enviar un tama�o fijo y cr�tico (por ejemplo, exactamente un tile de 8 bytes o m�ltiplos de �l), OTIR pierde un poco de tiempo gestionando el bucle interno. Puedes usar OUTI repetidos seguidos (desenrollar el bucle) para batir el r�cord de velocidad.
void SMS_write8Bytes(const unsigned char *src) {
    src;
    _asm
        ld  hl, #2
        add hl, sp
        ld  e, (hl)
        inc hl
        ld  d, (hl)             ; DE = 'src'
        ex  de, hl              ; HL = 'src'
        
        ld  c, #0xBE            ; C = Puerto VDP
        
        ; Escribimos 8 bytes seguidos sin bucles
        outi ; 14 ciclos
        outi ; 14 ciclos
        outi ; 14 ciclos
        outi ; 14 ciclos
        outi ; 14 ciclos
        outi ; 14 ciclos
        outi ; 14 ciclos
        outi ; 14 ciclos
    _endasm;
}
Usa el c�digo con precauci�n.Rendimiento: Cada p�xel/byte tarda solo 14 ciclos del Z80. Ventaja: Es la forma m�s r�pida f�sicamente posible en un Z80 para enviar datos a un puerto de E/S.

/// Opci�n 3: Si necesitas quedarte estrictamente en C (SDCC): Si por alguna restricci�n de tu proyecto no puedes usar ensamblador inline, la forma de optimizar el c�digo C nativo para SDCC es reducir las variables globales, usar punteros locales y desenrollar manualmente:
// Versi�n optimizada en C puro
void SMS_writeTileC(const unsigned char *src) {
    // Declarar el puerto como vol�til evita optimizaciones agresivas err�neas
    __sfr __at (0xBE) VDP_DATA; 
    
    // Desenrollar el bucle a mano evita que SDCC cree variables de control
    VDP_DATA = *src++;
    VDP_DATA = *src++;
    VDP_DATA = *src++;
    VDP_DATA = *src++;
    VDP_DATA = *src++;
    VDP_DATA = *src++;
    VDP_DATA = *src++;
    VDP_DATA = *src++;
}
// Rendimiento: Generar� instrucciones tipo LD A, (HL) seguidas de OUT (0xBE), A. Esto toma aproximadamente 23-25 ciclos por byte. Sigue siendo mucho mejor que un bucle for, pero inferior a la opci�n 2.

// Espera a que comience el periodo de VBlank (60Hz en NTSC / 50Hz en PAL)
void SMS_waitForVBlank(void) {
    _asm
    vblank_loop:
        in a, (#0xBF)     ; Lee el registro de estado del VDP
        and #0x80         ; El bit 7 se pone a 1 cuando empieza el VBlank
        jr z, vblank_loop ; Si es 0, sigue esperando
    _endasm;
}

// MAIN POR PASOS:  
void main(void) {
    // 1. Inicializaci�n del sistema (Puertos, Paletas, etc.)
    inicializar_sistema();

    // 2. Bucle infinito del juego
    while (1) {
        // --------------------------------------------------
        //   PASO A: L�GICA DEL JUEGO (L�nea Activa - El VDP dibuja)
        //   Aqu� el VDP est� ocupado pintando la pantalla. 
        //   Aprovechamos para hacer c�lculos de CPU pesados. (~15 ms max.)
        //--------------------------------------------------
        leer_mandos();
        actualizar_posicion_jugador();
        comprobar_colisiones();
        
        // Preparamos los datos en RAM antes de enviarlos (no toques la VRAM a�n)
        preparar_buffer_de_tiles();
        
        //--------------------------------------------------
        //   PASO B: SINCRONIZACI�N
        //   Detenemos la CPU hasta que el VDP termine de dibujar.
        //   --------------------------------------------------
        SMS_waitForVBlank();

        // --------------------------------------------------
        //   PASO C: ACTUALIZACI�N GR�FICA (VBlank - Ventana Segura)
        //   �El VDP est� libre! Tienes ~5ms en PAL para enviar datos.
        //   Aqu� es donde usas las funciones optimizadas (OUTI/OTIR).
        //   --------------------------------------------------
        // Ejemplo: Enviamos un tile de 8 bytes usando el m�todo OUTI desenrollado
        SMS_setVDPAddress(0x4000);        // Direcci�n VRAM del patr�n
        SMS_write8Bytes(mi_buffer_ram);    // Copia ultra r�pida de RAM a VRAM
        
        // Actualizar posiciones de Sprites en la SAT (Sprite Attribute Table)
        actualizar_posicion_pantalla();
    }
}
*/

//------------------------------------------------------------------
#include <sdcc-lib.h>
#include <stdint.h>
#include <stdbool.h>
#include <newTypes.h>
#include <defines.h>

/** 
  * 1. Definici�n de la Estructura del Buffer  
  * Cada comando en nuestra cola necesita saber a qu� direcci�n de la VRAM ir y qu� datos escribir.  
  * Creamos un b�fer con un tama�o m�ximo (por ejemplo, capacidad para actualizar hasta 4 tiles por frame). */

#define BUFFER_MAX_ITEMS 4

// Estructura para un elemento de la cola (un tile de 8 bytes)
typedef struct {
    unsigned int vram_address;    // Direcci�n destino en VRAM (ej: 0x4000)
    unsigned char data[8];         // Los 8 bytes del patr�n del tile
} VRAMTask;

// Variables globales de la cola
VRAMTask vram_buffer[BUFFER_MAX_ITEMS];
unsigned char vram_buffer_count = 0; // Cu�ntas tareas hay pendientes

/** 2. Funci�n para a�adir tareas (Se usa en el Paso A)  
  * Cuando tu juego calcula que un p�xel o tile debe cambiar, llamas a esta funci�n.  
  * Es muy r�pida porque solo escribe en la RAM del sistema. */
void VRAM_queueTile(unsigned int vram_addr, const unsigned char *tile_data) {
    // Si el b�fer est� lleno, ignoramos la petici�n para evitar colgar la consola
    if (vram_buffer_count >= BUFFER_MAX_ITEMS) return;

    VRAMTask *task = &vram_buffer[vram_buffer_count];
    task->vram_address = vram_addr;
    
    // Copiamos los 8 bytes del tile al buffer RAM
    unsigned char i;
    for(i = 0; i < 8; i++) {
        task->data[i] = tile_data[i];
    }
    // quiz�s mejor con memcpy ?
    
    vram_buffer_count++;
}

/** 3. El Volcado Automatizado (Se usa en el Paso C)  
  * Esta funci�n procesa toda la cola. Utiliza comandos OUT optimizados.  
  * Al terminar, resetea el contador a 0 para el siguiente frame */
void VRAM_flushBuffer(void) {
    if (vram_buffer_count == 0) return;

    unsigned char i;
    for (i = 0; i < vram_buffer_count; i++) {
        VRAMTask *task = &vram_buffer[i];

        // 1. Configurar direcci�n de destino en el VDP
        unsigned int addr = task->vram_address;
        unsigned char addr_lo = addr & 0xFF;
        unsigned char addr_hi = (addr >> 8) & 0x3F;
        
        /*__asm
            ; Cargamos direcci�n en el puerto de control (0xBF)
            ld hl, #_VRAM_flushBuffer_task_65536_123 + 0 ; SDCC localiza el struct en RAM
            ; Nota: Para evitar l�os de punteros en ASM con SDCC,
            ; pasamos los par�metros calculados en C a registros usando ASM inline directo:
        __endasm;*/

        // Configuraci�n de direcci�n nativa r�pida
        //__sfr __at (0xBF) VDP_ADDRESS;
        //__sfr __at (0xBE) VDP_DATA;
        
        VDP_ADDRESS = addr_lo;
        VDP_ADDRESS = (addr_hi | 0x40); // Bit de escritura VRAM

        // 2. Volcado ultra r�pido de los 8 bytes usando desenrollado manual en C
        // SDCC convertir� esto en instrucciones 'OUT (0xBE), A' consecutivas
        unsigned char *d = task->data;
        VDP_DATA = *d++; VDP_DATA = *d++; VDP_DATA = *d++; VDP_DATA = *d++;
        VDP_DATA = *d++; VDP_DATA = *d++; VDP_DATA = *d++; VDP_DATA = *d++;
    }

    // Vaciar el b�fer para el pr�ximo frame
    vram_buffer_count = 0;
}

//------------------ MIO ------------------------------
/* PARA LOS TILESETS */
#define BUFFER_TILES_MAX_ITEMS 255

unsigned char vram_tiles_buffer[BUFFER_TILES_MAX_ITEMS];
unsigned char vram_tiles_buffer_count = 0; // Cu�ntas tareas hay pendientes

/** 2. Funci�n para a�adir tiles al tileset global (Se usa en el Paso A)  
  * Cuando tu juego calcula que un p�xel o tile debe cambiar, llamas a esta funci�n.  
  * Es muy r�pida porque solo escribe en la RAM del sistema.  
  * Necesita el array de tiles y el n�mero de elementos  
  * EN REALIDAD CONCATENA ARRAYS HASTA EL M�XIMO ADMITIDO */
void VRAM_queueTileset(const unsigned char *tiles, const unsigned int size) {
    // Si el b�fer est� lleno, ignoramos la petici�n para evitar colgar la consola
    if (vram_tiles_buffer_count >= BUFFER_TILES_MAX_ITEMS) return;
    
    // Copiamos los bytes del array de tiles al buffer RAM // quiz�s mejor con memcpy ?
    unsigned char i;
    for(i = 0; i < size; i++) {
        vram_tiles_buffer[vram_tiles_buffer_count + i] = tiles[i];
    }
    vram_tiles_buffer_count += size;
}

/* LO MISMO PARA LOS SPRITESETS */
#define BUFFER_SPRITES_MAX_ITEMS 255

unsigned char vram_sprites_buffer[BUFFER_SPRITES_MAX_ITEMS];
unsigned char vram_sprites_buffer_count = 0; // Cu�ntas tareas hay pendientes

/** 2. Funci�n para a�adir un sprite al spriteset global (Se usa en el Paso A) 
  * Cuando tu juego calcula que un sprite debe cambiar, llamas a esta funci�n.  
  * Es muy r�pida porque solo escribe en la RAM del sistema.  
  * Necesita el array de tiles y el n�mero de elementos  
  * EN REALIDAD CONCATENA ARRAYS HASTA EL M�XIMO ADMITIDO */
void VRAM_queueSpriteset(const unsigned char *tiles, const unsigned int size) {
    // Si el b�fer est� lleno, ignoramos la petici�n para evitar colgar la consola
    if (vram_sprites_buffer_count >= BUFFER_SPRITES_MAX_ITEMS) return;
    
    // Copiamos los bytes del array de tiles al buffer RAM // quiz�s mejor con memcpy ?
    unsigned char i;
    for(i = 0; i < size; i++) {
        vram_sprites_buffer[vram_sprites_buffer_count + i] = tiles[i];
    }
    vram_sprites_buffer_count += size;
}


/* AHORA PARA LA SAT */
#define BUFFER_SAT_MAX_ITEMS 255

unsigned char vram_sat_buffer[BUFFER_SAT_MAX_ITEMS];
unsigned char vram_sat_buffer_count = 0; // Cu�ntas tareas hay pendientes

/** 2. Funci�n para a�adir la posici�n de un sprite al array sat global (Se usa en el Paso A)  
  * Cuando tu juego calcula que la posici�n o el index de un sprite debe cambiar, llamas a esta funci�n.  
  * Es muy r�pida porque solo escribe en la RAM del sistema.  
  * Necesita las posiciones y el �ndice del tile  */
void VRAM_queueSAT(const unsigned char x, const unsigned char y, const unsigned char index) {
    // Si el b�fer est� lleno, ignoramos la petici�n para evitar colgar la consola
    if (vram_sat_buffer_count >= BUFFER_SAT_MAX_ITEMS) return;
    
    // establecemos posici�n y n�mero de tile
    vram_sat_buffer[vram_sat_buffer_count] = y;
    vram_sat_buffer[vram_sat_buffer_count + 1] = 0xD0; //FIN (208)
    vram_sat_buffer[vram_sat_buffer_count + 80] = x;
    vram_sat_buffer[vram_sat_buffer_count + 80 + 1] = index;
    vram_sat_buffer_count++;
}

//----------- OTRA SAT (RAM) --------------
// La SAT en la Master System ocupa 2 bloques en la VRAM (normalmente desde 0x3F00)
// Bloque 1: 64 bytes para las posiciones Y de los sprites
// Bloque 2: 128 bytes para las posiciones X y el �ndice del Tile (pero solo se usan los primeros 64 de cada uno)
// Para optimizar el volcado r�pido, guardamos un espejo ordenado en RAM de 64 bytes para Y, y 128 bytes para X/Tile.

#define NUM_MAX_SPRITES 64
//const unsigned char sizeAreaY = NUM_MAX_SPRITES;
//const unsigned char sizeAreaXTile = NUM_MAX_SPRITES * 2;
#define sizeAreaY NUM_MAX_SPRITES
#define sizeAreaXTile NUM_MAX_SPRITES * 2
/*unsigned char buffer_sat_y[64];
unsigned char buffer_sat_x_tile[128];*/
unsigned char buffer_sat_y_x_tile[sizeAreaY * 2 + sizeAreaXTile];
// Variable para indicar si los sprites se han movido y hace falta actualizar la SAT
unsigned char sat_needs_update = 0;
static unsigned char spr_count = 0; // max 64
unsigned char spr_tiles_count = 0;

/** Actualizamos la sat-ram con un dato de 'y' en un índice determinado (cuidado, el siguiente index será 208) */
void sprite_SATRAM_addY(unsigned char index, unsigned char y) {
    if (index >= NUM_MAX_SPRITES){ return; }
    // Guardamos la posición Y (64 bytes)
    buffer_sat_y_x_tile[index] = y;
    // _VRAM_SPRITE_END // 208
    if (index < (sizeAreaY - 1)){ buffer_sat_y_x_tile[index + 1] = 0xD0; }
    // Avisamos al buffer de que hay cambios pendientes para el VBlank
    sat_needs_update = 1;
}

/** Actualizamos la sat-ram con un dato de 'x' y de 'tile' en un índice determinado (de la zona X) */
void sprite_SATRAM_addX(unsigned char index, unsigned char x, unsigned char tile) {
    if (index >= NUM_MAX_SPRITES){ return; }
    // Guardamos la posicion X y el Tile desplazando su posición 64 lugares
    unsigned char index_x_tile = sizeAreaY * 2 + index; //(index << 1) + sizeAreaY; //(index << 1); // index * 2 + 64
    buffer_sat_y_x_tile[index_x_tile] = x;
    buffer_sat_y_x_tile[index_x_tile + 1] = tile;
    // Avisamos al buffer de que hay cambios pendientes para el VBlank
    sat_needs_update = 1;
}

// 2. Funci�n para Modificar un Sprite (Se usa en el Paso A) En lugar de escribir al VDP, creas una funci�n en C que manipule el espejo en la memoria RAM del Z80  
// Ponemos todos los sprites inicialmente fuera de la pantalla (Y = 240 los esconde)
/** Actualiza la SAT en la RAM (buffer_sat_y_x_tile) con los datos del nuevo sprite de forma consecutiva,
 * El 'id' máximo del sprite = 64, máximo 64 sprites monotile. Hace lo mismo que las dos anteriores
 * 'sprite_SATRAM_addX' y 'sprite_SATRAM_addY'
void sprite_SATRAM_Update(sGraphic *spr, unsigned char x, unsigned char y, unsigned char tile) {
    //if (index >= 64) { return; }
    if (spr_count >= 64){ return; }
    spr->id = spr_count;
    spr_count++;
    // Guardamos la posici�n Y (64 bytes)
    buffer_sat_y_x_tile[spr->id] = y;
    buffer_sat_y_x_tile[spr->id + 1] = 0xD0; // _VRAM_SPRITE_END // 208

    // En el segundo bloque, los datos van emparejados: [X, Tile, X, Tile...]
    unsigned char index_x_tile = (spr->id << 1) + sizeAreaY; //(index << 1); // index * 2 + 64
    buffer_sat_y_x_tile[index_x_tile] = x;
    buffer_sat_y_x_tile[index_x_tile + 1] = tile;

    spr->dirty = true; // lo marca como redibujable hasta que se guarde en la SAT
    // Avisamos al buffer de que hay cambios pendientes para el VBlank
    sat_needs_update = 1;
} */

/** Actualiza la SAT del VDP desde la SAT en la RAM (buffer_sat_y_x_tile).  
 * Llamar una sola vez en el 'draw', de una sola pasada anota todos los sprites */
void sprite_SATVDP_Update(void);
void sprite_SATVDP_Update(void){
    if(!sat_needs_update){ return; } // si no necesita actualizarse, sale
    // Posición Y (con 208 al final)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_Y & 0x00FF);  // spr->id;  // 0 + row; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_Y >> 8) & 0x3F));  // 0x3f;// // 0x40
    unsigned char i = 0;
    for(i = 0; i < spr_tiles_count; i++){
        VDP_DATA = buffer_sat_y_x_tile[i];
    }
    //if (spr_tiles_count < (sizeAreaY - 1)){ VDP_DATA = _VRAM_SPRITE_END; } // end of sprite list (sprite_y = 208)

    // Posición X e Índice: Base 0x3F80 (\(0x7F80\) para escribir)
    VDP_ADDRESS = (uint8_t)(_VRAM_SPRITE_INFO_X & 0x00FF);     // spr->id;       // 0x80 + col; //
    VDP_ADDRESS = 0b01000000 | ((uint8_t)((_VRAM_SPRITE_INFO_X >> 8) & 0x3F)); // 0x3f; // 0b01000011;//
    //for (i = sizeAreaY; i < (sizeAreaY + spr_tiles_count * 2); i += 2){
    for (i = 0; i < spr_tiles_count; i += 2){
        VDP_DATA = buffer_sat_y_x_tile[sizeAreaY * 2 + i]; // x
        VDP_DATA = buffer_sat_y_x_tile[sizeAreaY * 2 + i + 1]; // tile
    }
    // Avisamos al buffer de que ya hemos procesado los cambios del VBlank
    sat_needs_update = 0;
}

/** Añade un sprite al array global de SAT-RAM. Se basa en su array "img".  
 * Pasar -1 al resto de parámetros si no se quieren actualizar las propiedades.  
 * El array de tiles del sprite tiene que estar previamente definido y cargado en VRAM
*/
void spriteDefine(sGraphic *spr, int8_t id, int8_t posX, int8_t posY){
    if (spr_count >= NUM_MAX_SPRITES || spr_tiles_count >= NUM_MAX_SPRITES){ return; }
    if(id > -1){ spr->id = id; }else{ spr->id = spr_count; }
    if(posX > -1){ spr->x = posX; }
    if(posY > -1){ spr->y = posY; }
    sprite_SATRAM_addY(spr_tiles_count, spr->y); //, spr->y);
    sprite_SATRAM_addX(spr_tiles_count, spr->x, spr->ani[spr->i]);
    spr_tiles_count++;
    spr_count++;
    spr->dirty = true; // lo marca como redibujable hasta que se guarde en la SAT
    // Avisamos al buffer de que hay cambios pendientes para el VBlank
    sat_needs_update = 1;
}

/** Añade un sprite al array global de SAT-RAM. Se basa en su array "img".  
 * Pasar -1 al resto de parámetros si no se quieren actualizar las propiedades.  
 * El array de tiles del sprite tiene que estar previamente definido y cargado en VRAM
*/
void spriteMultiDefine(sGraphic *spr, int8_t id, int8_t posX, int8_t posY){
    if (spr_count >= NUM_MAX_SPRITES || spr_tiles_count >= NUM_MAX_SPRITES){ return; }
    if(id > -1){ spr->id = id; }else{ spr->id = spr_count; }
    if(posX > -1){ spr->x = posX; }
    if(posY > -1){ spr->y = posY; }
    uint8_t row = 0;
    uint8_t col = 0;
    uint8_t index = 0;
    for (row = 0; row < spr->h; row++){
        for (col = 0; col < spr->w; col++){
            if (spr_tiles_count >= NUM_MAX_SPRITES){ break; }
            index = (row * spr->w) + col;
            //sprite_SATRAM_addY(index + spr->id, spr->y + (row * 8));//, spr->y);
            //sprite_SATRAM_addX(index + spr->id, spr->x + (col * 8), spr->img[index]);
            sprite_SATRAM_addY(spr_tiles_count, spr->y + (row * 8)); //, spr->y);
            sprite_SATRAM_addX(spr_tiles_count, spr->x + (col * 8), spr->img[index]);
            spr_tiles_count++;
        }
    }
    spr_count++;
    spr->dirty = true; // lo marca como redibujable hasta que se guarde en la SAT
    // Avisamos al buffer de que hay cambios pendientes para el VBlank
    sat_needs_update = 1;
}