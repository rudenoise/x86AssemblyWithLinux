.global	_start

.text
_start:
	# eax -> edx and edi and esi
	# are general purpose registers

	movl  $4, %eax		# set a 4/write system call
										# when an interrupt is sent
										# (with the syscall vector id)
										# eax is checked for the system call
										# 4:	write means write-to-file
										#			in this case
										#
										#			ebx must contain the file descriptor
										#			ecx must contain the buffer start
										#			edx must contain the buffer size/length
										#
	movl  $1, %ebx		# set file descriptor
										#     in this case
										#				1 is the stdout file
										#			0 would be stdin
										#			2 would be stderr

	movl  $msg, %ecx	# set buffer start
	movl  $len, %edx	# set buffer length

	int   $0x80				# wake up the kernel and run
										# acknowledges syustem call id
										# eax = 4 -> write

	movl  $1, %eax		# set a 1/exit system call id
										#		ebx mustr contain status/exit code

	movl  $0, %ebx		# set status code
										# 0 = success

	int	$0x80					# this wakes up the kernel
										# send interrupt
										# system call of 1/exit will be found
										# exit code of 0/success will return

.data
msg:
	.ascii  "Hello, world!\n"
	len =   . - msg
