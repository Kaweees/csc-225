	.global main, printsort, getStringLen # declare global symbols
	.data # start of the data section
my_string:
	.space 20 # allocate space for 19 characters and a null terminator
new_line: .string "\n"
# msg_welcome: .string "Enter word: " # Copy strings for input / output into memory
msg_menu: .string "Enter word: "
word_org: .string "Original word: "
word_alpha: .string "Alphabetized word: "
msg_exit: .string "\nExiting\n"
	
	.text # start of the code section
	
main: # entry point for the program
	la a0, msg_menu # load address of msg_menu into a0
	jal printstring # print msg_menu
	
	la a0, my_string # load address of my_string into a0
	jal readstring # store user input into my_string
	
	jal getStringLen
	mv s0, a0 # length = a0
	beqz s0, exit # if length == 0, goto exit
	
	la a0, word_org # load address of word_org into a0
	jal printstring # print word_org
	la a0, my_string # load address of my_string into a0
	jal printstring # print my_string
	
	la a0, word_alpha # load address of word_alpha into a0
	jal printstring # print word_alpha
	
	la a0, my_string # load address of my_string into a0
	la a1, s0 # load address of length into a1
	jal printsort # printsort my_string
exit:
	# Print exit message
	la a0, msg_exit
	jal printstring
	
	# Exit program
	jal exit0
	
	# Subroutine to print a string in alphabetical order
# Inputs: a0 - the address of the string to print, a1 - the length of the string
printsort:
	la t0, my_string # t0 = my_string
	andi t1, t1, 0 # i = 0
	andi t2, t2, 0 # j = 0
	andi t3, t3, 0 # smallCount = 0
	andi t4, t4, 0 # smallest = 0
	addi t4, t4, 9999 # smallest = 9999
	addi t5, t5, 0 # minCeiling = 0
	addi t5 t5, - 1 # minCeiling = - 1
	mv t6, a1 # t6 = length
	
outer_loop:
	bge t1, t6, end_outer_loop # while i < length
	andi t4, t4, 0 # smallest = 0
	addi t4, t4, 9999 # smallest = 9999
	addi t3, t3, 0 # smallCount = 0
inner_loop:
	bge t2, t6, print_nums # while j < length
	lb t7, 0(t0) # t7 = string[j]
	blt t7, t4, if # if string[j] < smallest, goto if
	beq t4, t7, elif # if string[j] == smallest, goto if
	j end_if # goto end_if
if:
	blt t7, t5, else # if string[j] < minCeiling, goto else
	addi t3, t3, 1 # smallCount + = 1
	mv t4, t7 # smallest = string[j]
	j end_if # goto end_if
elif:
	addi t3, t3, 1 # smallCount + = 1
	j end_if # goto end_if
end_if:
	addi t2, t2, 1 # j + = 1
	j inner_loop # goto inner_loop
print_nums:
	andi t2, t2, 0 # j = 0
print_loop:
	bge t2, t3, end_inner_loop # while j < smallCount
	mv a0, t4 # a0 = smallest
	jal printchar # print smallest
	addi t2, t2, 1 # j + = 1
	j print_loop # goto print_loop
	
print:
	mv a0, t7 # a0 = string[j]
	jal printchar # print string[j]
	addi t2, t2, 1 # j + = 1
	j print_loop # goto print_loop
	
end_inner_loop:
	addi t1, t1, 1 # i + = 1
	j outer_loop # goto outer_loop
	
end_outer_loop:
	ret # return to caller
	# end subroutine
	
	# Subroutine to get the length of a given string
# Inputs: a0 - the address of the string
getStringLen:
	mv t0, a0 # t0 = a0
	andi t1, t1, 0 # length = 0
while:
	lb t2, 0(t0) # t2 = string[i]
	beqz t2, end_while # if string[i] == 0, goto end_while
	addi t0, t0, 1 # t0 + = 1
	addi t1, t1, 1 # i + = 1
	j while # goto while
end_while:
	mv a0, t1 # a0 = length
	ret # return to caller
	# end subroutine
