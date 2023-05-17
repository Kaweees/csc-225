  .global swap, selectionSort, printArray # declare global symbols
  .text # start of the code section

  # subroutine: selectionSort
# purpose: perform selection sort on subarray arr[i…n-1]
# Inputs: a0 - pointer to array to sort, a1 - index subarray begins at, a2 - size of subarray
# outputs: None
selectionSort:
  addi sp, sp, -16 # allocate space on the stack
  sw ra, 0(sp) # save ra to stack

  andi t0, t0, 0 # int j
  mv t1, a1 # min = i
  li t2, a0, 0 # j address
  li t3, a0, 0 # min address


for1: # for (j = i + 1; j < n; j++)
  addi t0, a1, a1, 1 # j = i + 1

forloop1:
  bge t0, a2, endfor # if (j >= n) goto endfor1
  addi t4, t2, 24 # t4 = &arr[j].studentid (24 bytes offset)
  lw t4, 0(t4) # t4 = *(&arr[j].studentid)

  addi t5, t3, 24 # t5 = &arr[min].studentid (24 bytes offset)
  lw t5, 0(t5) # t5 = *(&arr[min].studentid)
if1:
  # works if (arr[j].studentid < arr[min].studentid)
  bge t4, t5, endif1 # if arr[j].studentid >= arr[min].studentid, goto endif1
  mv t1, t0 # min = j

endif1:
  addi t0, t0, 1 # j++
  addi t2, t2, 32 # t2 = &arr[j] (32 bytes offset)
  j forloop # goto forloop

endfor1:
  sw a0, 4(sp) # save arr[] to stack
  sw a1, 8(sp) # save i to stack
  sw a2, 12(sp) # save n to stack

  mv a2, a1 # a2 = i
  mv a1, t1 # a1 = min
  mv a0, a0 # a0 = arr[]
  jal swap # swap(arr, min, i)

  addi sp, sp, 16 # deallocate space on the stack
  lw ra, 0(sp) # restore ra from stack
  lw a0, 4(sp) # restore arr[] from stack
  lw a1, 8(sp) # restore i from stack
  addi a1, a1, 1 # i++ 
  lw a2, 12(sp) # restore n from stack

if2:
  # works if (i + 1 < n)
  bge a1, a2, endif2 # if i + 1 >= n, goto endif2
  mv a1, t0 # i = i + 1  
  jal selectionSort # selectionSort(arr, i + 1, n)

endif2:
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
  andi t0, t0, 0 # i = 0
  lw t1, a0 # offset = arr[]

forloop2:
  bge t0, a1, endfor2 # if (i >= n) goto endfor2
  sw a0, 4(sp) # save arr[] to stack
  sw a1, 8(sp) # save n to stack
  sw t0, 12(sp) # save i to stack
  sw t1, 16(sp) # save offset to stack

  lw a0, 0(t1) # a0 = arr[i].studentid
  jal printstring # printstring(arr[i].studentid)

  li a0, 32 # a0 = ' '
  jal printchar # printchar(' ')

  lw t1, 16(sp) # restore offset from stack
  addi t1, t1, 24 # offset += 24
  lw a0, 4(t1) # a0 = arr[i].studentid
  jal printint # printstring(arr[i].name)

  li a0, 32 # a0 = ' '
  jal printchar # printchar(' ')

  lw t1, 16(sp) # restore offset from stack
  addi t1, t1, 28 # offset += 28
  lw a0, 4(t1) # a0 = arr[i].coursenum
  jal printint # printstring(arr[i].coursenum)

  li a0, 10 # a0 = '\n'
  jal printchar # printchar('\n')


  lw a1, 8(sp) # restore n from stack
  lw t0, 12(sp) # restore i from stack
  addi t0, t0, 1 # i++
  lw t1, 4(sp) # restore offset from stack
  addi t1, t1, 32 # offset += 32
  j forloop2

endfor2:
  addi sp, sp, 16 # deallocate space on the stack
  lw ra, 0(sp) # restore ra from stack
  ret # return to caller
	# end subroutine

  # subroutine: swap
# purpose: swap values at two indices in an array
# Inputs: a0 - pointer to array to sort, a1 - index of first element, a2 - index of second element
# outputs: None
#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
  lw t0, a0 # t0 = arr[]
  lw t1, a0 # t1 = arr[]
  li t2, 2 # t2 = conditional
  
for3:
  li t3, -1 # t3 = k

forloop3:
  addi t3, t3, 1 # k++
loopcond1:
  bge t3, a1, loopcond2 # if (k >= i) goto endloopcond
  addi t0, t0, 32 # t0 = &arr[i] (32 bytes offset)
  addi t2, t2, -1 # t2--
loopcond2:
  bge t3, a2, endloopcond # if (k >= j) goto endloopcond
  addi t1, t1, 32 # t1 = &arr[j] (32 bytes offset)
  addi t2, t2, -1 # t2--

endloopcond:
  beq t2, x0, for4 # if (t2 == 0) goto for4
  li t2, 2 # t2 = conditional
  j forloop3

for4:
  mv a1, t0 # a1 = &arr[i]
  mv a2, t1 # a2 = &arr[j]
  li t0, 0 # offset = 0
  li t1, 32 # nodeSize (in bytes) = 32

forloop4:
  bge t0, t1, endfor4 # if (offset >= nodeSize) goto endfor4
  add t2, a1, t0 # t2 = &(arr[i] + offset)
  add t4, a1, t0 # t4 = &(arr[j] + offset)
  lw t3, 0(t2) # temp = *(&(arr[i] + offset))
  lw t5, 0(t4) # t5 = *(&(arr[j] + offset))
  sw t5, 0(t2) # *(&(arr[i] + offset)) = *(&(arr[j] + offset))
  sw t3, 0(t4) # *(&(arr[j] + offset)) = temp
  addi t0, t0, 4 # offset += 4
  j forloop4

endfor4:
  ret # return to caller
  # end subroutine