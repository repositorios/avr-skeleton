# Name: Makefile
# Author: Renato Tavares
# Copyright: Renato Tavares <dr.renatotavares@gmail.com>
# License: MIT License

# DEVICE ....... The AVR device you compile for
# CLOCK ........ Target AVR clock rate in Hertz
# OBJECTS ...... The object files created from your source files. This list is
#                usually the same as the list of source files with suffix ".o".
# PROGRAMMER ... Options to avrdude which define the hardware you use for
#                uploading to the AVR and the interface where this hardware
#                is connected.
# FUSES ........ Parameters for avrdude to flash the fuses appropriately.
DEVICE     := atmega328p
CLOCK      := 16000000
PROGRAMMER := -P usb -c avrisp2 
OBJECTS    := main.o
FUSES      := -U lfuse:w:0x64:m -U hfuse:w:0xdd:m -U efuse:w:0xff:m

# Tune the lines below only if you know what you are doing:
AVRDUDE := avrdude -p $(DEVICE) $(PROGRAMMER) 
COMPILE := avr-gcc -Wall -Wextra -g -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE)
 
.PHONY : clean flash

all: main.hex

main.hex: main.elf
	rm -f main.hex
	avr-objcopy -j .text -j .data -O ihex main.elf main.hex


main.elf: $(OBJECTS)
	$(COMPILE) -o main.elf $(OBJECTS)

.c.o:
	$(COMPILE) -c $< -o $@

flash: main.hex
	$(AVRDUDE) -U flash:w:main.hex:i

clean:
	$(RM) main.elf
	$(RM) main.hex
	$(RM) main.o
