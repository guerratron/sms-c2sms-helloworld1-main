
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

Hay que llamarla antes de utilizar el objeto gráfico pasado ya que lo inicializa.

Ejemplos: 
```c
    #include <ball_def.h>
    ..
    // INIT
    sGraphic sBall;// Sprite "sBall"
    oMove oBallMove;// Límites rectangulares de "sBall"
    sJumpV oBallJumpV; //Permite saltos verticales de "sBall"
    // Configuramos el objeto de movimiento de esta bola
    //void moveDef(oMove *oM, int8_t xIncr, uint8_t xMin, uint8_t xMax, int8_t yIncr, uint8_t yMin, uint8_t yMax)
    moveDef(&oBallMove, 1, 0, (_SCREEN_WIDTH + 1 - (8*1)), 1, 0, (_SCREEN_HEIGHT - (8*1)));
    // Inicializamos todos los campos y arrays de esta bola
    // sGraphic *_miniheartDef(sGraphic *sG, const uint8_t id, const uint8_t xAddress, const uint8_t yAddress, const uint16_t prev_tiles, const uint8_t x, const uint8_t y, oMove *oM, sJumpV *sJ)
    _ballDef(&sBall, 1, 20, 20, 32, 40, 40, &oBallMove, &oBallJumpV);
    load_sprite(&sBall, address_til); //&sBall
    ..
    // Cargamos en memoria de video la bola (normalmente en el "init()", pero puede también en "draw()")
    toTilesgifyDefineUpdate(&sBall, 2, 40, 40);
    toAniDefine(&sBall, -1, -1, -1);
    ..
    // DRAW
    // Modificamos índices o posiciones en la memoria de video de la bola (para utilizar en el "draw()")
    toAniIndex(&sBall, -1);
    toAniPos(&sBall, -1, -1);
    ..
    // UPDATE
    // Normalmente en el "update()"
    moveWith(&sBall, true); // actualiza la posición de la bola
    // salto de la bolita al pulsar dos botones a la vez
    if (isPress(B1) && isPress(B12)){ trigger_jumpV(&sBall); }
    update_jumpV(&sBall);
    ..
    // otras como "isColission(..), delay(..), playBeep(..), ..."
```

## Proceso
En general el proceso a seguir sería copiar un archivo base (como "miniheart_def.h"), cambiarle el nombre y modificar los tiles y los tamaños de los "#define".  
Hay que cambiar nombres de constantes, arrays y la función principal empleando nombres únicos. Para esto seguir la regla especificada al inicio.  

En teoría ya podría realizarse un "#include" y utilizar su función principal "_[NOMBRE]Def(..)" para la inicialización.

> Ver la documentación para una descripción más detallada
