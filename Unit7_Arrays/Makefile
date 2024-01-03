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
TARGETS := array1 array_ops arrays_as_params memex skeleton two_d_arrays
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

array1: array1c.o

arrays_as_params: $(DEP)

skeleton: $(DEP)

two_d_arrays: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

array_ops: main_array_ops.o asm_io.o

arrays_as_params.o: asm_io.inc

memex: memory.o

skeleton.o: asm_io.inc

two_d_arrays.o: asm_io.inc

clean :
	rm -f *.o $(TARGETS)
