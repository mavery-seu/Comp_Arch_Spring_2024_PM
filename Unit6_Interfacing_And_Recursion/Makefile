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
TARGETS := binary c_functions factorial fib skeleton sub5 taking_in_strings
DEP := driver.o asm_io.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS)

binary: main_binary.o asm_io.o

c_functions: $(DEP)

factorial: $(DEP)

fib: $(DEP)

skeleton: $(DEP)

sub5: main5.o asm_io.o

taking_in_strings: $(DEP)

asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

c_functions.o: c_functions.asm 
	$(AS) $(ASFLAGS) -d ELF_TYPE c_functions.asm

factorial.o: asm_io.inc

fib.o: asm_io.inc

skeleton.o: asm_io.inc

taking_in_strings.o: taking_in_strings.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE taking_in_strings.asm

clean :
	rm -f *.o $(TARGETS)
