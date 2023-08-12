# Read/write file in MIPS assembly

This repository contains basic functions for handling MIPS assembly files. This repository was made for the purpose of practicing and understanding the structure of functions in assembly mips.

This program contains the following functions:

``open_file`` This function opens the second file in the specified opening mode. As parameters in register $a0 must be the path of the file and register $a1 must be in reading mode. This function returns in the register $v0 the file descriptor.

``read_file`` This function receives the file descriptor in register $a0 and internally uses registers $a1 and $a2. The first register is used to store the address in memory from where the next results can be stored and the second register indicates the number of elements that can be stored. In the case of this program, 1024 elements were chosen as the maximum reading size.

``write_file`` To use this function, you must have previously opened the file in write mode. A space must be created in memory to store the message that will be written to the file. In this case the address of the memory space is in the label message and must be passed for register $a1. You must also know the size of the message to write to the file and attribute that value to record $a2. This function receives as parameters the file descriptor in register $a0.

``close_file`` This function receives the file descriptor as a parameter. The purpose of this function, as the name says, is to close the connection with the file.

An interesting aspect of the created functions is that they can call other functions within their pois, this is to safeguard the context.

Here I leave a very useful link for the development of applications based on the mips assembly language. For example in the function close_file

```assembly
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
```
First we must make space on the stack to save all the records. Among this record, $ra stands out, which contains the address from where the function was called. With this record we managed to return from where we were called. That is, if we called another function inside file_close, the $ra would change, but we managed to restore it because we saved it on the stack.

At the end of the execution we do the pop, that is, leave all the registers as we found them at the beginning of the execution of the function.

[Official MARS Documentation] https://courses.missouristate.edu/kenvollmar/mars/Help/Help_4_1/SyscallHelp.html
