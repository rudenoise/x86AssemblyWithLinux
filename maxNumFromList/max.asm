# _max_ is a program to find the largest number in a sequence of
# numbers and return it

# the data
.section .data
	data_items:
		# use single ints to make ascii converson easy
		.long 1,2,3,4,5,6,7,8,9,0
	maximum:
		# 48 is ascii 0, this will be overwritten
		.byte 48

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
	je to_ascii
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

to_ascii:
	# add 48 to the number to bring it into ascii range
	addl $48, %ebx
	# put largest number into memory
	movl %ebx, maximum
	jmp write_out

write_out:
	# set syscall id for write to file
	movl $4, %eax
	# set stdout as the destination file
	movl $1, %ebx
	# set buffer start
	movl $maximum, %ecx
	# set buffer length to one byte
	movl $1, %edx
	# send interput
	int $0x80
	jmp the_end

the_end:
	# set status code
	movl  $0, %ebx
	# id 1 is the exit system call id
	movl $1, %eax
	# send interrupt
	int $0x80

