  .global swap, selectionSort # declare global symbols
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

for: # for (j = i + 1; j < n; j++)
  addi t0, a1, a1, 1 # j = i + 1

forloop:
  bge t0, a2, endfor # if (j >= n) goto endfor
  add t2, a0, t0 # t2 = &arr[j]
  lw t2, 0(t2) # t2 = *(&arr[j])
  add t3, a0, t1 # t3 = &arr[min]
  lw t3, 0(t3) # t3 = *(&arr[min])

if1:
  # works if (arr[j] < arr[min])
  bge t0, t1, endif1 # if arr[j] >= arr[min], goto endif1
  mv t1, t0 # min = j

endif1:
  addi t0, t0, 1 # j++
  j forloop # goto forloop

endfor:
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

  # subroutine: swap
# purpose: swap values at two indices in an array
# Inputs: a0 - pointer to array to sort, a1 - index of first element, a2 - index of second element
# outputs: None
swap:
  add t0, a0, a1 # t0 = &arr[i]
  lw t1, 0(t0) # t1 = arr[i]
  add t2, a0, a2 # t2 = &arr[j]
  lw t3, 0(t2) # t3 = arr[j]

  sw t3, 0(t0) # arr[i] = arr[j]
  sw t1, 0(t2) # arr[j] = arr[i]
  ret # return to caller
	# end subroutine