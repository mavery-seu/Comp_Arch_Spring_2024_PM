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
TARGETS := analysis1 analysis2 analysis3 additional_analysis1 additional_analysis2 additional_analysis3 debugging1 debugging2 debugging3 additional_debugging1 additional_debugging2 additional_debugging3 factorial fib skeleton
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

analysis1: $(DEP)
analysis2: $(DEP)
analysis3: $(DEP)

additional_analysis1: $(DEP)
additional_analysis2: $(DEP)
additional_analysis3: $(DEP)

debugging1: $(DEP)
debugging2: $(DEP)
debugging3: $(DEP) main_debugging3.o

additional_debugging1: $(DEP)
additional_debugging2: $(DEP)
additional_debugging3: $(DEP)

factorial: $(DEP)
fib: $(DEP)

skeleton: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

analysis1.o: asm_io.inc
analysis2.o: asm_io.inc
analysis3.o: asm_io.inc

additional_analysis1.o: asm_io.inc
additional_analysis2.o: asm_io.inc
additional_analysis3.o: asm_io.inc

debugging1.o: asm_io.inc
debugging2.o: asm_io.inc
debugging3.o: asm_io.inc

additional_debugging1.o: asm_io.inc
additional_debugging2.o: asm_io.inc
additional_debugging3.o: asm_io.inc

factorial.o: asm_io.inc
fib.o: asm_io.inc

skeleton.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
