# file manager

	.data
message:.asciiz "hello world"
path:	.asciiz "path to file"
buffer:	.space	1024
	.text

main:
	la 	$a0, path
	li	$a1, 1			# this register indicates the opening mode: 0 for reading and 1 for writing
	jal	open_file
	move	$s0, $v0		# this record contains the file descriptor
	
	move	$a0, $s0	
	jal	write_file
	
	la	$a0, 0($s0)
	jal	close_file
	
	la 	$a0, path
	li	$a1, 0			# this register indicates the opening mode: 0 for reading and 1 for writing
	jal	open_file
	move	$s0, $v0		# this record contains the file descriptor
	
	move	$a0, $s0	
	jal	read_file
	
	la	$a0, buffer
	jal	printf
							
	la	$a0, 0($s0)
	jal	close_file
exit:
	li 	$v0, 10         	# $v0 = 10, system call for exit
	syscall				# exit

# (file descriptor) open_file(path,mode)
# This function returns in the record $v0 the writer of the file
open_file:
 	# push
	addi 	$sp,$sp, -16		# space in stack 4 words
	sw 	$ra, 12($sp) 		# save ret addr
	sw 	$a0, 8($sp) 		# save the path to the file
	sw 	$a1, 4($sp) 		# save file opening mode
	
	# body
	li	$v0, 13			# ask the system to open the file
	syscall
	
	# pop
	lw	$a1, 4($sp) 		# get file opening mode
	lw 	$a0, 8($sp) 		# get the path to the file
	lw 	$ra, 12($sp) 		# get the ret addr
	addi	$sp, $sp, 16 		# free stack
	jr 	$ra			# jump to caller
	
read_file:
	# push
	addi 	$sp,$sp, -12		# space in stack 3 words
	sw 	$ra, 8($sp) 		# save ret addr
	sw 	$a0, 4($sp) 		# save the file descriptor
	
	# body
	li	$v0, 14			# ask the system to open the file
	la	$a1, buffer		# buffer address
	li	$a2, 1024		# buffer size
	syscall
	
	# pop
	lw 	$a0, 4($sp) 		# get the file descriptor
	lw 	$ra, 8($sp) 		# get the ret addr
	addi	$sp, $sp, 12 		# free stack
	jr	$ra			# jump to caller
	
write_file:
	# push
	addi 	$sp,$sp, -12		# space in stack 3 words
	sw 	$ra, 8($sp) 		# save ret addr
	sw 	$a0, 4($sp) 		# save the file descriptor
	
	# body
	li	$v0, 15
	la	$a1, message
	li	$a2, 14
	syscall
	
	# pop
	lw 	$a0, 4($sp) 		# get the file descriptor
	lw 	$ra, 8($sp) 		# get the ret addr
	addi	$sp, $sp, 12 		# free stack
	jr	$ra			# jump to caller

# void close_file(file descriptor)
close_file:
	# push
	addi 	$sp,$sp, -12		# space in stack 3 words
	sw 	$ra, 8($sp) 		# save ret addr
	sw 	$a0, 4($sp) 		# save the file descriptor
	
	# body
	li	$v0, 16			# ask the system to close the file
	syscall
	
	# pop
	lw 	$a0, 4($sp) 		# get the file descriptor
	lw 	$ra, 8($sp) 		# get the ret addr
	addi	$sp, $sp, 12 		# free stack
	jr	$ra			# jump to caller


printf:
	li	$v0, 4			# system call to print string
	syscall
