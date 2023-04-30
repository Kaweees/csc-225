	#ecall test script
	
	.text
	.globl main
main:
	#stinkup the caller save registers
	li a0, - 1
	li a1, - 1
	li a2, - 1
	li a3, - 1
	li a4, - 1
	li a5, - 1
	li a6, - 1
	li a7, - 1
	li t0, - 1
	li t1, - 1
	li t2, - 1
	li t3, - 1
	li t4, - 1
	li t5, - 1
	li t6, - 1
	
	#preload the callee save registers to check later.
	li s0, - 1
	li s1, - 1
	li s2, - 1
	li s3, - 1
	li s4, - 1
	li s5, - 1
	li s6, - 1
	li s7, - 1
	li s8, - 1
	li s9, - 1
	li s10, - 1
	li s11, - 1
	
	la a0, startmsg
	jal printstring
	
	
	jal printchartest
	
	jal readchartest
	
	jal printinttest
	jal readinttest
	b done # once printstring works, move this line down by one.
done:
	jal regcheck
	jal exit0
	
	#should not reach this line
	li a7, 93
	li a0, - 1
	ecall
	
	.data
startmsg: .string "starting mecall test"
promptstr: .string "\ntype a string and press enter: "
response: .string "\nyou typed :"
printintmsg1: .string "\nprinting the number 4. the number is:"
printintmsg2: .string "\ndid you see number 4 printed?"
readintmsg1: .string "\nenter the number '9' : "
readintpassmsg: .string "\nreadint passed. the number 9 detected."
readintfailmsg: .string "\nreadint failed. the number 9 not detected."
promptchar: .string "\nenter the letter 'z': "
readcharpass: .string "\nreadchar passed. the letter z detected."
readcharfail: .string "\n readchar fails. the letter z was not typed."
printcharmsg: .string "\nlets print the letter 'a' : "
printcharmsg2: .string "\ndid you see the letter 'a' get printed?"
regerrmsg: .string "\ncallee save registers corrupted"
regpassmsg: .string "\ncallee save register check passes"
respint: .word 0
respchar: .byte '\0'
respstr: .space 20
	
	.text
	
readstringtest: #8
	addi sp, sp, - 16
	sw ra, 12(sp)
	la a0, promptstr
	jal printstring
	la a0, respstr
	jal readstring
	la a0, response
	jal printstring
	
	la a0, respstr
	jal printstring
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
printchartest: #11
	addi sp, sp - 16
	sw ra, 12(sp)
	la a0, printcharmsg
	jal printstring
	li a0, 'a'
	jal printchar
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
readchartest: #12
	addi sp, sp, - 16
	sw ra, 12(sp)
	sw s0, 8(sp)
	
	la a0, promptchar
	jal printstring
	
	jal readchar
	li t0, 'z'
	bne a0, t0, notz
	la a0, readcharpass
	jal printstring
	b endreadchartest
notz:
	la a0, readcharfail
	jal printstring
endreadchartest:
	lw s0, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
	
printinttest: #11
	addi sp, sp - 16
	sw ra, 12(sp)
	la a0, printintmsg1
	jal printstring
	li a0, 4
	jal printint
	la a0, printintmsg2
	jal printstring
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
readinttest: #12
	addi sp, sp, - 16
	sw ra, 12(sp)
	la a0, readintmsg1
	jal printstring
	jal readint
	li t0, 9
	bne a0, t0, not9
	la a0, readintpassmsg
	jal printstring
	b endreadinttest
not9:
	la a0, readintfailmsg
	jal printstring
endreadinttest:
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
	
regcheck:
	#break callee save register usage rules because i'm the boss.
	addi sp, sp - 16
	sw ra, 12(sp)
	li a0, - 1
	bne s0, a0, regerror
	bne s1, a0, regerror
	bne s2, a0, regerror
	bne s3, a0, regerror
	bne s4, a0, regerror
	bne s5, a0, regerror
	bne s6, a0, regerror
	bne s7, a0, regerror
	bne s8, a0, regerror
	bne s9, a0, regerror
	bne s10, a0, regerror
	bne s11, a0, regerror
	la a0, regpassmsg
	jal printstring
	b endregcheck
	
regerror:
	la a0, regerrmsg
	jal printstring
endregcheck:
	lw ra, 12(sp)
	addi sp, sp 16
	ret
