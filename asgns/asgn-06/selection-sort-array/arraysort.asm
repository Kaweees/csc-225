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
  mv t2, a0 # jOffset = arr[]
  mv t3, a0 # minOffset = arr[]

for1: # for1 (j = i + 1; j < n; j++)
  addi t0, a1, 1 # j = i + 1

forloop1:
  bge t0, a2, endfor1 # if (j >= n) goto endfor1
  lw t4, 0(t2) # t4 = *(&arr[j])
  lw t5, 0(t3) # t5 = *(&arr[min])

if1:
  # works if (arr[j] < arr[min])
  bge t4, t5, endif1 # if arr[j] >= arr[min], goto endif1
  mv t1, t0 # min = j
  mv t3, t2 # minOffset = jOffset

endif1:
  addi t0, t0, 1 # j++
  addi t2, t2, 4 # jOffset += 4
  j forloop1 # goto forloop1

endfor1:
  addi sp, sp, -16 # allocate space on the stack
  sw a0, 0(sp) # save arr[] to stack
  sw a1, 4(sp) # save i to stack
  sw a2, 8(sp) # save n to stack

  # mv a0, t1 # a0 = min
  #lw a0, 0(t3) # a0 = arr[min]
  #jal printint # printint(min)
  #li a0, '\n'
  #jal printchar # printchar(' ') 
  
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
  mv t0, a0 # t0 = arr[]
  mv t1, a0 # t1 = arr[]
  li t2, 2 # t2 = conditional
  li t3 0 # t3 = k

while1: # while (conditional)
  li t2, 0 # t2 = conditional

loopcond1:
  bge t3, a1, loopcond2 # if (k >= i) goto endloopcond
  addi t0, t0, 4 # t0 = &arr[i] (byte addressed)
  addi t2, t2, 1 # t2++
loopcond2:
  bge t3, a2, endloopcond # if (k >= j) goto endloopcond
  addi t1, t1, 4 # t1 = &arr[i] (byte addressed)
  addi t2, t2, 1 # t2++
endloopcond:
  beq t2, x0, endwhile # if (t2 == 0) goto for4
  addi t3, t3, 1 # k++
  j while1

endwhile:
  lw t2, 0(t0) # t1 = arr[i]
  lw t3, 0(t1) # t3 = arr[j]
  sw t3, 0(t0) # arr[i] = arr[j]
  sw t2, 0(t1) # arr[j] = arr[i]
  ret # return to caller
	# end subroutine

  # subroutine: getArrayElement
# purpose: calculate the memory address of an array element
# Inputs: a0 - pointer to array, a1 - index of element to calculate, a2 - offset (bytes) of array items
# outputs: a0 - value at given index
getArrayElement:
  la t0, a0 # t0 = &arr[]
  li t1, 0 # i = 0

for: # for (i = 0; i < index; i++)
  bge t1, a1, endfor # if (i >= index) goto endfor
  addi t0, t0, 1 # i++
  add a0, a0, a2 # arr += offset
  j for # goto for

endfor:
  mv a0, t0 # a0 = &arr[index]
  ret # return to caller
  # end subroutine