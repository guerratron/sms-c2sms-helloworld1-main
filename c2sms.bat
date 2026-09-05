@echo off
setlocal enabledelayedexpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::             SDCC compiling batch file v1.3            ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: SE ESPERA UN NOMBRE COMO 1 PARAMETRO, ESTE SERA EL NOMBRE DEL PROYECTO 
:: Y CREARA UN DIRECTORIO EN LA CARPETA 'projects' QUE CONTENDRA UN ARCHIVO 
:: PRINCIPAL '.c' CON EL MISMO NOMBRE. 
:: OPCIONALMENTE ADMITE UN SEGUNDO PARAMETRO "-e" QUE CREARA EL MISMO PROYECTO PERO VACIO.
:: Sintaxis de llamada:
::      c2sms.bat  [[/? ^| PROJECT_NAME] ^| -e]
:: GENERA UNA ESTRUCTURA ADECUADA DE CARPETAS PARA SEPARAR LOS DISTINTOS ARCHIVOS.
:: TAMBIEN PUEDE ECHARSE UN VISTAZO A "./projects/_main/" PARA OTRAS UTILIDADES.
::
:: SE NECESITA TENER INSTALADO "MAKE" Y "SDCC" SINO FALLARA.
::
:: by GuerraTron26 - dinertron@gmail
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: ---------------   SALVAGUARDAS Y PREPARATIVOS  ----------------------
:: SE CAMBIA LA PAGINA DE CODIGOS PARA PERMITIR EDITAR CORRECTAMENTE EL "Makefile" CON CARACTERES TABULADORES (NO ESPACIOS)
::@SET CHCP_OR=chcp| FINDSTR /R /C:"^[0-9][0-9]*$"
:: obtener la pagina de codigo activa (chcp), dependiendo del idioma el token puede encontrarse en la posicion 4 (EN) o 5 (SP)
for /f "tokens=5 delims=: " %%a in ('chcp') do set CP=%%a
:: GUARDA UNA COPIA PARA RESTAURAR AL FINAL
@SET CHCP_OR=%CP%
:: NUEVA PAG. CODIGO PARA LA EJECUCION DEL BAT (PERO EL BAT DEBE SEGUIR GUARDANDOSE COMO 'ANSI')
@SET CP=28591
ECHO Utilizando la pagina de codigo '%CP%'
chcp %CP% >nul

:: CREAR UN CARACTER TABULADOR NECESARIO EN LOS MAKEFILE
set "TAB=	"

cd %~dp0\

:: --------------------  FILTRADO DE ARGUMENTOS   ---------------------
:: argumentos de ayuda
if "%~1"=="" (
 call :HELP
 exit /b 0
)
if "%~1"=="/?" (
 call :HELP
 exit /b 0
)

ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ECHO ::     [c2sms.bat]       C to SMS project creator batch file v1.3              ::
ECHO :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: --------------------  NUEVOS ARGUMENTOS   -------------------------
SET PROJECT_NAME=%~1
IF "%PROJECT_NAME%"=="" SET PROJECT_NAME=main
SET SOURCES_NAME=_xxx_

:: Comprueba si existe el parametro "-e" de "EMPTY" para cargar una estructura distinta
IF "%~1"=="-e" (
    SET SOURCES_NAME=_xxx_EMPTY
    SET PROJECT_NAME=%~2
    IF "%PROJECT_NAME%"=="" (
        SET PROJECT_NAME=main
    )
) ELSE (
    IF "%~2"=="-e" (
        SET SOURCES_NAME=_xxx_EMPTY
    )
)

:: GOTO TO_EXIT

SET BASE_PROJECTS=.\projects
SET BASE_SOURCES=.\base\%SOURCES_NAME%

SET ASM2SMS_DIR=ASM2SMS
SET SRC_DIR=src
SET BIN_DIR=bin
SET LIB_DIR=lib
SET INC_DIR1=./inc;./assets/music;./assets/sounds;./assets/sprites;./assets/bg;./assets/fonts;./src
SET INC_DIR=-I./inc -I./assets/music -I./assets/sounds -I./assets/sprites -I./assets/bg -I./assets/fonts -I./src
SET INC_DIR1_ASM2SMS=../inc;../assets/music;../assets/sounds;../assets/sprites;../assets/bg;../assets/fonts;../src
SET INC_DIR_ASM2SMS=-I../inc -I../assets/music -I../assets/sounds -I../assets/sprites -I../assets/bg -I../assets/fonts -I../src
SET CRT_S=crt0sms
SET TOOLS_DIR=tools
SET CHECKSUMFIX=checksumfix/checksumfix.py


:: ----------------- INICIO DEL PROGRAMA PRINCIPAL -------------------

:: COPY PROJECT BASE
echo copying files ...
:: /I = carpeta, /E = subdirectorios
xcopy "%BASE_SOURCES%" "%BASE_PROJECTS%\%PROJECT_NAME%" /E /I /Y>nul

:: EMU
:: Guarda un Acceso directo al Emulador definido en emu.conf (si existe)
for /F "tokens=*" %%a in (emu.cnf) do (SET EMU=%%a)
    echo %EMU%
IF "%EMU%" EQU "" (
    ECHO No se ha configurado ningun emulador en "emu.cnf"
) ELSE (
    echo [Emulador: "%EMU%"]
    IF NOT EXIST "%BASE_PROJECTS%\%PROJECT_NAME%\%TOOLS_DIR%\emu.exe" (
        ECHO Creando "acceso directo"
        mklink "%BASE_PROJECTS%\%PROJECT_NAME%\%TOOLS_DIR%\emu.exe" "%EMU%">nul
    ) ELSE (
        ECHO YA EXISTE EL ACCESO DIRECTO!
    )
)

::/H
:: RENAME PROJECT
CD %BASE_PROJECTS%\%PROJECT_NAME%
IF NOT EXIST ".\%SRC_DIR%\%PROJECT_NAME%.c" (
    ren ".\%SRC_DIR%\%SOURCES_NAME%.c" "%PROJECT_NAME%.c"
)

REM BUILD MAKE
    REM DETECTANDO SDCC
for /f "tokens=1 delims=" %%a in ('where "$path:sdcc.exe"') do set SDCC_PATH=%%~dpa
IF "%SDCC_PATH%" EQU "" (
    ECHO Lo siento pero no detecto el compilador "SDCC"
    GOTO TO_EXIT_BAD
) ELSE (
    echo [Compilador "SDCC" detectado en: "%SDCC_PATH%"]
)
:: SDCC=c:/DEVELOP/SDCC/bin/sdcc
::SET SDCC=%SDCC_PATH%sdcc.exe
::SET SDAS=%SDCC_PATH%sdasz80.exe

ECHO [%ERRORLEVEL%] Crear el 'Makefile' ? [NO = 'CTRL+C']
PAUSE..

IF %ERRORLEVEL% NEQ 0 GOTO TO_EXIT_BAD

REM BEGIN BUILD PROJECT_NAME.txt
    ECHO #############>PROJECT_NAME.txt
    ECHO ;NO-TOCAR! :: CODIFICACION: ASCII, LINEA 1: NOMBRE DEL PROJECTO, LINEA 2: DIRECTORIO DE LOS BINARIOS>>PROJECT_NAME.txt
    ECHO %PROJECT_NAME%>>PROJECT_NAME.txt
    ECHO %BIN_DIR%>>PROJECT_NAME.txt
REM END .\%ASM2SMS_DIR%\PROJECT_NAME.txt

REM BEGIN BUILD .\%ASM2SMS_DIR%\FilenameMake
    ECHO #############>.\%ASM2SMS_DIR%\FilenameMake
    ECHO #  PROJECT  #>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO #############>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO # SIMPLEMENTE PARA ESTABLECER EL NOMBRE DEL PROJECTO PARA SER LLAMADO DESDE EL PreMakefile Y A SU VEZ EL Makefile PRINCIPAL.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO # REQUISITOS: DEBE EXISTIR UN *.asm CON ESE NOMBRE>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO # ESTA PREPARADO PARA UN SOLO ARCHIVO.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO # ADMITE UN PARAMETRO OPCIONAL, EJEMPLO DE LLAMADA DESDE CMD:>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO # ^> make F=main2>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO # Capturamos el parámetro o un valor por defecto>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO F ?= %PROJECT_NAME%>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO # mi_tarea:>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO #	@echo "El archivo objetivo es: '$(FILE_NAME)'">>.\%ASM2SMS_DIR%\FilenameMake
    ECHO.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO FILE_NAME:=${F}>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO SRC_DIR=.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO BIN_DIR=.>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO LIB_DIR=../%LIB_DIR%>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO # la libreria de arranque (startup) "crt0sms.s" sin extension>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO CRT_S=%CRT_S%>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO TOOLS_DIR=../%TOOLS_DIR%>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO CHECKSUMFIX=%CHECKSUMFIX%>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO INC_DIR=%INC_DIR_ASM2SMS%>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO INC_DIR1=%INC_DIR1_ASM2SMS%>>.\%ASM2SMS_DIR%\FilenameMake
    ECHO.>>.\%ASM2SMS_DIR%\FilenameMake
REM END .\%ASM2SMS_DIR%\FilenameMake

REM BEGIN BUILD PROJECTNAME-MAKEFILE
    ::ECHO SDCC=%SDCC%>ProjectNameMake
    ::ECHO SDAS=%SDAS%>>ProjectNameMake
    ECHO ##############>ProjectNameMake
    ECHO #   PROJECT  #>>ProjectNameMake
    ECHO ##############>>ProjectNameMake
    ECHO.>>ProjectNameMake
    ECHO # ESTABLECER EL NOMBRE DEL PROJECTO PARA SER LLAMADO DESDE EL PreMakefile Y A SU VEZ EL Makefile PRINCIPAL.>>ProjectNameMake
    ECHO # TAMBIEN ALGUNAS VARIABLES Y DIRECTORIOS PARA MAKEFILE>>ProjectNameMake
    ECHO # ESTE ARCHIVO SE HA GENERADO DINAMICAMENTE POR "c2sms.bat" PARA INCLUIRSE EN EL 'PreMakefile'>>ProjectNameMake
    ECHO # AUNQUE ES INOCUO, NO UTILIZAR INDEPENDIENTEMENTE.>>ProjectNameMake
    ECHO.>>ProjectNameMake
    ECHO # ADMITE UN PARAMETRO OPCIONAL, EJEMPLO DE LLAMADA DESDE CMD: ^> make F=main2.>>ProjectNameMake
    ECHO.>>ProjectNameMake
    ECHO # Capturamos el parámetro o un valor por defecto.>>ProjectNameMake
    ECHO PROJECT_NAME ?= %PROJECT_NAME%>>ProjectNameMake
    ECHO SRC_DIR=%SRC_DIR%>>ProjectNameMake
    ECHO BIN_DIR=%BIN_DIR%>>ProjectNameMake
    ECHO LIB_DIR=%LIB_DIR%>>ProjectNameMake
    ECHO # la libreria de arranque (startup) "crt0sms.s" sin extension>>ProjectNameMake
    ECHO CRT_S=%CRT_S%>>ProjectNameMake
    ECHO TOOLS_DIR=%TOOLS_DIR%>>ProjectNameMake
    ECHO CHECKSUMFIX=%CHECKSUMFIX%>>ProjectNameMake
    ECHO INC_DIR=%INC_DIR%>>ProjectNameMake
    ECHO INC_DIR1=%INC_DIR1%>>ProjectNameMake
    ECHO VPATH='./${SRC_DIR};./${BIN_DIR};./${LIB_DIR};./${INC_DIR1};'>>ProjectNameMake
    ECHO.>>ProjectNameMake
REM END BUILD MAKEFILE

REM BEGIN BUILD
    REM DETECTANDO MAKE 
for /f "tokens=1 delims=" %%a in ('where "$path:make.exe"') do set MAKE_PATH=%%~dpa
IF "%MAKE_PATH%" EQU "" (
    ECHO Lo siento pero no detecto la orden "MAKE"
    GOTO TO_EXIT_BAD
) ELSE (
    echo [Orden "MAKE" detectada en: "%MAKE_PATH%"]
)

ECHO [%ERRORLEVEL%] Compilar el projecto '%PROJECT_NAME%' ? [NO = 'CTRL+C']
PAUSE..
::make 
REM END BUILD

REM BEGIN CLEAN
::ECHO [%ERRORLEVEL%] Limpiar archivos del projecto '%PROJECT_NAME%' ? [NO = 'CTRL+C']
::PAUSE..
make valid
REM END CLEAN

REM COPY THE *.ASM TO ASM2SMS-DIR
IF EXIST ".\%BIN_DIR%\%PROJECT_NAME%.asm" (
    COPY .\%BIN_DIR%\%PROJECT_NAME%.asm .\%ASM2SMS_DIR%\%PROJECT_NAME%.asm
)

REM SALIDA LIMPIA
:TO_EXIT
    chcp %CHCP_OR% >nul
    ECHO Pagina de codigos restaurada a '%CHCP_OR%'
    endlocal
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    @ECHO [%ERRORLEVEL%] Pulse cualquier tecla para salir .... 
    PAUSE..
    EXIT /B %ERRORLEVEL%
    :: EXIT(0)

REM SALIDA SUCIA
:TO_EXIT_BAD
    chcp %CHCP_OR% >nul
    ECHO [%ERRORLEVEL%] Pagina de codigos restaurada a '%CHCP_OR%'
    endlocal
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    SET %ERRORLEVEL%=1
    EXIT /B %ERRORLEVEL%
    :: EXIT(-1)


:: ------------- FIN DEL PROGRAMA PRINCIPAL --------------------

:: SUBROUTINES
:HELP
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    echo ::     [c2sms.bat]       C to SMS project creator batch file v1.3              ::
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    echo.
    echo Generador de proyectos desde "c" a "sms" preparado para escribir codigo "c" 
    echo y compilarlo.
    echo.
    echo by GuerraTron26 ^<dinertron@gmail.com^>
    echo.
    ECHO :: AYUDA: ::
    ECHO ------------
    echo.
    echo SE ESPERA UN NOMBRE COMO 1 PARAMETRO, ESTE SERA EL NOMBRE DEL PROYECTO 
    echo Y CREARA UN DIRECTORIO EN LA CARPETA 'projects' QUE CONTENDRA UN ARCHIVO 
    echo PRINCIPAL '.c' CON EL MISMO NOMBRE, ADEMAS DE TODA LA ESTRUCTURA DE CARPETAS 
    echo CONVENIENTE.
    echo OPCIONALMENTE ADMITE UN SEGUNDO PARAMETRO "-e" QUE CREARA EL MISMO PROYECTO 
    echo PERO VACIO.
    echo.
    echo Sintaxis:
    echo c2sms.bat  [[/? ^| PROJECT_NAME] ^| -e]
    echo.
    echo. ^/? muestra esta ayuda
    echo PROJECT_NAME: el nombre de projecto deseado (cuidado, sobreescribira los existentes)
    echo -e: [EMPTY] Creara un proyecto preparado pero vacio de archivos media (sonidos, graficos, ..)
    echo.
    echo devuelve codigo de error 1 si no se detectan el compilador "SDCC" o la orden "MAKE"
    echo otros codigos de error son posibles por acceso o permisos al sistema de archivos.
    echo.
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    GOTO TO_EXIT
