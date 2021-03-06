# _max_ is a program to find the largest number in a sequence of
# numbers and return it

# the data
.section .data
	data_items:
		.long 1,23,3,4,54321,1,6,7,8,9,0
	ascii_digits:
		# 48 is ascii 0, this will be overwritten
		.long 48

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
	# edi to hold current position in ascii list
	movl $0, %edi
	# set largest to be divend
	movl %ebx, %eax
	# set divisor
	movl $10, %ebx
	jmp ascii_loop

ascii_loop:
	# divide largest number by 10
	# set remainder to 0
	movl $0, %edx
	# do division
	divl %ebx
	# use the remainder to convert to ascii
	# add 48 to the number to bring it into ascii range
	addl $48, %edx
	# put ascii diget/byte into memory
	movl %edx, ascii_digits(,%edi,4)
	# move pos in array up
	incl %edi
	# compare result to 0
	cmpl $0, %eax
	# if 0 jump to write out
	je setup_reverse
	# otherwise loop
	jmp ascii_loop

setup_reverse:
	# set start index
	movl $0, %esi
	# save length for later
	movl %edi, %ecx
	# set end index
	decl %edi
	# reverse the array
	jmp reverse

reverse:
	# are the indecies at or passed the centre
	cmpl %edi, %esi
	# if yes write results
	jge write_out
	# otherwise swap
	# copy value at left index
	movl ascii_digits(,%esi, 4), %eax
	# copy value at right index
	movl ascii_digits(,%edi, 4), %ebx
	# overwrite value at right index with value from left
	movl %eax, ascii_digits(, %edi, 4)
	# overwrite value at left index with value from right
	movl %ebx, ascii_digits(, %esi, 4)
	# move left index to centre
	incl %esi
	# move right index to centre
	decl %edi
	# go again
	jmp reverse

write_out:
	movl %ecx, %esi
	# put line break \n into memory
	movl $'\n', ascii_digits(,%esi,4)
	# move pos in array up
	incl %esi
	# set syscall id for write to file
	movl $4, %eax
	# set stdout as the destination file
	movl $1, %ebx
	# set buffer start
	movl $ascii_digits, %ecx
	# set buffer length to 4 x edi (pos in array)
	imul $4, %esi, %edx
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

