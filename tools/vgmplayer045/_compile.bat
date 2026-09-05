@echo off
setlocal enabledelayedexpansion
rem :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem ::             VGMPlayer batch file v1              ::
rem :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem :: Compila una ROM-SMS con el reproductor agregandole el ::
rem :: sonido en formato VGM.
rem :: Arrastrar el sonido-música.vgm a este bat y listo 
rem :: O bien escribir en el cmd: - _compile.bat MiSonido.vgm
rem :: ... y LISTO!
rem :: Se generara un "MiSonido.sms" para probar en Emulador.

SET _PLAYER=vgmplayer.stub
SET _SOUND=%~1
SET _SOUND_NAME=%~n1
SET _OUT=%_SOUND_NAME%_player.sms

REM COMPROBACION:

SET _SOUND_EXT=%~x1
SET _OK=FALSE
IF "%_SOUND_EXT%"==".vgm" SET _OK=TRUE
IF "%_SOUND_EXT%"==".VGM" SET _OK=TRUE
IF "%_OK%"=="FALSE" (
    ECHO EXTENSION DE ARCHIVO NO VALIDA: "%_SOUND_EXT%"
    ECHO NO SE DETECTA ARCHIVO VGM CORRECTO: "%_SOUND%"
    GOTO TO_EXIT
)

ECHO SOUND: "%_SOUND%" TO VGM-PLAYER-SMS: "%_OUT%"

COPY /b %_PLAYER%+%_SOUND% %_OUT%

:TO_EXIT
endlocal
:: EXIT(-1)
