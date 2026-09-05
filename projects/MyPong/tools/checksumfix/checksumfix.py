import sys

# repara el checksum de un archivo binario "sms"
def fix_sms_checksum(rom_path):
    with open(rom_path, "rb") as f:
        rom_data = bytearray(f.read())
    
    rom_size = len(rom_data)
    
    # Asegurar que la ROM tiene el tamaño mínimo de una página (32KB)
    if rom_size < 0x8000:
        print(f"Error: La ROM es demasiado pequeñaa ({rom_size} bytes). Mínimo 32KB.")
        sys.exit(1)
        
    # 1. Limpiar cualquier checksum anterior en 0x7FFA y 0x7FFB
    rom_data[0x7FFA] = 0x00
    rom_data[0x7FFB] = 0x00

    # 2. Calcular la suma del rango de la primera página (0x0000 a 0x7FEF)
    checksum = sum(rom_data[0:0x7FF0])
    
    # 3. Si la ROM es mayor de 32KB, sumar el resto de bancos íntegros
    if rom_size > 0x8000:
        checksum += sum(rom_data[0x8000:])
        
    # 4. Limitar el resultado a un entero de 16 bits
    checksum = checksum & 0xFFFF
    
    # 5. Inyectar el nuevo Checksum (Little Endian)
    rom_data[0x7FFA] = checksum & 0xFF        # Byte bajo
    rom_data[0x7FFB] = (checksum >> 8) & 0xFF  # Byte alto
    
    # Guardar los cambios en el archivo .sms
    with open(rom_path, "wb") as f:
        f.write(rom_data)
        
    print(f"¡Checksum reparado con éxito! Valor: 0x{checksum:04X}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Uso: python fix_checksum.py juego.sms")
    else:
        fix_sms_checksum(sys.argv[1])