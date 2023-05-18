  .global swap, selectionSort # declare global symbols
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
  li t2, 4 # size of element in array

for1: # for1 (j = i + 1; j < n; j++)
  addi t0, a1, 1 # j = i + 1

forloop1:
  bge t0, a2, endfor1 # if (j >= n) goto endfor1
  mul t3, t0, t2 # jOffset = j * offset
  add t3, a0, t3 # &arr[j]
  lw t3, 0(t3) # t3 = *(&arr[j])
  mul t4, t1, t2 # minOffset = min * offset
  add t4, a0, t4 # &arr[min]
  lw t4, 0(t4) # t5 = *(&arr[min])

if1:
  # works if (arr[j] < arr[min])
  bge t3, t4, endif1 # if arr[j] >= arr[min], goto endif1
  mv t1, t0 # min = j

endif1:
  addi t0, t0, 1 # j++
  j forloop1 # goto forloop1

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

  # subroutine: swap
# purpose: swap values at two indices in an array
# Inputs: a0 - pointer to array to sort, a1 - index of first element, a2 - index of second element
# outputs: None
swap:
  li t0, 4 # offset = 4
  # addi a1, a1, 1 # i++

  mul t1, a1, t0 # iOffset = i * offset
  add t1, a0, t1 # t1 = &arr[i]
  lw t2, 0(t1) # t2 = *(&arr[i])

  mul t3, a2, t0 # jOffset = j * offset
  add t3, a0, t3 # t3 = &arr[j]
  lw t4, 0(t3) # t4 = *(&arr[j])

  sw t4, 0(t1) # arr[i] = arr[j]
  sw t2, 0(t3) # arr[j] = arr[i]
  ret # return to caller
	# end subroutine
