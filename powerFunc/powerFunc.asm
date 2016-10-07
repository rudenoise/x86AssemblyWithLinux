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
	pushq $3
	# push first argument onto the stack
	pushq $2
	# call the power function
	call power
	# move the stack pointer back
	addl $8, %esp

	# the answe is returned to eax
	# save the first answer
	pushq %rax

	# get ready for the next function call
	# push second argument onto the stack
	pushq $2
	# push the first argument onto the stack
	pushq $5
	# call the function
	call power
	# move the stack pointer back
	addq $8, %rsp

	# the second answer is now in %eax
	# the first was saved to the stack
	# the stack was rolled back so
	# pop it into ebx
	popq %rbx

	# add them together
	addq %rax, %rbx
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
	pushq %rbp
	# make the stack pointer the base pointer
	movq %rsp, %rbp
	# get space one the stack for local storage
	subq $4, %rsp

	# put the first arg in ebx
	movq 8(%rbp), %rbx
	# put second arg in ecx
	movq 12(%rbp), %rcx

	# store the current result
	movq %rbx, -4(%rbp)

power_loop_start:
	#compare the power to 1
	cmpq $1, %rcx
	# if match end
	je end_power
	# otherwise
	# move the current result into eax
	movq -4(%rbp), %rax
	# multiply the current number by the base
	imulq %rbx, %rax
	# store the current result
	movq %rax, -4(%rbp)

	# decrease the power
	decl %ecx
	# run the next power
	jmp power_loop_start

end_power:
	# move return value to eax
	movq -4(%rbp), %rax
	# restore the stack pointer
	movq %rbp, %rsp
	# restore the base pointer
	popq %rbp
	ret
	movq -4(%rbp), %rax
