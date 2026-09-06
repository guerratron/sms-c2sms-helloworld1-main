# =============================================================================
#             SDCC compiling Makefile initializer v1.3 (Cross-Platform)
# =============================================================================
# Admite parametro 'p' como nombre de projecto (por defecto 'main'), 'e=1' para 
# crear un projecto minimo vacio, y 'c=0' para no compilar la solucion.
# Sintaxis de llamada:
#      make -f init.mk p=MiJuego
#      make -f init.mk p=MiJuego e=1
#      make -f init.mk p=MiJuego e=1 c=0
# =============================================================================

# --- Configuración de Parámetros ---
p ?= main
e ?= 0
c ?= 1
PROJECT ?= $(p)
EMPTY ?= $(e)
COMPILE ?= $(c)

# --- Detección de Modos de Origen ---
ifeq ($(EMPTY), 1)
	SOURCES_NAME = _xxx_EMPTY
else
	SOURCES_NAME = _xxx_
endif

TARGET_DIR = /projects/$(PROJECT)
BASE_SOURCES = /base/$(SOURCES_NAME)

# --- Rutas y Directorios ---
ASM2SMS_DIR  = ASM2SMS
SRC_DIR      = src
BIN_DIR      = bin
LIB_DIR      = lib
INC_DIR1     = ./inc;./assets/music;./assets/sounds;./assets/sprites;./assets/bg;./assets/fonts;./src
INC_DIR      = -I./inc -I./assets/music -I./assets/sounds -I./assets/sprites -I./assets/bg -I./assets/fonts -I./src
INC_DIR1_ASM2SMS = ../inc;../assets/music;../assets/sounds;../assets/sprites;../assets/bg;../assets/fonts;../src
INC_DIR_ASM2SMS  = -I../inc -I../assets/music -I../assets/sounds -I../assets/sprites -I../assets/bg -I../assets/fonts -I../src
CRT_S        = crt0sms
TOOLS_DIR    = tools
CHECKSUMFIX  = checksumfix/checksumfix.py


# --- Detección Automática del Sistema Operativo ---
ifeq ($(OS),Windows_NT)
	# --- Configuración para Windows ---
	DETECT_OS = Windows
	WHERE_CMD = where
	_MKDIR = if not exist "$(1)" mkdir "$(1)"
	# Convierte barras normales a invertidas solo si es necesario para comandos nativos de Windows
	CP_DIR = if not exist "$(2)" xcopy "$(1)" "$(2)" /E /I /Y >nul
	_RM_DIR = if exist "$(1)" rmdir /S /Q "$(1)"
	
	# Comprobación de binarios
	SDCC_CHECK := $(shell where sdcc 2>nul)
	MAKE_CHECK := $(shell where make 2>nul)
else
	# --- Configuración para Linux / macOS ---
	# $(shell uname -s)
	DETECT_OS = Linux
	WHERE_CMD = which
	_MKDIR = mkdir -p "$(1)"
	CP_DIR = if [ ! -d "$(2)" ]; then cp -r "$(1)/." "$(2)"; fi
	_RM_DIR = rm -rf "$(1)"
	
	# Comprobación de binarios
	SDCC_CHECK := $(shell which sdcc 2>/dev/null)
	MAKE_CHECK := $(shell which make 2>/dev/null)
endif

.PHONY: all check_tools create_project rename_source build_files compile_check

# Objetivo Principal
all: check_tools create_project rename_source build_files compile_check

# 1. Validar herramientas del sistema
check_tools:
	@echo [INFO.1] Sistema operativo detectado: $(DETECT_OS)
ifeq ($(SDCC_CHECK),)
	@echo [ERROR] Lo siento, pero no se detecta el compilador "SDCC" en el PATH.
	@exit 1
else
	@echo [INFO.2] Compilador "SDCC" detectado.
endif
ifeq ($(MAKE_CHECK),)
	@echo [ERROR] Lo siento, pero no se detecta la orden "MAKE" en el PATH.
	@exit 1
else
	@echo [INFO.3] Orden "MAKE" detectada.
endif

# 2. Clonar estructura del proyecto base
# @$(call _MKDIR,$(TARGET_DIR))
# @$(call CP_DIR,$(BASE_SOURCES),$(TARGET_DIR))
# if not exist "$(TARGET_DIR)" mkdir "$(TARGET_DIR)" 
create_project:
	@echo Copying files to '$(TARGET_DIR)' ...
ifeq ($(wildcard $(TARGET_DIR)/),)
	cp -r "$(BASE_SOURCES)" "/projects"
	-mv -u "/projects/$(SOURCES_NAME)" "$(TARGET_DIR)"
    _PROJECT_CREATED:=1
else
	@echo [INFO.4] NO es necesaria la copia, ya existia con anterioridad ...
endif

# 4. Renombrar archivo fuente principal
rename_source:
	@echo "Renombrando: '$(TARGET_DIR)/$(SRC_DIR)/$(SOURCES_NAME).c' a '$(PROJECT).c'."
ifeq ($(wildcard $(TARGET_DIR)/$(SRC_DIR)/$(PROJECT).c),)
	-mv "$(TARGET_DIR)/$(SRC_DIR)/$(SOURCES_NAME).c" "$(TARGET_DIR)/$(SRC_DIR)/$(PROJECT).c"
else
	@echo [INFO.5] "'$(SOURCES_NAME).c' ya se encontraba renombrado."
endif

# 5. Generar los archivos dinámicos de configuración
build_files:
# Generar PROJECT_NAME.txt
	@echo Generando archivos de configuracion en el destino...
	@echo "#############" > "$(TARGET_DIR)\PROJECT_NAME.txt"
	@echo ";NO-TOCAR ! : CODIFICACION: ASCII, LINEA 1: NOMBRE DEL PROJECTO, LINEA 2: DIRECTORIO DE LOS BINARIOS" >> "$(TARGET_DIR)\PROJECT_NAME.txt"
	@echo "$(PROJECT)" >> "$(TARGET_DIR)\PROJECT_NAME.txt"
	@echo "$(BIN_DIR)" >> "$(TARGET_DIR)\PROJECT_NAME.txt"
# Generar FilenameMake
	@echo "#############" > "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "#  PROJECT  #" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "#############" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "F ?= $(PROJECT)" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo FILE_NAME := '$$(F)' >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "SRC_DIR := ." >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "BIN_DIR := ." >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "LIB_DIR := ../$(LIB_DIR)" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "CRT_S := $(CRT_S)" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "TOOLS_DIR := ../$(TOOLS_DIR)" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "CHECKSUMFIX := $(CHECKSUMFIX)" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "INC_DIR := $(INC_DIR_ASM2SMS)" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
	@echo "INC_DIR1 := $(INC_DIR1_ASM2SMS)" >> "$(TARGET_DIR)\$(ASM2SMS_DIR)\FilenameMake"
# Generar ProjectNameMake
	@echo "##############" > "$(TARGET_DIR)\ProjectNameMake"
	@echo "#   PROJECT  #" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "##############" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "PROJECT_NAME ?= $(PROJECT)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "SRC_DIR := $(SRC_DIR)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "BIN_DIR := $(BIN_DIR)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "LIB_DIR := $(LIB_DIR)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "CRT_S := $(CRT_S)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "TOOLS_DIR := $(TOOLS_DIR)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "CHECKSUMFIX := $(CHECKSUMFIX)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "INC_DIR := $(INC_DIR)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo "INC_DIR1 := $(INC_DIR1)" >> "$(TARGET_DIR)\ProjectNameMake"
	@echo ""
	@echo Proceso de inicializacion finalizado para '$(PROJECT)'.

# 6. Lanzar la primera compilación de validación
compile_check:
ifeq ($(COMPILE),1)
	@echo Compilando: Iniciando proceso de compilacion para '$(PROJECT)'.
	@cd $(TARGET_DIR) && make valid
else
	@echo "[INFO.2] NO Compilado. Ejecutar desde el interprete -- cd $(TARGET_DIR) && make valid --"
endif
