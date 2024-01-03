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
TARGETS := cake emoji_subprograms number_operations skeleton stack sub1 sub2 sub3 sub4
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

cake: $(DEP)

emoji_subprograms: $(DEP)

number_operations: $(DEP)

skeleton: $(DEP)

stack: $(DEP)

sub1: $(DEP)

sub2: $(DEP)

sub3: $(DEP)

sub4: $(DEP) main4.o

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

cake.o: asm_io.inc

emoji_subprograms.o: asm_io.inc

number_operations.o: asm_io.inc

skeleton.o: asm_io.inc

stack.o: asm_io.inc

sub1.o: asm_io.inc

sub2.o: asm_io.inc

sub3.o: asm_io.inc

sub4.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
