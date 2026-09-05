
# C2SMS-v2: CLASIFICACIÓN ARCHIVOS
Todos los proyectos "c2sms" arrancan con una estructura de archivos y carpetas donde se encuentran clasificados una serie de archivos mínimos (o comunes).

# Estructura Mínima
```
 - PROJECT_NAME/
  |- .vscode/
    |- c_cpp_properties.json
    |- extensions.json
    |- settings.json
    |- tasks.json
  |- ASM2SMS/
    |- crt0sms.s
    |- FilenameMake
    |- MAKE_LLAMADA_CMD.txt
    |- Makefile
    |- PreMakefile
  |- assets/
    |- bg/
      |- mo_def.h
      |- ..
    |- fonts/..
    |- music/
      |- arkanoid_title_screen_vgm.h
    |- sounds/..
    |- sprites/
      |- guerraTron_def.h
      |- miniheart_def.h
      |- ..
    |- ..
  |- bin/
  |- inc/
    |- basic.h
    |- defines.h
    |- main.h
    |- newTypes.h
    |- simpleSounds.h
    |- spritesManager.h
  |- lib/
    |- crt0sms.s
  |- src/
    |- _xxx_.c
    |- const.h
    |- ires.h
    |- load_commons.h
    |- stage_intro.h
    |- states.h
  |- tools/
    |- checksumfix/..
    |- ..
    |- palette64.png
    |- LINKs.txt
    |- ..
  |- _compile.bat
  |- _README.md
  |- _STRUCTURE.md
  |- logo.png
  |- Makefile
  |- PreMakefile
  |- ProjectNameMake
  |- PROJECT_NAME.txt
  |- TIPs.txt
```

# ASSETS-MANAGER
Los archivos de definiciones de assets (bg, imágenes, sprites-monotile, sprites-multitiles, animaciones, ..) los administran las funciones del "spritesManager.h".  
Para esto, esos archivos deben tener una estructura fija y sus arrays y funciones llamarse de una manera determinada. Yo sigo la regla de llamarlos en función del 
nombre de archivo y utilizando "pseudo-CamelCase".  
Mejor utilizar alguno de ellos como plantilla y ver el código en el "project.c" para comprobar su funcionamiento y cuando llamarlas.
