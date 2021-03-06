.code32
# powerFunc
# illustration of how functions work
# will compute
# 2^3 + 5^2

# no data, all in registers and stack
.section .data

.section .text

.globl _start

_start:
	# push second argument onto the stack
	pushl $3
	# push first argument onto the stack
	pushl $2
	# call the power function
	call power
	# move the stack pointer back
	addl $8, %esp

	# the answe is returned to eax
	# save the first answer
	pushl %eax

	# get ready for the next function call
	# push second argument onto the stack
	pushl $2
	# push the first argument onto the stack
	pushl $5
	# call the function
	call power
	# move the stack pointer back
	addl $8, %esp

	# the second answer is now in %eax
	# the first was saved to the stack
	# the stack was rolled back so
	# pop it into ebx
	popl %ebx

	# add them together
	addl %eax, %ebx
	# the result is in ebx

	# ebx doubles as the exit code
	# setup eax for the exit sys-call
	movl $1, %eax
	# call the os, with the interupt
	int $0x80

# PURPOSE:
# function to compute the the value of
# a number raised to a power

# INPUT:
# first arg: the base number
# second arg: the power to raise it to

# OUTPUT:
# will give the answer as a return value
# the power must be 1 or greater

# VARIABLES:
# ebx holds the base number
# ecx holds the power
# -4(%ebp) - holds the current result
# eax is used for temporary storage

.type power, @function

power:
	# save the old base pointer
	pushl %ebp
	# make the stack pointer the base pointer
	movl %esp, %ebp
	# get space one the stack for local storage
	subl $4, %esp

	# put the first arg in ebx
	movl 8(%ebp), %ebx
	# put second arg in ecx
	movl 12(%ebp), %ecx

	# store the current result
	movl %ebx, -4(%ebp)

power_loop_start:
	#compare the power to 1
	cmpl $1, %ecx
	# if match end
	je end_power
	# otherwise
	# move the current result into eax
	movl -4(%ebp), %eax
	# multiply the current number by the base
	imull %ebx, %eax
	# store the current result
	movl %eax, -4(%ebp)

	# decrease the power
	decl %ecx
	# run the next power
	jmp power_loop_start

end_power:
	# move return value to eax
	movl -4(%ebp), %eax
	# restore the stack pointer
	movl %ebp, %esp
	# restore the base pointer
	popl %ebp
	ret
	movl -4(%ebp), %eax
