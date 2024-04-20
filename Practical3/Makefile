# Linux makefile
# Use with make 
#

AS		:= nasm
ASFLAGS := -f elf -F dwarf
CFLAGS	:= -m32
LDFLAGS := -m32
CC		:= gcc
CXX		:= g++
CXXFLAGS := -m32
TARGETS := analysis1 analysis2 additional_analysis1 additional_analysis2 debugging1 debugging2 additional_debugging1 skeleton
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

analysis1: $(DEP)
analysis2: main_analysis2.o

additional_analysis1: $(DEP)
additional_analysis2: $(DEP)

debugging1: $(DEP)
debugging2: $(DEP)

additional_debugging1: main_additional_debugging1.o asm_io.o

skeleton: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

analysis1.o: asm_io.inc

additional_analysis1.o: asm_io.inc
additional_analysis2.o: asm_io.inc

debugging1.o: asm_io.inc
debugging2.o: asm_io.inc

skeleton.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
