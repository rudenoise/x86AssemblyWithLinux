all: hello.out

hello.out: hello.o
	ld hello.o -o hello.out

hello.o: hello.s
	as hello.s -o hello.o


     
clean:
	rm hello.o hello.out
