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
TARGETS := accessing_stack_elements cake emoji_subprograms encode number_operations reverse_string skeleton stack sub1 sub2 sub3 sub4
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

accessing_stack_elements: $(DEP)

cake: $(DEP)

emoji_subprograms: $(DEP)

encode: $(DEP)

number_operations: $(DEP)

skeleton: $(DEP)

reverse_string: $(DEP)

stack: $(DEP)

sub1: $(DEP)

sub2: $(DEP)

sub3: $(DEP)

sub4: $(DEP) main4.o

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

accessing_stack_elements.o:asm_io.asm

cake.o: asm_io.inc

emoji_subprograms.o: asm_io.inc

encode.o: asm_io.inc

number_operations.o: asm_io.inc

reverse_string.o: asm_io.inc

skeleton.o: asm_io.inc

stack.o: asm_io.inc

sub1.o: asm_io.inc

sub2.o: asm_io.inc

sub3.o: asm_io.inc

sub4.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
