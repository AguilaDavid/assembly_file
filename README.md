# Read/write file in MIPS assembly

This repository contains basic functions for handling MIPS assembly files. This repository was made for the purpose of practicing and understanding the structure of functions in assembly mips.

This program contains the following functions:

open_file: This function opens the second file in the specified opening mode. As parameters in register $a0 must be the path of the file and register $a1 must be in reading mode. This function returns in the register $v0 the file descriptor.

read_file: This function receives the file descriptor in register $a0 and internally uses registers $a1 and $a2. The first register is used to store the address in memory from where the next results can be stored and the second register indicates the number of elements that can be stored. In the case of this program, 1024 elements were chosen as the maximum reading size.

write_file: To use this function, you must have previously opened the file in write mode. A space must be created in memory to store the message that will be written to the file. In this case the address of the memory space is in the label message and must be passed for register $a1. You must also know the size of the message to write to the file and attribute that value to record $a2. This function receives as parameters the file descriptor in register $a0.

close_file: This function receives the file descriptor as a parameter. The purpose of this function, as the name says, is to close the connection with the file.

Here I leave a very useful link for the development of applications based on the mips assembly language.

https://courses.missouristate.edu/kenvollmar/mars/Help/Help_4_1/SyscallHelp.html
