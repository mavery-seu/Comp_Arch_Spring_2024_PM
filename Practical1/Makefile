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
TARGETS := additional_analysis1 additional_analysis2 additional_analysis3 additional_debugging1 additional_debugging2 analysis2 analysis3 analysis4 debugging2 debugging3 debugging4 skeleton
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

additional_analysis1: $(DEP)
additional_analysis2: $(DEP)
additional_analysis3: $(DEP)

additional_debugging1: $(DEP)
additional_debugging2: $(DEP)

analysis2: $(DEP)
analysis3: $(DEP)
analysis4: $(DEP)

debugging2: $(DEP)
debugging3: $(DEP)
debugging4: $(DEP)

skeleton: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

additional_analysis1.o: asm_io.inc
additional_analysis2.o: asm_io.inc
additional_analysis3.o: asm_io.inc

additional_debugging1.o: asm_io.inc
additional_debugging2.o: asm_io.inc

analysis2.o: asm_io.inc
analysis3.o: asm_io.inc
analysis4.o: asm_io.inc

debugging2.o: asm_io.inc
debugging3.o: asm_io.inc
debugging4.o: asm_io.inc

skeleton.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
