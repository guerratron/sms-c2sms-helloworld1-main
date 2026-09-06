/**
 * @file newTypes.h
 * @brief Cabecera para definir nuevos tipos.
 * @details Define algunos tipos nuevos por comodidad de uso, no son necesarios si incluimos otras librerías como "stdint.h" o "stdbool.h" pero pueden ser útiles.
 * @author GuerraTron26
 * @date 2026
 * @version 1.0
 */

#ifndef  __NEWTYPES_H__
#define  __NEWTYPES_H__

#ifndef  NULL
#define  NULL  ((void *) 0)
#endif

// boolean
#ifndef boolean
typedef enum {FALSE = 0, TRUE = 1} boolean;
#endif

// unsigned integer
#ifndef uint
typedef unsigned int uint;
#endif

// unsigned char
#ifndef byte
typedef unsigned char byte;
#endif

#endif