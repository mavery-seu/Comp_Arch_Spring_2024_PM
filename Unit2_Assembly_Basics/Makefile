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
TARGETS := skeleton part1_exercises part2_exercises sum_example
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

skeleton: $(DEP)

part1_exercises: $(DEP)

part2_exercises: $(DEP)

sum_example: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

skeleton.o: asm_io.inc

part1_exercises.o: asm_io.inc

part2_exercises.o: asm_io.inc

sum_example.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
