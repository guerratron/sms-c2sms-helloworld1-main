@echo off
setlocal enabledelayedexpansion
rem :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem ::     insertar simbolos desconocidos en *.asm           ::
rem ::     esto ocurre porque falta enlazar con las          ::
rem ::     librerias de SDCC (-lz80)                         ::
rem ::     ATENCION: ESTO NO ES NECESARIO SI SE UTILIZA      ::
rem ::     LA OPCION -g CON "sdasz80"                        ::
rem :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SET PROJECT_NAME=
FOR /F "skip=1 eol=; delims=" %%a in (..\PROJECT_NAME.txt) do (
    IF "!PROJECT_NAME!"=="" (
        SET PROJECT_NAME=%%a
    )
)

IF "%PROJECT_NAME%"=="" (
    ECHO NADA QUE INSERTAR, NO SE HA DETECTADO EL FUENTE "*.asm"
    goto eof
)
SET PROJECT_NAME=%PROJECT_NAME%.asm
ECHO INSERTANDO SIMBOLOS DESCONOCIDOS EN "%PROJECT_NAME%"

ECHO. >>%PROJECT_NAME%
ECHO ; para evitar los simbolos sin definir de la libreria SDCC (-lz80)>>%PROJECT_NAME%
ECHO .area _CODE>>%PROJECT_NAME%
ECHO     .globl ___sdcc_call_hl>>%PROJECT_NAME%
ECHO     .globl ___sdcc_call_iy>>%PROJECT_NAME%
ECHO. >>%PROJECT_NAME%
ECHO ___sdcc_call_hl:>>%PROJECT_NAME%
ECHO     jp (hl)>>%PROJECT_NAME%
ECHO. >>%PROJECT_NAME%
ECHO ___sdcc_call_iy:>>%PROJECT_NAME%
ECHO    jp (iy)>>%PROJECT_NAME%
ECHO. >>%PROJECT_NAME%
