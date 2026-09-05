@echo off
setlocal enabledelayedexpansion
rem :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem ::             SDCC compiling batch file v1              ::
rem :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SET _TAB=	

SET PROJECT_NAME=
FOR /F "skip=1 eol=; delims=" %%a in (PROJECT_NAME.txt) do (
    IF "!PROJECT_NAME!"=="" (
        SET PROJECT_NAME=%%a
    ) ELSE (
        SET BIN_DIR=%%a
    )
)

ECHO PROJECT_NAME: "%PROJECT_NAME%", BIN_DIR: "%BIN_DIR%"
::PAUSE..
::exit 

cd %~dp0\

::make

rem : Esto realiza las ordenes: [_xxx_ = Nombre del projecto]
rem 
rem @ sdcc -mz80 -c -o _xxx_.rel _xxx_.c
rem @ sdcc -mz80 --data-loc 0xC000 --no-std-crt0 -o _xxx_.ihx crt0sms.rel _xxx_.rel objcopy -I ihex -O binary _xxx_.ihx _xxx_.sms
rem 
rem y el resultado son 6 archivos '_xxx_': 
rem .asm, .ihx, .lk, .lst, .map, .noi, .rel, .sym y finalmente '_xxx_.sms' que es la ROM (32 Kb) a utilizar

rem LIMPIA TODOS LOS ARCHIVOS GENERADOS ANTERIORMENTE
rem make clean

rem IGUAL A 'clean' PERO MANTIENE LOS .asm Y LOS .sms
make valid

COPY %BIN_DIR%\%PROJECT_NAME%.asm ASM2SMS\%PROJECT_NAME%.asm

:TO_EXIT
endlocal
:: EXIT(-1)
