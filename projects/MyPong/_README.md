> -----------------------------------------------------------------------------------------------------
> Generado con 'C2SMS-v2.0' (Batch File), by GuerraTron26
>   Esto es un proyecto base para "SMS" (Master System) desde "C" (o "asm"), lo compila 
>           y limpia, preparado para añadir código al archivo "c" y recompilar con el "compile.bat" creado.  
>   Author:  Juan José Guerra Haba - <dinertron@gmail.com> - May, 2026  
>   Web:     https://guerratron.github.io/  
>   Categoria: Master System, 8 bits console  
>   License: Free BSD. & Open GPL v.3. Keep credit, please.  
>   Versión: 2.0.0   
>   File:    compile.bat -> src/project_name     Main Class:  N/A :: function main(void)
>   
> ----------------------------------------------------------------------------------------------------

# INTRO v2.0 ![Logo](./logo.png "Logo")
**"Proyectos de C (o ASM) a SMS"**. Incluye unos ``` Makefile ``` preparados para trabajar con una estructura de 
carpetas conveniente; una vez creado el proyecto ejecutar ``` > make ```, o para Windows simplemente ejecutar el ``` compile.bat ```.  
O si se desea utilizar **VSC** (Visual Script Code), también viene preparado para abrirlo como proyecto. 

> Este proyecto se ha construido utilizando ejemplos del fantástico blog 
> de [Avelino Herrera](https://avelinoherrera.com/) (Muchas Gracias artista !) 

<p style="background: yellow; color: red;"> ATENCIÓN: No utiliza frameworks o librerías externas, ni "CrossZGB" ni siquiera "SMSLib".</p> 

En esta nueva versión se ha mejorado la estructuración de los assets gráficos y una forma para compartir una paleta común. 
Para más detalle observar "ball_def.h" y utilizar como plantilla para nuevos gráficos.  
También se ha desarrollado un administrador de sprites "spritesManager.h" con algunas funciones de utilidad para cargarlos y representarlos, así como para simular pequeñas animaciones.

En el código principal pueden observarse ejemplos en la función "init()" y en "update()" y "draw()".

## DESCRIPCIÓN
Lo dicho, sólo ejecutando la orden **make** este se encarga de generar todos los binarios necesarios para generar una Rom-SMS válida. Sigue un proceso de *ensamblado/compilación* utilizando el compilador **SDCC**. 

El proyecto viene organizado en una estructura aceptable de carpetas para separar código, librerías, binarios, assets, ...

También se habrá creado un script de compilación "compile.bat" que trabaja con el **Makefile** para realizar 
todo el trabajo de compilación de **c** a **sms** (o bien utilizar el comando **make**).

Así mismo se aporta una carpeta aparte (**ASM2SMS**) con un Makefile independiente por si se quiere insertar en 
ella el ``` *.asm ``` generado, ajustarlo al máximo y luego recompilarlo. (Más bien orientado a programadores en **ensamblador**)

Ahora a probarlo en un emulador o incluso en un cartucho flash *(los afortunados que lo posean)*

> el proyecto contendrá el código mínimo sobre el que construir el projecto siguiendo algún tutorial.  
> Si se prueba en un emulador se mostrará un minijuego homenaje a "Pong" con tres pantallas "inicio, juego y gameover", todo esto con música (Arkanoid) de fondo..
> Es una pequeña demostración de la carga de gráficos, creación de sprites multitile, sprites con movimiento, detección de colisiones, botones del pad, música, sonidos, 
y cambios de pantallas de juego. Todo esto en sólo 32 Kb !

## ESTRUCTURA
El código se ha simplificado al máximo para utilizar como "template" el archivo del proyecto principal ".c"  
Este ya se encarga de importar los archivos de cabecera genéricos para que funcione todo (Respetar los imports).

El archivo sobre el que trabajar se ha estructurado en un formato común donde se han creado 4 funciones comunmente utilizadas en cualquier videojuego:
- init(): Donde se sitúan obciones de configuración iniciales (se llama únicamente al principio).
- draw(): Podemos insertar aquí de forma segura modificación o repintado de assets gráficos o música: tiles, sprites, backgrounds, .. Esto se llamará una vez por cada **frame** (sincronismo vertical)
- update(): Modificaciones y cálculos generales. NO acciones de repintado. Una vez cada **frame**
- update_fast(): Cálculos frecuentes y acciones que no sean costosas. Se ejecuta una vez por ciclo de **cpu**. Esta función se encargará de actualizar el tiempo global **_DELTA**, útil para algunos cálculos de sincronización.
- main(): Se encarga de ejecutar el ciclo de vida, esto es, la inicialización y la actualización rápida *(update_fast)*.

## REQUISITOS
Independientemente de que está orientado a entornos **Windows** (*c2sms.bat*) podría fácilmente portarse a otros.  
Y evidentemente se necesita tener instalada la orden ``` make ``` y el compilador utilizado ``` SDCC ```  
No es obligatorio, pero sería cómodo si se tiene instalado **VSC** para la modificación del código fuente.

Por supuesto **SDCC** debe estar instalado en su sistema y sus rutas añadidas a algunos archivos como *"c_cpp_properties.json"*.

## USO RÁPIDO
Después de modificar el código **C** ir a la ventana de comandos y ...  

``` > make ``` o ``` > make valid ```   

... voilâ ! ya tenemos nuestro archivo ***.sms** en el directorio "**bin**"; incluso puede probarse el "***.sms**" generado en un emulador como *"emullicius"*.

... el siguiente pasito es mejorar el código "**c**" (o los valientes el "**asm**") y *"re-compilar"*

## EXTRAS
Mirar en la carpeta "tools", en mi pc tengo enlaces a pequeñas herramientas, pero evidentemente cada cual incluirá aquí lo que prefiera.  
Por ejemeplo se aporta algún enlace a herramientas externas como **Img2SMS** o **TilesZipViewer** que nos ayudan con la tarea de convertir imágenes a un formato compatible con la Master System. O **retilesgify** que ayuda a desplazar los tilesets con el color de la paleta seleccionada. Muy importante también **checksumfix** que repara la firma del checksum en el sms.

> hecho con amor por GuerraTron26. <dinertron@gmail.com>
