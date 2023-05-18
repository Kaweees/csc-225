  .global swap, selectionSort, printArray, recurSelectionSort # declare global symbols
  .text # start of the code section

  # subroutine: recurSelectionSort
# purpose: perform a recursive selection sort on a linked list of nodes
# Inputs: a0 - pointer to the head of the linked list
# outputs: a0 - pointer to the head of the sorted linked list
recurSelectionSort:
#struct Node* recurSelectionSort(struct Node* head) {
  addi sp, sp, -16 # allocate space on the stack
  sw ra, 0(sp) # save ra to stack

  addi t0, a0, 32 # t0 = head->next

if1:
  # works if (head->next == NULL)
  bne a0, x0, endif1 # if (head != NULL), goto endif1
  ret # return head
endif1:
  mv t0, a0 # struct Node* min = head
  mv t1, x0 # struct Node* beforeMin = NULL

forinit: # for1 (struct Node* ptr = head; ptr->next != NULL; ptr = ptr->next)
  mv t2, a0 # struct Node* ptr = head
  addi t3, t2, 32 # t3 = ptr->next

forloop:
  beqz t3, x0, endfor # if (ptr->next == NULL), goto endfor
  lw t4, 0(t3) # t4 = ptr->next
  addi t4, t4, 32 # t4 = ptr->next->studentid
  lw t5, 0(t0) # t5 = min
  addi t5, t5, 32 # t5 = min->studentid

ifmin:
  # works if (ptr->next->studentid < min->studentid)
  ble t4, t5, endifmin # if (ptr->next->studentid >= min->studentid), goto endifmin
  mv t0, t3 # min = ptr->next
  mv t1, t2 # beforeMin = ptr

endifmin:
  mv t2, t3 # ptr = ptr->next
  j forloop # goto forloop

endfor:

if2:
  # works if (min != head)
  beq t0, a0, endif2 # if (min == head), goto endif2
  # swapNodes(&head, head, min, beforeMin);
  


endif2:


#	head->next = recurSelectionSort(head->next);

#	return head;


#}