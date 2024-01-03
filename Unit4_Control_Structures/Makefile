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
TARGETS := conditionals_exercises loops_exercises max number_guessing_game prime skeleton
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

conditionals_exercises: $(DEP)

loops_exercises: $(DEP)

max: $(DEP)

number_guessing_game: $(DEP)

prime: $(DEP)

skeleton: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

conditionals_exercises.o: asm_io.inc

loops_exercises.o: asm_io.inc

max.o: asm_io.inc

number_guessing_game.o: asm_io.inc

prime.o: asm_io.inc

skeleton.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
