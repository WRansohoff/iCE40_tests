# Simple Makefile for the Icestorm FPGA toolchain.
TARGET = main
BOARD  = icestick

SYNTH  = yosys
PNR    = arachne-pnr
BIN    = icepack
PROG   = iceprog

.PHONY: all
all: $(TARGET).bin

%.blif: %.v
	$(SYNTH) -p "synth_ice40 -blif $(TARGET).blif" $(TARGET).v

%.txt: %.blif
	$(PNR) -r -d 1k -p $(BOARD).pcf $(TARGET).blif -o $(TARGET).txt

%.bin: %.txt
	$(BIN) $(TARGET).txt $(TARGET).bin

.PHONY: clean
clean:
	rm -f $(TARGET).bin
	rm -f $(TARGET).txt
	rm -f $(TARGET).blif

.PHONY: flash
flash:
	$(PROG) $(TARGET).bin
