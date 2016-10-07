all: powerFunc.out

powerFunc.out: powerFunc.o
	ld powerFunc.o -m elf_i386 -o powerFunc.out

powerFunc.o: powerFunc.asm
	as powerFunc.asm --32 -o powerFunc.o

clean:
	rm powerFunc.o powerFunc.out
