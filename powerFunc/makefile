all: powerFunc.out

powerFunc.out: powerFunc.o
	ld powerFunc.o -o powerFunc.out

powerFunc.o: powerFunc.asm
	as powerFunc.asm -o powerFunc.o

clean:
	rm powerFunc.o powerFunc.out
