#########################
# ENSAMBLADOR ASM a SMS #
#########################

# ARCHIVO MAKE PARA SDCC PARA CREAR *.sms PARA LA MASTER SYSTEM (by GuerraTron26)

# ESTE MAKEFILE SE HA PENSADO PARA CONSTRUIR UN *.sms DESDE UN ÚNICO *.asm QUE DEBE EXISTIR CON ANTERIORIDAD
# ESTO PERMITE MODIFICAR EL asm Y LUEGO COMPILARLO EN sms, OSEA, ESTÁ ORIENTADO A PROGRAMADORES DE "ENSAMBLADOR".
# REQUISITOS: DEBE EXISTIR EL "startup" (crt0sms.s) Y UN *.asm 
# PUEDE DARSE UN NOMBRE CONCRETO A "FILE_NAME" (EN "FilenameMake"), SINO, DETECTARA EL PRIMER ARCHIVO ".asm" QUE ENCUENTRE [FALLA!, MEJOR ASIGNAR EL NOMBRE]

# ESTA PREPARADO PARA UN SOLO ARCHIVO Y UNA ESTRUCTURA DE DIRECTORIOS TIPICA: "lib, inc" PARA NO ENSUCIAR EL DIRECTORIO PRINCIPAL.

include PreMakefile

# Las siguientes líneas son obligatorias para evitar que Make intente 
# interpretar los argumentos como nombres de otros targets (objetivos)
%:
	@:

# Crear directorio obj si no existe
$(BIN_DIR):
	$(info $(shell mkdir -p $(BIN_DIR)))
	mkdir -p $(BIN_DIR)

# convierte *.ihx en *.sms
${FILE_NAME}.sms: ${FILE_NAME}.ihx
	${OBJCOPY} -I ihex -O binary ./${BIN_DIR}/${FILE_NAME}.ihx ./${BIN_DIR}/${FILE_NAME}.sms -L ./${LIB_DIR}
	# 3. Calcular e inyectar el Checksum automaticamente sobre el binario
	python ./${TOOLS_DIR}/${CHECKSUMFIX} ./${BIN_DIR}/${FILE_NAME}.sms

# crea el binario *.ihx
${FILE_NAME}.ihx: ${CRT_S}.rel ${OBJECTS}
	${SDCC} ${CFLAGS} --data-loc 0xC000 --no-std-crt0 -o ./${BIN_DIR}/${FILE_NAME}.ihx ./${BIN_DIR}/${CRT_S}.rel ${OBJECTS} -L ./${LIB_DIR} -lz80

# crea el *.rel desde un *.asm [MUY IMPORTANTE la opcion -g, sino seguramente fallara con "undefined symbol"]
${FILE_NAME}.rel: ${FILE_NAME}.asm
	@echo "El archivo objetivo es: '$(FILE_NAME)'"
	${SDAS} -g -o ${FILE_NAME}.rel ${FILE_NAME}.asm

#${FILE_NAME}.asm:
#	${SDCC} ${CFLAGS} -S ${FILE_NAME}.c

# convierte todos los *.c en *.rel
#%.rel: %.c
#	${SDCC} ${CFLAGS} -o $@ -c $< -L ./${LIB_DIR}

# crea el crt0sms.rel (desde el crt0sms.s)
${CRT_S}.rel: ./${LIB_DIR}/${CRT_S}.s
	${SDAS} -o ${CRT_S}.rel ./${LIB_DIR}/${CRT_S}.s

# limpia todo lo generado
clean:
	cd ./${BIN_DIR}/ && rm -f *.sym *.asm *.rel *.lst *.ihx *.lk *.map *.mem *.noi *.rst *.bin *.sms && cd ..

# genera y limpia todo excepto los *.asm y *.sms (si no hay cambios no genera nada nuevo)
valid:
	make
	cd ./${BIN_DIR}/ && rm -f *.sym *.rel *.lst *.ihx *.lk *.map *.mem *.noi *.rst *.bin && cd ..

# limpia antes de generar nada (obliga a que se genere todo de nuevo, haya cambios o no)
total: clean
	make

view: ; @echo ${VPATH}