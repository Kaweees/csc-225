  .global swap, selectionSort, printArray # declare global symbols
  .text # start of the code section

  # subroutine: selectionSort
# purpose: perform selection sort on subarray arr[i…n-1]
# Inputs: a0 - pointer to array to sort, a1 - index subarray begins at, a2 - size of subarray
# outputs: None
selectionSort:
  addi sp, sp, -16 # allocate space on the stack
  sw ra, 0(sp) # save ra to stack

  li t0, 0 # int j
  mv t1, a1 # min = i
  li t2, 32 # size of element in array

for1: # for1 (j = i + 1; j < n; j++)
  addi t0, a1, 1 # j = i + 1

forloop1:
  bge t0, a2, endfor1 # if (j >= n) goto endfor1
  mul t3, t0, t2 # jOffset = j * size
  add t3, a0, t3 # &arr[j]
  addi t4, t3, 24 # t4 = &arr[j].studentid (24 bytes offset)
  lw t4, 0(t4) # t4 = *(&arr[j].studentid)
  
  mul t5, t1, t2 # minOffset = min * size
  add t5, a0, t5 # &arr[min]
  addi t6, t5, 24 # t6 = &arr[min].studentid (24 bytes offset)
  lw t6, 0(t6) # t6 = *(&arr[min].studentid)

if1:
  # works if (arr[j].studentid < arr[min].studentid)
  bge t4, t6, endif1 # if arr[j].studentid >= arr[min].studentid, goto endif1
  mv t1, t0 # min = j

endif1:
  addi t0, t0, 1 # j++
  j forloop1 # goto forloop

endfor1:
  addi sp, sp, -16 # allocate space on the stack
  sw a0, 0(sp) # save arr[] to stack
  sw a1, 4(sp) # save i to stack
  sw a2, 8(sp) # save n to stack

  mv a2, a1 # a2 = i
  mv a0, a0 # a0 = arr[]
  mv a1, t1 # a1 = min
  jal swap # swap(arr, min, i)

  lw a0, 0(sp) # restore arr[] from stack
  lw a1, 4(sp) # restore i from stack
  addi a1, a1, 1 # i++
  lw a2, 8(sp) # restore n from stack
  addi sp, sp, 16 # deallocate space on the stack

if2:
  # works if (i + 1 < n)
  bge a1, a2, endif2 # if i + 1 >= n, goto endif2
  jal selectionSort # selectionSort(arr, i + 1, n)

endif2:
  lw ra, 0(sp) # restore ra from stack
  addi sp, sp, 16 # deallocate space on the stack
  ret # return to caller
	# end subroutine
 
  # subroutine: printArray
# purpose: print n elements of array arr
# Inputs: a0 - pointer to array to print, a1 - number of elements in array
# outputs: None
printArray:
  addi sp, sp, -16 # allocate space on the stack
  sw ra, 0(sp) # save ra to stack

for2:
  li t0, 0 # i = 0
  li t1, 32 # size of item in array
  lw t2, 0(a0) # t2 = arr[i]

forloop2:
  bge t0, a1, endfor2 # if (i >= n) goto endfor2

  # print arr[i].studentid

  # printchar(' ')
  li a0, 32 # a0 = ' '
  li a7, 11 # syscall code for printing a character
	ecall # execute the syscall

  # printint(arr[i].studentid)
  mv a0, t2 # a0 = arr[i]
  addi a0, a0, 24 # a0 = arr[i].studentid
  li a7, 1 # syscall code for printing an integer
	ecall # execute the syscall

  # printchar(' ')
  li a0, 32 # a0 = ' '
  li a7, 11 # syscall code for printing a character
	ecall # execute the syscall

  # printint(arr[i].studencoursenumtid)
  mv a0, t2 # a0 = arr[i]
  addi a0, a0, 28 # a0 = arr[i].coursenum
  li a7, 1 # syscall code for printing an integer
	ecall # execute the syscall

  # printchar('\n')
  li a0, 10 # a0 = '\n'
  li a7, 11 # syscall code for printing a character
	ecall # execute the syscall

  addi t2, t2, 32 # arr[i + 32]
  addi t0, t0, 1 # i++
  j forloop2

endfor2:
  lw ra, 0(sp) # restore ra from stack
  addi sp, sp, 16 # deallocate space on the stack
  ret # return to caller
	# end subroutine

  # subroutine: swap
# purpose: swap values at two indices in an array
# Inputs: a0 - pointer to array to sort, a1 - index of first element, a2 - index of second element
# outputs: None
swap:
  li t0, 32 # nodeSize (in bytes) = 32
  # addi a1, a1, 1 # i++

  mul t1, a1, t0
  add t1, a0, t1 # t1 = &arr[i]
  mul t2, a2, t0
  add t2, a0, t2 # t3 = &arr[j]

for3:
  li t3, 0 # offset = 0

forloop3:
  bge t3, t0, endfor4 # if (k >= nodeSize) goto endfor4
  lw t4, 0(t1) # t5 = *(&arr[i] + k)
  lw t5, 0(t2) # t7 = *(&arr[j] + k)
  sw t4, 0(t1) # arr[i] = arr[j]
  sw t5, 0(t2) # arr[j] = arr[i]

  addi t1, t1, 4 # &(arr[i] + offset)
  addi t2, t2, 4 # &(arr[j] + offset)
  addi t3, t3, 4 # offset += 4
  j forloop3
endfor4:
  ret # return to caller
	# end subroutine
