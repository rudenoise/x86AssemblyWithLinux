# _max_ is a program to find the largest number in a sequence of
# numbers and return it

# the data
.section .data
	data_items:
		.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
	maximum:
		.short 0
		len = . - maximum

.section .text

.globl _start

_start:

	# edi to hold current position in list
	movl $0, %edi

	# eax to hold current element being examined
	# take the first byte of data from data_items
	# and load it into eax
	movl data_items(,%edi,4), %eax

	# ebx to hold current highest value in list
	# the first element from eax is the highest, so far
	# load it into ebx
	movl %eax, %ebx

start_loop:
	# we consider 0 to mark the end of the list
	# check if the current element (eax) is 0
	cmpl $0, %eax
	# if it is 0 then exit loop
	je loop_exit
	# otherwise load the next value
	# move the current position (edi) on by one
	incl %edi
	# move that position from the list into current-item
	# eax)
	movl data_items(,%edi,4), %eax
	# conpare current item (eax) to current highest (ebx)
	cmpl %ebx, %eax
	# if ebx is still highest jump to beginging of loop
	jle start_loop
	# otherwise make current-item (eax) the highest (ebx)
	movl %eax, %ebx
	# then start the loop again
	jmp start_loop

loop_exit:
	# put largest number into memory
	movl %ebx, maximum
	# set syscall id for write to filr
	movl $4, %eax
	# set stdout as the destination file
	movl $1, %ebx
	# set buffer start
	movl $maximum, %ecx
	# set buffer length to one byte
	movl $len, %edx
	# send interput
	int $0x80
	# set status code
	movl  $0, %ebx
	# id 1 is the exit system call id
	movl $1, %eax
	# send interrupt
	int $0x80
