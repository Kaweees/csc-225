  .global main, getStringLen # declare global symbols
  
  .data # start of the data section
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
  
  li s2, 0 # i = 0
  li s3, 0 # j = 0
  li s4, 0 # minCeiling = 0
  li s4, -1 # minCeiling = -1
  
outer_loop:
  bgt s2, s1, end_outer_loop # while i < length
  li s5, 0 # smallCount = 0
  li s6, 0 # smallest = 0
  li s6, 999 # smallest = 999
  li s3, 0 # j = 0
inner_loop:
  bge s3, s1, print_nums # while j < length
  add s7, s0, s3 # incremented address (j)
  lb s7, 0(s7) # load byte at address s7 (string[j])
  j if # goto if
if:
  bge s4, s7, elif # if minCeiling >= string[j], goto elif
  bge s7, s6,elif # if string[j] >= smallest, goto elif
  li, s5, 1 # smallCount = 0
  mv s6, s7 # smallest = string[j]
  j end_if # goto end_if
elif:
  # works if (smallest == word[j])
  bne s7, s6, end_if # if smallest != word[j], goto end_if
  addi s5, s5, 1 # smallCount++
  j end_if # goto end_if
end_if:
  addi s3, s3, 1 # j++
  j inner_loop # goto inner_loop
print_nums:
  li s3, 0 # j = 0
  mv s4, s6 # minCeiling = smallest
print_loop:
  bge s3, s5, end_inner_loop # while j < smallCount
  mv a0, s4 # a0 = smallest
  jal printchar # print smallest
  addi s3, s3, 1 # j++
  j print_loop # goto print_loop
  
end_inner_loop:
  addi s2, s2, 1 # i++
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
  la s7, return_len
  sw ra, 0(s7) # save the return address

  mv s7, a0 # s7 = a0
  li s2, 0 # length = 0
while:
  lb s3, 0(s7) # s3 = string[i]
  beqz s3, end_while # if string[i] == 0, goto end_while
  addi s7, s7, 1 # s7 + = 1
  addi s2, s2, 1 # i + = 1
  j while # goto while
end_while:
  mv a0, s2 # a0 = length
  la s7, return_len
  lw ra, 0(s7) # restore the return address
  jr ra # return to address called from + 4
  # end subroutine

endprintsort:
  la a0, new_line # load address of new_line into a0
  jal printstring # print my_string
  j main
