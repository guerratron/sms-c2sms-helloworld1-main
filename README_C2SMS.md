> -----------------------------------------------------------------------------------------------------
>   'C2SMS' (Batch File) - Genera un proyecto base para "SMS" (Master System) desde "C" (o "asm"), lo compila 
>           y limpia, preparado para añadir código al archivo "c" y recompilar con el "compile.bat" creado.  
>           Sin librerías externas.   
>   Author:  Juan José Guerra Haba - <dinertron@gmail.com> - Feb, 2026  
>   Web:     https://guerratron.github.io/  
>   Categoria: Master System, 8 bits console  
>   License: Free BSD. & Open GPL v.3. Keep credit, please.  
>   Versión: 2.0.0   
>   File:    c2sms.bat               Main Class: N/A  
>   
> ----------------------------------------------------------------------------------------------------

# C2SMS - INTRO v2.0 ![Logo](./logo.png "Logo")
**"Generador de Proyectos de C (o ASM) a SMS"**. Incluye unos ``` Makefile ``` preparados para trabajar con una estructura de 
carpetas conveniente; una vez creado el proyecto ejecutar ``` > make ```, o para Windows simplemente ejecutar el ``` compile.bat ```.  
O si se desea utilizar **VSC** (Visual Script Code), también viene preparado para abrirlo como proyecto. 

> Este proyecto se ha construido utilizando ejemplos del fantástico blog 
> de [Avelino Herrera](https://avelinoherrera.com/) (Muchas Gracias artista !)  
> Sin ayuda de ninguna librería externa.

## DESCRIPCIÓN
Lo dicho, sólo ejecutando el **c2sms.bat** y entregándole como parámetro el nombre del proyecto, este se 
encarga de generar toda la estructura básica válida para empezar a codificar en "c". Este *bat* es interactivo y 
le irá guiando en el proceso de *creación/ensamblado/compilación*. 

Admite un parámetro opcional "-e" (de EMPTY) para crear un proyecto vacío.

Los archivos generados se encontrarán en una carpeta con el mismo nombre del proyecto dentro del directorio 
"projects" y organizados en una estructura aceptable de carpetas para separar código, librerías, binarios, assets, ...

También se habrá creado un script de compilación "compile.bat" que trabaja con el **Makefile** para realizar 
todo el trabajo de compilación de **c** a **sms** (o bien utilizar el comando **make**).

Así mismo se aporta una carpeta aparte (**ASM2SMS**) con un Makefile independiente por si se quiere insertar en 
ella el ``` *.asm ``` generado, ajustarlo al máximo y luego recompilarlo. (Más bien orientado a programadores en **ensamblador**)

Ahora a probarlo en un emulador o incluso en un cartucho flash *(los afortunados que lo posean)*

> el proyecto contendrá el código mínimo sobre el que construir el projecto siguiendo algún tutorial.  
> Si se prueba en un emulador de momento sólo se muestra un fondo con un logo y un corazón moviendose por toda 
> la pantalla de la SMS, todo esto con música (Arkanoid) de fondo.  
> A no ser que se aporte el parametro "-e"

## NOVEDAD
Con respecto a la anterior versión ahora se ha estructurado todo con funciones comunes para todos los videojuegos, como "init", "draw" 
y "update", que facilitan su uso.  
Además se ha añadido un archivo "spritesManger.h" con funciones para la creación y el manejo de fondos, imágenes, sprites-monotile, 
sprites-multitiles e incluso animaciones. Puede verse su uso observando el archivo principal ".c" del proyecto y la utilización de las 
funciones correspondientes.

## REQUISITOS
Independientemente de que está orientado a entornos Windows (*c2sms.bat*) podría fácilmente portarse a *c2sms.sh*  
Y evidentemente se necesita tener instalada la orden ``` make ``` y el compilador utilizado ``` SDCC ```  
No es obligatorio, pero sería cómodo si se tiene instalado *VSC* para la modificación del código fuente.

Por supuesto SDCC debe estar instalado en su sistema y sus rutas añadidas a algunos archivos como "c_cpp_properties.json".

Si se desea un enlace (acceso directo) al emulador especificar su ruta en el archivo **emu.cnf**, archivo 
de una sóla línea.

## USO RÁPIDO
Ventana de comandos y ...  

``` > c2sms proj1 ```  

... voilâ ! ya tenemos nuestro projecto de nombre "**proj1**" en el directorio "**projects**"; incluso puede probarse el "**proj1.sms**" generado en un emulador como *"emullicius"*.

... el siguiente pasito es mejorar el código "**c**" (o los valientes el "**asm**") y *"re-compilar"*

## EXTRAS
Mirar en la carpeta "tools", en mi pc tengo enlaces a pequeñas herramientas, pero evidentemente cada cual incluirá aquí lo que prefiera.  
Por ejemeplo se aporta algún enlace a herramientas externas como **Img2SMS** o **TilesZipViewer** que nos ayudan con la tarea de convertir 
imágenes a un formato compatible con la Master System. También otras como **retilesgify** que nos permiten remapear los tilesets para 
desplazar los colores de la paleta a utilizar. Y también **checksumfix.py** para firmar con un *checksum válido* los "*.sms"

> hecho con amor por GuerraTron26. <dinertron@gmail.com>
