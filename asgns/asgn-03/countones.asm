	.global main # main is a label that other programs and files can see.
	
	.data # this part (section) of the program is data
new_line: .string "\n"
msg_welcome: .string "Welcome to the CountOnes program." # Copy strings for input / output into memory
msg_enter: .string "\nPlease enter a number: "
msg_result: .string "The number of bits set is: "
msg_continue: .string "\nContinue (y/n)?: "
msg_exit: .string "\nExiting"
	
	.text # this part (section) of the program is code
main: # Make a label to say where our program should start from
	li t1, 'n' # constant to compare later
	
	# Print welcome message
	la a0, msg_welcome
	li a7, 4 # prints greeting to console
	ecall # system calls
	
prompt_loop:
	# Print extra line
	la a0, new_line
	li a7, 4 # prints greeting to console
	ecall # system calls

	# Prompt for input
	la a0, msg_enter
	li a7, 4
	ecall
	
	# Read input
	li a7, 5
	ecall
	mv t0, a0
	
	# Initialize counter
	li t1, 0
	
	# Cast to unsigned int
	mv t2, t0
	
count_loop:
	# Check if cast is 0
	beqz t2, result
	
	# Add lsb to counter
	andi t3, t2, 1
	add t1, t1, t3
	
	# Right - shift by one position to discard lsb
	srli t2, t2, 1
	j count_loop
	
result:
	# Print msg_result
	la a0, msg_result
	li a7, 4
	ecall
	
  mv a0, t1 # print the number of bits set
	li a7, 1
	ecall
	
	# Prompt for continue
	la a0, msg_continue
	li a7, 4
	ecall
	
	li a7, 12 # putting 12 into a7 is readchar
	ecall # system calls
	mv t4, a0 # preserve user's char (y / n) in t4
	
	# Check if prompt is 'n'
	li t5, 'n' # load ASCII code of 'n'
	bne t4, t5, prompt_loop # if t4 != t5, then jump to prompt_loop

	
exit:
	# Print exit message
	la a0, msg_exit
	li a7, 4
	ecall
	
	# Exit program
	li a7, 10
	ecall
