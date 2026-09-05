##################
#     C a SMS   #
#################

# ARCHIVO MAKE PARA SDCC PARA CREAR *.sms PARA LA MASTER SYSTEM (by GuerraTron26)
# ESTA PREPARADO PARA UNA ESTRUCTURA DE DIRECTORIOS TIPICA: "src, bin, lib, inc" PARA NO ENSUCIAR EL DIRECTORIO PRINCIPAL.
# REQUISITOS: DEBE EXISTIR EL "startup" (crt0sms.s) Y UN *.c, ademas de SDCC, SDAS, la orden Make y python 
# ESCRIBIR EL NOMBRE DEL PROYECTO EN "PROJECT_NAME"

# PUEDE EJECUTARSE MEJOR SI SE DESEA EL "compile.bat" QUE YA REALIZA TODAS LAS ACCIONES NECESARIAS Y LIMPIA TODO.

# llama al archivo generado dinamicamente por "c2sms.bat" e
# incluye las variables necesarias para compilar
include PreMakefile

.PHONY: clean valid total


${PROJECT_NAME}.sms: ${PROJECT_NAME}.ihx
	${OBJCOPY} -I ihex -O binary ./${BIN_DIR}/${PROJECT_NAME}.ihx ./${BIN_DIR}/${PROJECT_NAME}.sms -L ./${LIB_DIR}
	# 3. Calcular e inyectar el Checksum automaticamente sobre el binario
	python ./${TOOLS_DIR}/${CHECKSUMFIX} ./${BIN_DIR}/${PROJECT_NAME}.sms

${PROJECT_NAME}.ihx: ${CRT_S}.rel ${OBJECTS}
	${SDCC} ${CFLAGS} --data-loc 0xC000 --no-std-crt0 -o ./${BIN_DIR}/${PROJECT_NAME}.ihx ./${BIN_DIR}/${CRT_S}.rel ${OBJECTS} -L ./${LIB_DIR}

#%.rel: %.c
$(BIN_DIR)/%.rel: $(SRC_DIR)/%.c
	${SDCC} ${CFLAGS} -o $@ -c $< -L ./${LIB_DIR}

${CRT_S}.rel: ./${LIB_DIR}/${CRT_S}.s
	${SDAS} -o ./${BIN_DIR}/${CRT_S}.rel ./${LIB_DIR}/${CRT_S}.s
    
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