#runtest using 123456789 as the text input for readstring.
.text
.globl main 		
main:

#init saved registers.
   li      s0, -1
   li      s1, -1
   li      s2, -1
   li      s3, -1
   li      s4, -1
   li      s5, -1
   li      s6, -1
   li      s7, -1
   li      s8, -1
   li      s9, -1
   li      s10, -1
   li      s11, -1

#init temp registers.
   li      t0, -1
   li      t1, -1
   li      t2, -1
   li      t3, -1
   li      t4, -1
   li      t5, -1
   li      t6, -1

#init arg registers.
   li      a0, -1
   li      a1, -1
   li      a2, -1
   li      a3, -1
   li      a4, -1
   li      a5, -1
   li      a6, -1
   li      a7, -1

   la    a0, welcome
   jal   printstring

   la    a0, mystr
   jal   readstring

   la    a0, result
   jal   printstring

   la    a0, mystr
   jal   printstring

   jal   calleesavecheck

   beqz  a0, calleepass
   la    a0, calleefailmsg
   jal   printstring
   sw 	zero, flagval, t6
calleepass:

strlen:
   la    a0, mystr
   lw		t0, 20(a0)
   li    t1, -1
   beq   t0,t1 strlenpass
   la    a0, strlenfailmsg
   jal   printstring
   sw    zero, flagval, t6
strlenpass:

strcheck:
   la    t0, myrslt
   la    t1, mystr
   li    t2, 0
strchkloop:
   lb    t3, 0 (t0)
   lb    t4, 0 (t1)
   bne   t3, t4, strchkfail
   addi  t0,t0,1
   addi  t1,t1,1
   addi  t2,t2,1
   li    t5, 20
   blt   t2, t5, strchkloop
   la    a0, strchkpassmsg
   jal   printstring
   b     strchkpass
strchkfail:
   la    a0, strchkfailmsg
   jal   printstring
strchkpass:
regusechk:
   lw    t0, flagval
   beqz  t0, exit1 

   la    a0, testpassmsg
   jal   printstring

   li		a7, 10
   ecall

exit1:
   li		a0, -1
   li		a7, 93
   ecall
   
.data
flagval:
   .word -1
welcome:
   .string  "\nStarting readstring test\nEnter a string and press enter: "
myrslt:
   .string "123456789"
   .byte -1 -1 -1 -1 -1 -1 -1 -1 -1
result:
   .string  "\nYou entered: "
testpassmsg:
   .string  "\nReadstring register usage test passed."
calleefailmsg:
   .string  "\nFail: Callee/Caller register usage problems"
strchkpassmsg:
   .string  "\nFAIL: string not stored correctly. either chars not stored in correct location, newline detected, or nullchar not stored"
strchkfailmsg:
   .string  "\nString read and stored correctly"
strlenfailmsg:
   .string  "\nFail: String too long, or chars not stored as bytes"
mystr:
   .word -1 -1 -1 -1 -1 -1 -1 -1 -1


.text
calleesavecheck:

   li    t1, -1
   bne   s0, t1 calleesavecheckfail
   bne   s1, t1 calleesavecheckfail
   bne   s2, t1 calleesavecheckfail
   bne   s3, t1 calleesavecheckfail
   bne   s4, t1 calleesavecheckfail
   bne   s5, t1 calleesavecheckfail
   bne   s6, t1 calleesavecheckfail
   bne   s7, t1 calleesavecheckfail
   bne   s8, t1 calleesavecheckfail
   bne   s9, t1 calleesavecheckfail
   bne   s10, t1 calleesavecheckfail
   bne   s11, t1 calleesavecheckfail
   li    a0, 0
   ret
calleesavecheckfail:
   li    a0, 1
   ret

