all: max.out

max.out: max.o
	ld max.o -o max.out

max.o: max.asm
	as max.asm -o max.o

clean:
	rm max.o max.out
