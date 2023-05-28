#!/bin/sh

AS	= ca65
LD	= ld65
DA  = da65 

ROM = ice_hockey
BIN	= $(ROM).nes

LDFLAGS = -C nes.cfg -m $(ROM).map
OBJDUMP = od65
DEBUGGER = mednafen

SS=$(wildcard *.s)
OBJS=$(SS:.s=.o)

all: $(BIN)

clean:
	rm -f $(BIN) && rm -f $(shell find . -name '*.o')
	rm -f *.map && rm -f *.dump && rm -f program.s && rm -f *.chr *.prg

extract:
	./tools/nesextract original.nes
	cd gfx && ../tools/sengo ../original.nes && rm -rf tile*.png
	cd ..

program:
	$(DA) --cpu 6502 --start-addr '$$8000' PRG.prg >| program.s

$(BIN): $(OBJS)
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.s
	$(AS) $< -o $@

run:
	$(DEBUGGER) $(BIN) 


