all: exit.out

exit.out: exit.o
	ld exit.o -o exit.out

exit.o: exit.asm
	as exit.asm -o exit.o

clean:
	rm exit.o exit.out
