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
TARGETS := bitwise_exercises bit_twiddling_exercises integers_exercises math skeleton shifts_exercises
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

bitwise_exercises: $(DEP)

bit_twiddling_exercises: $(DEP)

integers_exercises: $(DEP)

math: $(DEP)

skeleton: $(DEP)

shifts_exercises: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

bitwise_exercises.o: asm_io.inc

bit_twiddling_exercises.o: asm_io.inc

integers_exercises.o: asm_io.inc

math.o: asm_io.inc

skeleton.o: asm_io.inc

shifts_exercises.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
