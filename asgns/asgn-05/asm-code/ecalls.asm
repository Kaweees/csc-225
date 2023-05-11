	.globl printint, printstring, printchar, readint, readchar, clearstring, readstring, exit0, return_len, return_address # declare global symbols

  .data # start of the data section
	return_address: .word -1 # return address for when subroutines are called
	return_len: .word -1 # return value for when subroutines are called
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

	# Subroutine to clear a string
# Inputs: a0 - the address of the string to read into, a1 - the length of the string
clearstring:
  la t0, return_address
  sw ra, 0(t0) # save the return address
  
	mv t0, a0 # t0 = a0
	mv t1, a1 # incremented address size
	mv t2, a1 # len
	li t3, 0 # i = 0
while:
	addi t1, t1, 1
	addi, t3, t3, 1
	beq t2, t3, end_while # if string[i] == 0, goto end_while
	sb x0, 0(t0) # store character in string
	j while # goto while
end_while:
  la t0, return_address
  lw ra, 0(t0) # restore the return address
	jr ra # return to address called from + 4
	# end subroutine

	# Subroutine to read a string
# Inputs: a0 - the address of the string to read into
readstring:
  la t0, return_address
  sw ra, 0(t0) # save the return address

	mv t0, a0 # save the address of the string
	li t1, 10 # t2 = "\n"
loop:
	jal readchar
	beq a0, t1, endloop # If char = "\n", exit loop
	sb a0, 0(t0) # store character in string
	addi, t0, t0, 1 # increment address by 1
	b loop
endloop:
	sb x0, 0(t0)
  la t0, return_address
  lw ra, 0(t0) # restore the return address
	jr ra # return to address called from + 4
	# end subroutine

	# Subroutine to exit the program
exit0:
	li a7, 10 # syscall code for exiting the program
	ecall # execute the syscall
	# exit the program
