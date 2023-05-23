  .global recurSelectionSort # declare global symbols
  .text # start of the code section

  # subroutine: recurSelectionSort
# purpose: perform a recursive selection sort on a linked list of nodes
# Inputs: a0 - pointer to the head of the linked list
# outputs: a0 - pointer to the head of the sorted linked list
recurSelectionSort:
#struct Node* recurSelectionSort(struct Node* head) {
  addi sp, sp, -32 # allocate space on the stack
  sw ra, 0(sp) # save ra to stack
  sw s0, 8(sp) # save s0 to stack
  mv s0, a0 # s0 = head

  addi t0, s0, 16 # t0 = head->next
  lw t0, 0(t0) # t0 = head->next->studentid

if1:
  # works if (head->next == NULL)
  bnez a0, endif1 # if (head != NULL), goto endif1
  ret # return head
endif1:
  mv t0, s0 # struct Node* min = head
  mv t1, x0 # struct Node* beforeMin = NULL

forinit:
  mv t2, s0 # struct Node* ptr = head

forloop: # for1 (struct Node* ptr = head; ptr->next != NULL; ptr = ptr->next)
  addi t3, t2, 16 # t3 = ptr->next
  lw t4, 0(t3) # t4 = ptr->next
  beqz t4, endfor # if (ptr->next == NULL), goto endfor
  lw t4, 4(t4) # t4 = ptr->next.studentID
  lw t5, 4(t0) # t5 = min.studentID
  addi t6, t5, -1 # t6 = min.studentID - 1

ifmin:
  # works if (ptr->next->studentid < min->studentid)
  bgt t4, t5, endifmin # if (ptr->next->studentid > min->studentid), goto endifmin
  lw t0, 0(t3) # min = ptr->next
  mv t1, t2 # beforeMin = ptr

endifmin:
  lw t2, 0(t3) # t2 = ptr->next
  j forloop # goto forloop

endfor:
  lw t3,8(t0)
  lw t4,8(s0)
  
if2:
  # works if (min != head)
  beq t3, t4, swapEnd # if (min == head), goto swapEnd
swap:
  # Stores head in the stack and give a0 the address
  sw s0, 4(sp) # save head to stack
  addi a0, sp, 4 # a0 = &head
  mv a1, s0 # a1 = head
  mv a2, t0 # a2 = min
  mv a3, t1 # a3 = beforeMin
  jal swapNodes # swapNodes(&head, head, min, beforeMin)

swapEnd:
  lw ra, 0(sp) # restore ra from stack
  lw a0, 4(sp) # restore head from stack
  addi sp, sp, 16 # deallocate space on the stack

endif2:
  lw a0, 16(a0) # head = head->next
  jal recurSelectionSort # recurSelectionSort
  sw a0,16(s0)
  mv a0,s0
  
return:
  lw ra, 0(sp) # Restores the ra from the stack
  lw s0, 8(sp)  # Restores the value of of s0 from the stack
  addi sp, sp, 16 # Frees space in stack
  ret # return head
  # end subroutine
