SDCC=c:/DEVELOP/SDCC/bin/sdcc
SDAS=c:/DEVELOP/SDCC/bin/sdasz80
CXX=g++
OBJCOPY=objcopy
CFLAGS=-mz80
SOURCES=_main.c
OBJECTS=${SOURCES:.c=.rel}

_main.sms: _main.ihx
	${OBJCOPY} -I ihex -O binary _main.ihx _main.sms

_main.ihx: crt0sms.rel ${OBJECTS}
	${SDCC} ${CFLAGS} --data-loc 0xC000 --no-std-crt0 -o _main.ihx crt0sms.rel ${OBJECTS}

%.rel: %.c
	${SDCC} ${CFLAGS} -c -o $@ $<

crt0sms.rel: crt0sms.s
	${SDAS} -o crt0sms.rel crt0sms.s

clean:
	rm -f *.sym *.asm *.rel *.lst *.ihx *.lk *.map *.mem *.noi *.rst *.bin *.sms

valid:
	rm -f *.sym *.rel *.lst *.ihx *.lk *.map *.mem *.noi *.rst *.bin
