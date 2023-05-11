	.global main, printsort, getStringLen, return_address # declare global symbols
	
	.data # start of the data section
return_address: .word -1 # return address for when subroutines are called
return_len : .word -1 # return value for when subroutines are called
my_string: .space 20 # allocate space for 19 characters and a null terminator
new_line: .string "\n"
msg_menu: .string "Enter word: "
word_org: .string "Original word: "
word_alpha: .string "Alphabetized word: "
msg_exit: .string "\nExiting\n"

	.text # start of the code section
	
main: # entry point for the program
	la s0, my_string # load address of my_string into s0
	andi s1, s1, 0 # length = 0
	
	la a0, msg_menu # load address of msg_menu into a0
	jal printstring # print msg_menu
	
	mv a0, s0 # load address of my_string into a0
	li a1, 20 # max length of string
	jal ra, clearstring
	mv a0, s0 # load address of my_string into a0
	jal ra, readstring # store user input into my_string
	
	mv a0, s0 # load address of my_string into a0
	jal ra, getStringLen
	mv s1, a0 # length = a0
	beqz s1, exit # if length == 0, goto exit
	
	la a0, word_org # load address of word_org into a0
	jal printstring # print word_org
	
	la a0, my_string # load address of my_string into a0
	jal printstring # print my_string
	
	la a0, new_line # load address of new_line into a0
	jal printstring # print my_string
	
	la a0, word_alpha # load address of word_alpha into a0
	jal printstring # print word_alpha
	
	jal printsort # print my_string

endprintsort:
	la a0, new_line # load address of new_line into a0
	jal printstring # print my_string
	j main
	
printsort:
	li t1, 0 # i = 0
	li t2, 0 # j = 0
	li t5, 0 # minCeiling = 0
	li t5, -1 # minCeiling = -1
	
outer_loop:
	bgt t1, s1, end_outer_loop # while i < length
	li t3, 0 # smallCount = 0
	li t4, 0 # smallest = 0
	li t4, 999 # smallest = 999
  li t2, 0 # j = 0
inner_loop:
	bge t2, s1, print_nums # while j < length
	add t0, s0, t2 # incremented address (j)
	lb t0, 0(t0) # load byte at address t0 (string[j])
  j if # goto if
if:
	bge t5, t0, elif # if minCeiling >= string[j], goto elif
	bge t0, t4,elif # if string[j] >= smallest, goto elif
	li, t3, 1 # smallCount = 0
	mv t4, t0 # smallest = string[j]
	j end_if # goto end_if
elif:
  # works if (smallest == word[j])
  bne t0, t4, end_if # if smallest != word[j], goto end_if
	addi t3, t3, 1 # smallCount++
	j end_if # goto end_if
end_if:
	addi t2, t2, 1 # j++
	j inner_loop # goto inner_loop
print_nums:
	li t2, 0 # j = 0
	mv t5, t4 # minCeiling = smallest
print_loop:
	bge t2, t3, end_inner_loop # while j < smallCount
	mv a0, t5 # a0 = smallest
	jal printchar # print smallest
	addi t2, t2, 1 # j++
	j print_loop # goto print_loop
	
end_inner_loop:
	addi t1, t1, 1 # i++
	j outer_loop # goto outer_loop
	
end_outer_loop:
	j endprintsort # return to caller
exit:
	# Print exit message
	la a0, msg_exit
	jal printstring
	
	# Exit program
	jal exit0
	
	# Subroutine to get the length of a given string
# Inputs: a0 - the address of the string
getStringLen:
  la t0, return_len
  sw ra, 0(t0) # save the return address

	mv t0, a0 # t0 = a0
	li t1, 0 # length = 0
while:
	lb t2, 0(t0) # t2 = string[i]
	beqz t2, end_while # if string[i] == 0, goto end_while
	addi t0, t0, 1 # t0 + = 1
	addi t1, t1, 1 # i + = 1
	j while # goto while
end_while:
	mv a0, t1 # a0 = length
	la t0, return_len
  lw ra, 0(t0) # restore the return address
	jr ra # return to address called from + 4
	# end subroutine