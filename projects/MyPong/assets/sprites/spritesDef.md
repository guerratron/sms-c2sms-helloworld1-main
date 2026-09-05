
# Sprites Definitions
Son archivos de definiciones de gráficos para utilizar en el código principal de la Master-System.  
En estos archivos vienen representados una serie de arrays, constantes y alguna función, que basándose en el principal "Tileset de planosDeBits" pueden utilizarse para construir distintos objetos gráficos: imágenes, fondos, sprites (monotile y multitile), animaciones, ..
La idea es formar una serie de arrays para representar de forma distinta un array de tiles.
Aplicándolos a un sprite podríamos conseguir un sprite monotile o multitile, incluso animado.
En función de lo que se quiera conseguir se utilizarían unos arrays u otros y funciones específicas
para esto en el "main.c" como: moveDef(), load_sprite(), toTilesgifyDefineUpdate(), o sus versiones 
animadas como toAniIndex(), toAniPos(), ...
// Ej:
```c
    #include <ball_def.h>
    load_sprite((sGraphic *) &sBall, (uint16_t) vram_addr);
    toTilesgifyDefineUpdate((sGraphic *) &sBall, -1, -1, -1);
```
# Novedad
En esta nueva versión los archivos de definiciones utilizan un objeto gráfico **sGraphic** que es una estructura que alberga las constantes y arrays vistos anteriormente.  
Estos objetos gráficos deben crearse en el "main" y pasársele a una función integrada para inicializar valores del objeto gráfico, ya que daba problemas con este compilador "SDCC" la "inicialización directa del struct".  
El nombre de esta función debe seguir unas reglas rígidas para poder recordar y acceder a ella desde el código principal, así en todos los archivos de definiciones la llamo: 
``` underscore + camelcase(filename)  ``` , por ejemplo en el archivo **ball_def.h**: ``` _ballDef(..) ``` 

Hay que llamarla antes de utilizar el objeto gráfico pasado.

Ejemplos: 
```c
    #include <ball_def.h>
    sGraphic sBall;// Sprite "sBall"
    oMove oBallMove;// Límites rectangulares de "sBall"
    moveDef(&oBallMove, 1, 0, (_SCREEN_WIDTH + 1 - (8*1)), 1, 0, (_SCREEN_HEIGHT - (8*1)));
    _ballDef(&sBall, 1, 20, 20, 32, 40, 40, &oBallMove);
    load_sprite(&sBall2, address_til); //&sBall
    ..
    toTilesgifyDefineUpdate(&sBall, 2, 40, 40);
    toAniDefine(&sBall, -1, -1, -1);
    ..
    toAniIndex(&sBall, -1);
    toAniPos(&sBall2, -1, -1);
```