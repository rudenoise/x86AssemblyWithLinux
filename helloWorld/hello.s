.global	_start

.text
_start:
		    # eax -> edx and edi and esi
		    # are general purpose registers

    movl  $4, %eax  # we'll be using 4 registers?
		    # 4 means running?
		    # 4 means print ascii chars in ecx
		    # until len/edx?

    movl  $1, %ebx  # set default error status code?
		    # returned if the following fails?

    movl  $msg, %ecx # put msg in ecx
    movl  $len, %edx # put length of message in edx

    int   $0x80	    # wake up the kernel and run
		    # acknowledges status code of
		    # eax = 4, running?

    movl  $1, %eax  # this is the linux kernel
		    # command number (system call)
		    # for exiting a program

    movl  $0, %ebx  # this is the status number we
		    # will return to the operating
		    # system. Change this and it will
		    # return different things to
		    # echo $?

    int	$0x80	    # this wakes up the kernel to run
		    # the exit command
.data
msg:
    .ascii  "Hello, world!\n"
    len =   . - msg
