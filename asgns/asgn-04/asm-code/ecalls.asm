	.globl printint, printstring, printchar, readint, readchar, readstring, exit0 # declare global symbols
	.text # start of the code section
	
	# Subroutine to print a given integer
# Inputs: a0 - the integer to print
printint:
	li a7, 1 # syscall code for printing an integer
	ecall # execute the syscall
	ret # return to caller
	# end subroutine
	
	# Subroutine to print a given string
# Inputs: a0 - the address of the string to print
printstring:
	li a7, 4 # syscall code for printing a string
	ecall # execute the syscall
	ret # return to caller
	# end subroutine
	
	# Subroutine to print a given character
# Inputs: a0 - the character to print
printchar:
	li a7, 11 # syscall code for printing a character
	ecall # execute the syscall
	ret # return to caller
	# end subroutine
	
	# Subroutine to read an integer
# Outputs: a0 - the integer that was read
readint:
	li a7, 5 # syscall code for reading an integer
	ecall # execute the syscall
	ret # return to caller
	# end subroutine
	
	# Subroutine to read a character
# Outputs: a0 - the integer that was read
readchar:
	li a7, 12 # syscall code for reading a character
	ecall # execute the syscall
	ret # return to caller
	# end subroutine
	
	# Subroutine to read a string
# Outputs: a0 - the string that was read
readstring:
	li a7, 8 # syscall code for reading a character
	ecall # execute the syscall
	ret # return to caller
	# end subroutine
	
	# Subroutine to exit the program
exit0:
	li a7, 10 # syscall code for exiting the program
	ecall # execute the syscall
	# exit the program
