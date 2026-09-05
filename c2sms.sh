#!/usr/bin/env bash
#===============================================================================
#  c2sms.sh  v1.3
#===============================================================================
#  Adaptacion a GNU Bash del script Windows "c2sms.bat" v1.3
#  Generador de proyectos "C" -> "SMS" (Sega Master System) con SDCC + MAKE.
#
#  SE ESPERA UN NOMBRE COMO 1 PARAMETRO, ESTE SERA EL NOMBRE DEL PROYECTO
#  Y CREARA UN DIRECTORIO EN LA CARPETA 'projects' QUE CONTENDRA UN ARCHIVO
#  PRINCIPAL '.c' CON EL MISMO NOMBRE.
#  OPCIONALMENTE ADMITE UN SEGUNDO PARAMETRO "-e" QUE CREARA EL MISMO PROYECTO
#  PERO VACIO.
#
#  Sintaxis de llamada:
#      ./c2sms.sh  [[/? | PROJECT_NAME] | -e]
#
#  GENERA UNA ESTRUCTURA ADECUADA DE CARPETAS PARA SEPARAR LOS DISTINTOS ARCHIVOS.
#  TAMBIEN PUEDE ECHARSE UN VISTAZO A "./projects/_main/" PARA OTRAS UTILIDADES.
#
#  SE NECESITA TENER INSTALADO "MAKE" Y "SDCC" SINO FALLARA.
#
#  by GuerraTron26 - dinertron@gmail  (version .bat original v1.3)
#  port a Bash: adaptacion integral del codigo .bat
#===============================================================================

set -u   # las variables sin definir se tratan como error (cuidado en Bash)

# Ruta del directorio donde vive este script (equivalente a "%~dp0")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" || exit 1
cd "$SCRIPT_DIR" || { echo "ERROR: no se puede entrar en '$SCRIPT_DIR'" >&2; exit 1; }

#------------------------------------------------------------------------------
#  SALVAGUARDAS Y PREPARATIVOS
#------------------------------------------------------------------------------
# En el .bat se cambiaba la pagina de codigos (chcp 28591 / ISO-8859-1) para que
# los 'Makefile' generados conservaran tabuladores reales y los acentos se
# mostraran bien en consola. En Bash/Linux no es necesario: la codificacion
# habitual es UTF-8 y los tabuladores son caracteres normales en cualquier editor.
echo "Utilizando codificacion UTF-8 (equivalente a la pagina de codigo '28591' del .bat original)"

# Crear un caracter tabulador necesario en los Makefile
TAB="$(printf '\t')"

#------------------------------------------------------------------------------
#  FUNCIONES AUXILIARES (SUBRUTINAS)
#------------------------------------------------------------------------------

# "PAUSE" de Windows adaptado a Bash.
# En modo interactivo espera una pulsacion de tecla; en modo no interactivo
# (tuberia, CI, redireccion) continua automaticamente sin bloquearse.
pause() {
    if [ -t 0 ]; then
        printf "Pulse una tecla para continuar . . ."
        read -r -s -n 1 || true
        printf "\n"
    fi
    return 0
}

# Linea separadora identica a la del .bat original
SEP_LINE=":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
separator() { echo "$SEP_LINE"; }

# :HELP  (subrutina de ayuda del .bat original)
help_screen() {
    separator
    echo "::     [c2sms.sh]        C to SMS project creator bash script v1.3            ::"
    separator
    echo
    echo 'Generador de proyectos desde "c" a "sms" preparado para escribir codigo "c"'
    echo 'y compilarlo.'
    echo
    echo 'by GuerraTron26 <dinertron@gmail.com>'
    echo
    echo ':: AYUDA: ::'
    echo '------------'
    echo
    echo 'SE ESPERA UN NOMBRE COMO 1 PARAMETRO, ESTE SERA EL NOMBRE DEL PROYECTO'
    echo "Y CREARA UN DIRECTORIO EN LA CARPETA 'projects' QUE CONTENDRA UN ARCHIVO"
    echo "PRINCIPAL '.c' CON EL MISMO NOMBRE, ADEMAS DE TODA LA ESTRUCTURA DE CARPETAS"
    echo 'CONVENIENTE.'
    echo 'OPCIONALMENTE ADMITE UN SEGUNDO PARAMETRO "-e" QUE CREARA EL MISMO PROYECTO'
    echo 'PERO VACIO.'
    echo
    echo 'Sintaxis:'
    echo 'c2sms.sh  [[/? | PROJECT_NAME] | -e]'
    echo
    echo ' /? muestra esta ayuda'
    echo 'PROJECT_NAME: el nombre de projecto deseado (cuidado, sobreescribira los existentes)'
    echo '-e: [EMPTY] Creara un proyecto preparado pero vacio de archivos media (sonidos, graficos, ..)'
    echo
    echo 'devuelve codigo de error 1 si no se detectan el compilador "SDCC" o la orden "MAKE"'
    echo 'otros codigos de error son posibles por acceso o permisos al sistema de archivos.'
    echo
    separator
}

# :TO_EXIT  (SALIDA LIMPIA del .bat original)
exit_clean() {
    # En el .bat se restauraba aqui la pagina de codigos: 'chcp %CHCP_OR% >nul'
    echo "Codificacion UTF-8 (en el .bat se restauraba la pagina de codigos original)"
    separator
    echo "[0] Pulse cualquier tecla para salir ...."
    pause
    exit 0
}

# :TO_EXIT_BAD  (SALIDA SUCIA del .bat original)
# NOTA: en el .bat original la linea 'SET %ERRORLEVEL%=1' era un error y el
# script acababa devolviendo 0; aqui se devuelve el codigo 1 que era la
# intencion declarada en la ayuda ("devuelve codigo de error 1 si no se
# detectan el compilador SDCC o la orden MAKE").
exit_bad() {
    echo "Codificacion UTF-8 (en el .bat se restauraba la pagina de codigos original)"
    separator
    echo "[1] Pulse cualquier tecla para salir ...."
    pause
    exit 1
}

#------------------------------------------------------------------------------
#  FILTRADO DE ARGUMENTOS  (argumentos de ayuda)
#------------------------------------------------------------------------------
if [ "$#" -eq 0 ]; then
    help_screen
    exit_clean
fi

case "$1" in
    "/?"|"-h"|"--help"|"help")
        help_screen
        exit_clean
        ;;
esac

separator
echo "::     [c2sms.sh]        C to SMS project creator bash script v1.3            ::"
separator

#------------------------------------------------------------------------------
#  NUEVOS ARGUMENTOS
#------------------------------------------------------------------------------
PROJECT_NAME="${1:-main}"
SOURCES_NAME="_xxx_"

# Comprueba si existe el parametro "-e" de "EMPTY" para cargar una estructura distinta
if [ "$1" = "-e" ]; then
    SOURCES_NAME="_xxx_EMPTY"
    PROJECT_NAME="${2:-main}"
elif [ "${2:-}" = "-e" ]; then
    SOURCES_NAME="_xxx_EMPTY"
fi

# Valor por defecto si el nombre acaba quedando vacio
if [ -z "$PROJECT_NAME" ]; then
    PROJECT_NAME="main"
fi

#------------------------------------------------------------------------------
#  VARIABLES / CONSTANTES
#------------------------------------------------------------------------------
BASE_PROJECTS="${SCRIPT_DIR}/projects"
BASE_SOURCES="${SCRIPT_DIR}/base/${SOURCES_NAME}"

ASM2SMS_DIR="ASM2SMS"
SRC_DIR="src"
BIN_DIR="bin"
LIB_DIR="lib"
INC_DIR1="./inc;./assets/music;./assets/sounds;./assets/sprites;./assets/bg;./assets/fonts;./src"
INC_DIR="-I./inc -I./assets/music -I./assets/sounds -I./assets/sprites -I./assets/bg -I./assets/fonts -I./src"
INC_DIR1_ASM2SMS="../inc;../assets/music;../assets/sounds;../assets/sprites;../assets/bg;../assets/fonts;../src"
INC_DIR_ASM2SMS="-I../inc -I../assets/music -I../assets/sounds -I../assets/sprites -I../assets/bg -I../assets/fonts -I../src"
CRT_S="crt0sms"
TOOLS_DIR="tools"
CHECKSUMFIX="checksumfix/checksumfix.py"

#------------------------------------------------------------------------------
#  INICIO DEL PROGRAMA PRINCIPAL
#------------------------------------------------------------------------------

# ---- COPY PROJECT BASE ----
# Equivalente a: xcopy "%BASE_SOURCES%" "%BASE_PROJECTS%\%PROJECT_NAME%" /E /I /Y
echo "copying files ..."
if [ ! -d "$BASE_SOURCES" ]; then
    echo "ERROR: no existe la plantilla base '$BASE_SOURCES'"
    exit_bad
fi
mkdir -p "${BASE_PROJECTS}/${PROJECT_NAME}"
cp -r "${BASE_SOURCES}/." "${BASE_PROJECTS}/${PROJECT_NAME}/"

# ---- EMU ----
# Guarda un acceso directo al Emulador definido en emu.cnf (si existe)
EMU=""
if [ -f "emu.cnf" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        EMU="${line%$'\r'}"     # quita posibles CR de archivos con fin de linea Windows
    done < "emu.cnf"
fi
echo "${EMU:-}"
if [ -z "$EMU" ]; then
    echo 'No se ha configurado ningun emulador en "emu.cnf"'
else
    echo "[Emulador: \"${EMU}\"]"
    EMU_LINK="${BASE_PROJECTS}/${PROJECT_NAME}/${TOOLS_DIR}/emu.exe"
    if [ ! -e "$EMU_LINK" ]; then
        echo 'Creando "acceso directo"'
        if ! ln -s "$EMU" "$EMU_LINK" 2>/dev/null; then
            echo "AVISO: no se pudo crear el enlace simbolico hacia '${EMU}'"
        fi
    else
        echo "YA EXISTE EL ACCESO DIRECTO!"
    fi
fi

# ---- RENAME PROJECT ----
# Entrar en el directorio del proyecto recien copiado
cd "${BASE_PROJECTS}/${PROJECT_NAME}" || { echo "ERROR: no se puede entrar en '${BASE_PROJECTS}/${PROJECT_NAME}'" >&2; exit_bad; }

if [ ! -f "./${SRC_DIR}/${PROJECT_NAME}.c" ]; then
    if [ -f "./${SRC_DIR}/${SOURCES_NAME}.c" ]; then
        mv "./${SRC_DIR}/${SOURCES_NAME}.c" "./${SRC_DIR}/${PROJECT_NAME}.c"
    else
        echo "AVISO: no se encontro '${SRC_DIR}/${SOURCES_NAME}.c' para renombrarlo a '${PROJECT_NAME}.c'"
    fi
fi

# ---- BUILD MAKE: DETECTANDO SDCC ----
# Equivalente a: for /f ... in ('where "$path:sdcc.exe"') do set SDCC_PATH=%%~dpa
SDCC_PATH=""
if command -v sdcc >/dev/null 2>&1; then
    SDCC_PATH="$(cd "$(dirname "$(command -v sdcc)")" && pwd)/"
else
    echo 'Lo siento pero no detecto el compilador "SDCC"'
    exit_bad
fi
echo "[Compilador \"SDCC\" detectado en: \"${SDCC_PATH}\"]"

echo "[0] Crear el 'Makefile' ? [NO = 'CTRL+C']"
pause

# ---- BEGIN BUILD PROJECT_NAME.txt ----
cat > "PROJECT_NAME.txt" <<'EOF_PROJ'
#############
;NO-TOCAR! :: CODIFICACION: ASCII, LINEA 1: NOMBRE DEL PROJECTO, LINEA 2: DIRECTORIO DE LOS BINARIOS
@PROJECT_NAME@
@BIN_DIR@
EOF_PROJ
sed -i -e "s|@PROJECT_NAME@|${PROJECT_NAME}|g" \
       -e "s|@BIN_DIR@|${BIN_DIR}|g" \
       "PROJECT_NAME.txt"
# ---- END BUILD PROJECT_NAME.txt ----

# ---- BEGIN BUILD ./ASM2SMS/FilenameMake ----
mkdir -p "${ASM2SMS_DIR}"
cat > "${ASM2SMS_DIR}/FilenameMake" <<'EOF_FM'
#############
#  PROJECT  #
#############

# SIMPLEMENTE PARA ESTABLECER EL NOMBRE DEL PROJECTO PARA SER LLAMADO DESDE EL PreMakefile Y A SU VEZ EL Makefile PRINCIPAL.

# REQUISITOS: DEBE EXISTIR UN *.asm CON ESE NOMBRE
# ESTA PREPARADO PARA UN SOLO ARCHIVO.

# ADMITE UN PARAMETRO OPCIONAL, EJEMPLO DE LLAMADA DESDE CMD:
# > make F=main2

# Capturamos el parámetro o un valor por defecto
F ?= @PROJECT_NAME@

# mi_tarea:
#@echo "El archivo objetivo es: '$(FILE_NAME)'"

FILE_NAME:=${F}
SRC_DIR=.
BIN_DIR=.
LIB_DIR=../@LIB_DIR@
# la libreria de arranque (startup) "crt0sms.s" sin extension
CRT_S=@CRT_S@
TOOLS_DIR=../@TOOLS_DIR@
CHECKSUMFIX=@CHECKSUMFIX@
INC_DIR=@INC_DIR_ASM2SMS@
INC_DIR1=@INC_DIR1_ASM2SMS@

EOF_FM

# Insertar el tabulador real tras el '#' (igual que hacia el ECHO con TAB del .bat)
awk '{ if ($0 ~ /^#@echo/) sub(/^#/, "#\t"); print }' "${ASM2SMS_DIR}/FilenameMake" \
    > "${ASM2SMS_DIR}/.FilenameMake.tmp" \
    && mv "${ASM2SMS_DIR}/.FilenameMake.tmp" "${ASM2SMS_DIR}/FilenameMake"

sed -i -e "s|@PROJECT_NAME@|${PROJECT_NAME}|g" \
       -e "s|@LIB_DIR@|${LIB_DIR}|g" \
       -e "s|@CRT_S@|${CRT_S}|g" \
       -e "s|@TOOLS_DIR@|${TOOLS_DIR}|g" \
       -e "s|@CHECKSUMFIX@|${CHECKSUMFIX}|g" \
       -e "s|@INC_DIR_ASM2SMS@|${INC_DIR_ASM2SMS}|g" \
       -e "s|@INC_DIR1_ASM2SMS@|${INC_DIR1_ASM2SMS}|g" \
       "${ASM2SMS_DIR}/FilenameMake"
# ---- END BUILD ./ASM2SMS/FilenameMake ----

# ---- BEGIN BUILD ProjectNameMake ----
cat > "ProjectNameMake" <<'EOF_PNM'
##############
#   PROJECT  #
##############

# ESTABLECER EL NOMBRE DEL PROJECTO PARA SER LLAMADO DESDE EL PreMakefile Y A SU VEZ EL Makefile PRINCIPAL.
# TAMBIEN ALGUNAS VARIABLES Y DIRECTORIOS PARA MAKEFILE
# ESTE ARCHIVO SE HA GENERADO DINAMICAMENTE POR "c2sms.sh" PARA INCLUIRSE EN EL 'PreMakefile'
# AUNQUE ES INOCUO, NO UTILIZAR INDEPENDIENTEMENTE.

# ADMITE UN PARAMETRO OPCIONAL, EJEMPLO DE LLAMADA DESDE CMD: > make F=main2.

# Capturamos el parámetro o un valor por defecto.
PROJECT_NAME ?= @PROJECT_NAME@
SRC_DIR=@SRC_DIR@
BIN_DIR=@BIN_DIR@
LIB_DIR=@LIB_DIR@
# la libreria de arranque (startup) "crt0sms.s" sin extension
CRT_S=@CRT_S@
TOOLS_DIR=@TOOLS_DIR@
CHECKSUMFIX=@CHECKSUMFIX@
INC_DIR=@INC_DIR@
INC_DIR1=@INC_DIR1@
VPATH='./${SRC_DIR};./${BIN_DIR};./${LIB_DIR};./${INC_DIR1};'

EOF_PNM

sed -i -e "s|@PROJECT_NAME@|${PROJECT_NAME}|g" \
       -e "s|@SRC_DIR@|${SRC_DIR}|g" \
       -e "s|@BIN_DIR@|${BIN_DIR}|g" \
       -e "s|@LIB_DIR@|${LIB_DIR}|g" \
       -e "s|@CRT_S@|${CRT_S}|g" \
       -e "s|@TOOLS_DIR@|${TOOLS_DIR}|g" \
       -e "s|@CHECKSUMFIX@|${CHECKSUMFIX}|g" \
       -e "s|@INC_DIR@|${INC_DIR}|g" \
       -e "s|@INC_DIR1@|${INC_DIR1}|g" \
       "ProjectNameMake"
# ---- END BUILD ProjectNameMake ----

# ---- DETECTANDO MAKE ----
# Equivalente a: for /f ... in ('where "$path:make.exe"') do set MAKE_PATH=%%~dpa
MAKE_PATH=""
if command -v make >/dev/null 2>&1; then
    MAKE_PATH="$(cd "$(dirname "$(command -v make)")" && pwd)/"
else
    echo 'Lo siento pero no detecto la orden "MAKE"'
    exit_bad
fi
echo "[Orden \"MAKE\" detectada en: \"${MAKE_PATH}\"]"

echo "[0] Compilar el proyecto '${PROJECT_NAME}' ? [NO = 'CTRL+C']"
pause

# En el .bat se lanzaba el objetivo 'valid' del Makefile del proyecto
make valid

# ---- COPY THE *.ASM TO ASM2SMS-DIR ----
if [ -f "./${BIN_DIR}/${PROJECT_NAME}.asm" ]; then
    cp "./${BIN_DIR}/${PROJECT_NAME}.asm" "./${ASM2SMS_DIR}/${PROJECT_NAME}.asm"
fi

# ---- FIN DEL PROGRAMA PRINCIPAL ----
exit_clean
