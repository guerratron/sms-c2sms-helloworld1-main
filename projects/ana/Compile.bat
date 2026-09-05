@echo off
setlocal enabledelayedexpansion
rem :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem ::             SDCC compiling batch file v1              ::
rem :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

cd %~dp0\

make

rem : Esto realiza las ordenes:
rem 
rem @ sdcc -mz80 -c -o main.rel main.c
rem @ sdcc -mz80 --data-loc 0xC000 --no-std-crt0 -o main.ihx crt0sms.rel main.rel objcopy -I ihex -O binary main.ihx main.sms
rem 
rem y el resultado son 6 archivos 'main': 
rem .asm, .ihx, .lk, .lst, .map, .noi, .rel, .sym y finalmente 'main.sms' que es la ROM (32 Kb) a utilizar

rem LIMPIA TODOS LOS ARCHIVOS GENERADOS ANTERIORMENTE
rem make clean

rem IGUAL A 'clean' PERO MANTIENE LOS .asm Y LOS .sms
make valid

:TO_EXIT
endlocal
:: EXIT(-1)
