	.global main # declare global symbols
	
	.data # start of the data section
new_line: .string "\n"
msg_welcome: .string "Welcome to the Calculator program." # Copy strings for input / output into memory
msg_menu: .string "\nOperations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift"
msg_count: .string "Number of operations performed: "
msg_num1: .string "\nEnter number: "
msg_num2: .string "\nEnter second number: "
msg_opr: .string "\nSelect operation: "
msg_result: .string "\nResult: "
msg_error: .string "Invalid Operation"
msg_continue: .string "\nContinue (y/n)?: "
msg_exit: .string "\nExiting"
	
	.text # start of the code section
	
main: # entry point for the program
	# variables
	addi s1, s1, x0 # count = 0
	
	la a0, msg_welcome # load address of msg_welcome into a0
	printstring # print msg_welcome
	
	la a0, msg_menu # load address of msg_menu into a0
	printstring # print msg_welcome
	
prompt_loop:
	# print num of operations performed
	la a0, new_line # load address of new_line into a0
	printstring # print new_line
	la a0, msg_count # load address of msg_count into a0
	printstring # print msg_count
	la a0, s1 # load address of count into a0
	printint # print count\
	
	# get num1 from user
	la a0, msg_num1 # load address of msg_num1 into a0
	printstring # print msg_num1
	readint # read integer from user input
	mv t0, a0 # move num1 into t0
	
	# get num2 from user
	la a0, msg_num2 # load address of msg_num2 into a0
	printstring # print msg_num2
	readint # read integer from user input
	mv t1, a0 # move num2 into t1
	
	# get operation from user
	la a0, msg_opr # load address of msg_opr into a0
	printstring # print msg_opr
	readint # read integer from user input
	mv t2, a0 # move operation into t2
	
	# print result
	la a0, msg_result
	printstring
	# load num1 and num2
	add a0, x0, t0 # move num1 into a0
	add a1, x0, t1 # move num2 into a1
	
switch: # switch statement
	beq t2, 1, case1 # operation = 1
	beq t2, 2, case2 # operation = 2
	beq t2, 3, case3 # operation = 3
	beq t2, 4, case4 # operation = 4
	beq t2, 5, case5 # operation = 5
	beq t2, 6, case6 # operation = 6
	beq t2, 7, case7 # operation = 7
	beq t2, 8, case8 # operation = 8
	beq t2, 9, case9 # operation = 9
	j default_case
	
case1:
	# print addnums
	addnums # add num1 and num2
	printint # print result
	j end_switch
	
case2:
	# print subnums
	subnums # sub num1 and num2
	printint # print result
	j end_switch
	
case3:
	# print mulnums
	mulnums # mul num1 and num2
	printint # print result
	j end_switch
	
case4:
	# print divnums
	divnums # div num1 and num2
	printint # print result
	j end_switch
	
case5:
	# print andnums
	andnums # and num1 and num2
	printint # print result
	j end_switch
	
case6:
	# print ornums
	ornums # or num1 and num2
	printint # print result
	j end_switch
	
case7:
	# print xornums
	xornums # xor num1 and num2
	printint # print result
	j end_switch
	
case8:
	# print lshift
	lshift # lshift num1 and num2
	printint # print result
	j end_switch
	
case9:
	# print rshift
	rshift # rshift num1 and num2
	printint # print result
	j end_switch
	
default_case:
	# code for invalid operation
	la a0, msg_error
	printstring
	j end_switch
	
end_switch:
	# code after the switch statement
	la a0, msg_continue
	printstring
	
	readchar # read character from user input
	mv t3, a0 # move character into t3
	
	bge zero, t1, endwhile
	mul t1, t1, t1
	b while
endwhile:
	sw t1, value, t2 # update value in memory
	
	li t1, 'n' # constant to compare later
	
	# Print welcome message
	la a0, msg_welcome
	li a7, 4 # prints greeting to console
	ecall # system calls
	
	# Print operations message
	la a0, msg_menu
	li a7, 4 # prints greeting to console
	ecall # system calls
	
prompt_loop:
	# Print extra line
	la a0, new_line
	li a7, 4 # prints newline to console
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
	mv t4, a0 # preserve user's char (y/n) in t4
	
	# Check if prompt is 'n'
	li t5, 'n' # load ASCII code of 'n'
	bne t4, t5, prompt_loop # if t4 != t5, then jump to prompt_loop
	
exit:
	# Print exit message
	la a0, msg_exit
	printstring
	
	# Exit program
	exit0
