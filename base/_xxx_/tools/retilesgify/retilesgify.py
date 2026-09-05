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

def remapear_fila_bitplanes(b0, b1, b2, b3, tabla_mapeo):
    # Inicializar los 4 nuevos bytes de la fila
    nuevo_b0, nuevo_b1, nuevo_b2, nuevo_b3 = 0, 0, 0, 0
    
    # Procesar cada uno de los 8 píxeles de la fila (de izquierda a derecha)
    for x in range(8):
        shift = 7 - x
        
        # 1. Extraer los bits individuales de cada bitplane original
        bit0 = (b0 >> shift) & 1
        bit1 = (b1 >> shift) & 1
        bit2 = (b2 >> shift) & 1
        bit3 = (b3 >> shift) & 1
        
        # 2. Reconstruir el índice de color original (0-15)
        indice_viejo = (bit3 << 3) | (bit2 << 2) | (bit1 << 1) | bit0
        
        # 3. Obtener el nuevo índice de la tabla de conversión
        indice_nuevo = tabla_mapeo.get(indice_viejo, indice_viejo)
        
        # 4. Descomponer el nuevo índice en sus nuevos componentes de bitplane
        n0 = indice_nuevo & 1
        n1 = (indice_nuevo >> 1) & 1
        n2 = (indice_nuevo >> 2) & 1
        n3 = (indice_nuevo >> 3) & 1
        
        # 5. Insertar los bits en los nuevos bytes de la fila
        nuevo_b0 |= (n0 << shift)
        nuevo_b1 |= (n1 << shift)
        nuevo_b2 |= (n2 << shift)
        nuevo_b3 |= (n3 << shift)
        
    return nuevo_b0, nuevo_b1, nuevo_b2, nuevo_b3

# EJEMPLO DE USO:
# Diccionario de conversión: llave = índice viejo, valor = índice nuevo
# Los índices no especificados mantendrán su valor original
tabla_indices = {
    1: 2,   # Lo que era color 1 se vuelve color 2
    3: 6,   # Lo que era color 3 se vuelve color 6
    15: 0   # Lo que era color 15 se vuelve color 0 (transparente)
}

# array de tilesets
_ball_til[_ball_size] = {
    # Tile 0
    0x00, 0x00, 0x00, 0x00, 
    0x3c, 0x00, 0x00, 0x00, 
    0x6e, 0x1c, 0x00, 0x00, 
    0x4e, 0x3c, 0x00, 0x00, 
    0x42, 0x3c, 0x00, 0x00, 
    0x66, 0x18, 0x00, 0x00, 
    0x3c, 0x00, 0x00, 0x00, 
    0x00, 0x00, 0x00, 0x00, 
    # Tile 1
    0x3c, 0x00, 0x00, 0x00, 
    0x7e, 0x00, 0x00, 0x00, 
    0xef, 0x1c, 0x00, 0x00, 
    0xcf, 0x3c, 0x00, 0x00, 
    0xc3, 0x3c, 0x00, 0x00, 
    0xe7, 0x18, 0x00, 0x00, 
    0x7e, 0x00, 0x00, 0x00, 
    0x3c, 0x00, 0x00, 0x00, 
    # Tile 2
    0x00, 0x00, 0x00, 0x00, 
    0x00, 0x3c, 0x00, 0x00, 
    0x18, 0x66, 0x00, 0x00, 
    0x3c, 0x5a, 0x00, 0x00, 
    0x3c, 0x5a, 0x00, 0x00, 
    0x18, 0x66, 0x00, 0x00, 
    0x00, 0x3c, 0x00, 0x00, 
    0x00, 0x00, 0x00, 0x00
}

# Ejemplo con una fila cuyos píxeles originales daban índices mezclados
b0_orig, b1_orig, b2_orig, b3_orig = 0x55, 0x33, 0x0F, 0x00 
n_b0, n_b1, n_b2, n_b3 = remapear_fila_bitplanes(b0_orig, b1_orig, b2_orig, b3_orig, tabla_indices)

print(f"Fila modificada: B0=0x{n_b0:02X}, B1=0x{n_b1:02X}, B2=0x{n_b2:02X}, B3=0x{n_b3:02X}")