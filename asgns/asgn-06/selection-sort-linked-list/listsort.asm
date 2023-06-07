	.globl recurSelectionSort
recurSelectionSort:
	addi sp, sp, -16
	sw ra, 12(sp) 
	sw s0, 8(sp)
	
	mv s0, a0 # s0 = head
	addi t0, s0, 16 # t0 = head.next
	
	# Check if its null
	lw t0, (t0)
	
	# If NOT zero continue (ZERO == null char)
if: bnez t0, ifend
	
	# If so load head == into a0 return
	# return head                ;
	mv a0, s0
	b return
	
ifend:
	mv t0, s0 # min == t0
	li t1, 0 # beforeMin == t1
	# for (ptr = head            ; ptr - >next != NULL; ptr = ptr - >next) {
forinit:
	# Loads t2 as ptr == head
	mv t2, s0
forloop:
	# Gets ptr.next
	# Ptr.next = t3
	# Node value of pt.next = t4
	addi t3, t2, 16
	lw t4, (t3)
	beqz t4, endfor # If ptr.next == null break;
	
	
	# Student id is 8 bytes away from the start of that node
	# Loads ptr.next.studentID = t4
	lw t4, 8(t4)
	# t5 = min.studentid
	# Loads min.studentID = t5
	lw t5, 8(t0)
	# Gets one less then min accounts for >=
	addi t6, t5, - 1
	# if (ptr - >next - >studentid < min - >studentid ) {
	
	
ifmin:
	# If >= min then branch
	bgt t4, t6, endifmin
	# min = ptr - >next          ;
	# beforeMin = ptr            ;
	lw t0, (t3)
	mv t1, t2
endifmin:
	
	# Sets pt = pt.next
	lw t2, (t3)
	b forloop
endfor:
	
if2:
	# if (min != head)
	# swapNodes(&head, head, min, beforeMin);
	
	# t3 = min
	# t4 = head
	lw t3, 8(t0)
	lw t4, 8(s0)
	beq t3, t4, swapEnd
	
swap:
	# Stores head in the stack and give a0 the address
	sw s0, 4(sp)
	addi a0, sp, 4
	mv a1, s0
	mv a2, t0
	mv a3, t1
	jal swapNodes
	lw s0, 4(sp)
swapEnd:
	lw a0, 16(s0)
	jal recurSelectionSort
	
	sw a0, 16(s0)
	mv a0, s0
	
return:
	lw ra, 12(sp) # Restores the ra from the stack
	lw s0, 8(sp) # Restores the value of of s0 from the stack
	addi sp, sp, 16 # Frees space in stack
	ret
