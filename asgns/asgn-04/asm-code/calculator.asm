	.global main # declare global symbols
	
	.data # start of the data section
new_line: .string "\n"
msg_welcome: .string "Welcome to the Calculator program." # Copy strings for input / output into memory
msg_menu: .string "\nOperations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift"
msg_count: .string "\nNumber of operations performed: "
msg_num1: .string "\nEnter number: "
msg_num2: .string "Enter second number: "
msg_opr: .string "Select operation: "
msg_result: .string "Result: "
msg_error: .string "Invalid Operation"
msg_continue: .string "\nContinue (y/n)?: "
msg_exit: .string "\nExiting"
	
	.text # start of the code section
	
main: # entry point for the program
	# variables
	andi s1, s1, 0 # count = 0
	
	la a0, msg_welcome # load address of msg_welcome into a0
	jal printstring # print msg_welcome
	
	la a0, msg_menu # load address of msg_menu into a0
	jal printstring # print msg_welcome
	
prompt_loop:
	# print num of operations performed
	la a0, new_line # load address of new_line into a0
	jal printstring # print new_line
	la a0, msg_count # load address of msg_count into a0
	jal printstring # print msg_count
	mv a0, s1 # move count into a0
	jal printint # print count
	
	# get num1 from user
	la a0, msg_num1 # load address of msg_num1 into a0
	jal printstring # print msg_num1
	jal readint # read integer from user input
	mv t0, a0 # move num1 into t0
	
	# get num2 from user
	la a0, msg_num2 # load address of msg_num2 into a0
	jal printstring # print msg_num2
	jal readint # read integer from user input
	mv t1, a0 # move num2 into t1
	
	# get operation from user
	la a0, msg_opr # load address of msg_opr into a0
	jal printstring # print msg_opr
	jal readint # read integer from user input
	mv t2, a0 # move operation into t2
	
	# print result
	la a0, msg_result
	jal printstring
	# load num1 and num2
	add a0, x0, t0 # move num1 into a0
	add a1, x0, t1 # move num2 into a1
	
switch: # switch statement
  andi t6, t6, 0 # t6 = 0
  addi t6, t6, 1 # t6 = 1
	beq t2, t6, case1 # operation = 1
  addi t6, t6, 1 # t6 = 2
	beq t2, t6, case2 # operation = 2
  addi t6, t6, 1 # t6 = 3
	beq t2, t6, case3 # operation = 3
  addi t6, t6, 1 # t6 = 4
	beq t2, t6, case4 # operation = 4
  addi t6, t6, 1 # t6 = 5
	beq t2, t6, case5 # operation = 5
  addi t6, t6, 1 # t6 = 6
	beq t2, t6, case6 # operation = 6
  addi t6, t6, 1 # t6 = 7
	beq t2, t6, case7 # operation = 7
  addi t6, t6, 1 # t6 = 8
	beq t2, t6, case8 # operation = 8
  addi t6, t6, 1 # t6 = 9
	beq t2, t6, case9 # operation = 9
	j default_case
	
case1:
	# print addnums
	jal addnums # add num1 and num2
	jal printint # print result
	j end_switch
	
case2:
	# print subnums
	jal subnums # sub num1 and num2
	jal printint # print result
	j end_switch
	
case3:
	# print mulnums
	jal multnums # mul num1 and num2
	jal printint # print result
	j end_switch
	
case4:
	# print divnums
	jal divnums # div num1 and num2
	jal printint # print result
	j end_switch
	
case5:
	# print andnums
	jal andnums # and num1 and num2
	jal printint # print result
	j end_switch
	
case6:
	# print ornums
	jal ornums # or num1 and num2
	jal printint # print result
	j end_switch
	
case7:
	# print xornums
	jal xornums # xor num1 and num2
	jal printint # print result
	j end_switch
	
case8:
	# print lshift
	jal lshiftnums # lshift num1 and num2
	jal printint # print result
	j end_switch
	
case9:
	# print rshift
	jal rshiftnums # rshift num1 and num2
	jal printint # print result
	j end_switch
	
default_case:
	# code for invalid operation
	la a0, msg_error
	jal printstring
	j end_switch
	
end_switch:
	# code after the switch statement
	
	# Prompt for continue
	la a0, msg_continue
  jal printstring

  # Read user input
  jal readchar
	
	# Check if prompt is 'n'
	li t5, 'n' # load ASCII code of 'n'
  addi s1, s1, 1 # increment count
  mv t4, a0 # move user input into t4
	bne t4, t5, prompt_loop # if t4 != t5, then jump to prompt_loop
	
exit:
	# Print exit message
	la a0, msg_exit
	jal printstring
	
	# Exit program
	jal exit0
