/**
 * @file const.h
 * @brief Cabecera para almacenar definiciones, constantes y objetos (struct) para este juego en particular.
 * @details Aquí podemos definir algunos objetos que utilice nuestro juego, variables, constantes, ...
 * @author GuerraTron26
 * @date 2026
 * @version 1.0
 */

#ifndef __CONST_H__
#define __CONST_H__

#include <defines.h>

//GRAPHICS
/** Sprite "sBall" */
sGraphic sMiniheart;
/** Límites rectangulares de "sBall" */
oMove oMiniheartMove;

/** Sprite "sLogo" */
sGraphic sLogo;
/** Límites rectangulares de "sLogo" */
oMove oLogo;
/** Permite saltos verticales de "sLogo" */
sJumpV oLogoJumpV;

#endif