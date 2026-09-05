
rem llamar con 'project.bat java.exe' para saber si esta instalado en el sistema
:: ECHO '%~$PATH:1'
rem llamar con 'project.bat NOMBRE.EXT' muestra informacion detallada de archivo pasado
::ECHO RUTA COMPLETA: '%~f1' & ECHO FECHA        : '%~t1' & ECHO SIZE         : '%~z1' BYTES & ECHO ATRIBUTOS    : '%~a1'
REM O TODO JUNTO: @ECHO. '%~ftza1'
REM COMPRUEBA UN USUARIO REGISTRADO EN EL SISTEMA
::net user %1 >nul 2>nul
::if ERRORLEVEL 1 (echo el usuario %1 NO esta registrado en el sistema 1>&2) ELSE (echo el usuario %1 SI esta registrado en el sistema 1>&2)
REM COMPRUEBA UTF8 (65001) EN LA CONSOLA, (28591 ES EUR/OCC)
::chcp | findstr /R /C:"28591" >nul
::if %errorlevel% equ 0 (echo La pagina de codigos es UTF-8) else (echo No es UTF-8)

:: Crea un acceso directo
:: set /p EMU_PATH=Introducir la ruta al emulador ? ['ESC'==Cancel]
:: if "%EMU_PATH%" EQU "" GOTO TO_EXIT
:: mklink "./emu.exe" "%EMU_PATH%"
:: GOTO TO_EXIT