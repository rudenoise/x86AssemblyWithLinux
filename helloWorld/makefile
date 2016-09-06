all: hello.out

hello.out: hello.o
	ld hello.o -o hello.out

hello.o: hello.asm
	as hello.asm -o hello.o

clean:
	rm hello.o hello.out
