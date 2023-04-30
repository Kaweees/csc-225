.global addnums, subnums, multnums, divnums, andnums, ornums, xornums, lshiftnums, rshiftnums
.text

# Subroutine to add two integers
# Inputs: a0, a1 - the integers to add
addnums:
	add a0, a0, a1
	ret # return to caller
  # end subroutine

# Subroutine to subtract two integers
# Inputs: a0, a1 - the integers to subtract
subnums:
	sub a0, a0, a1
  ret # return to caller
  # end subroutine

# Subroutine to multiply two integers
# Inputs: a0, a1 - the integers to multiply
multnums:
  mul a0, a0, a1
  ret # return to caller
  # end subroutine

# Subroutine to divide two integers
# Inputs: a0, a1 - the integers to divide
divnums:
  div a0, a0, a1
  ret # return to caller
  # end subroutine

# Subroutine to 'and' two integers
# Inputs: a0, a1 - the integers to and
andnums:
  and a0, a0, a1
  ret # return to caller
  # end subroutine

# Subroutine to 'or' two integers
# Inputs: a0, a1 - the integers to or
ornums:
  or a0, a0, a1 
  ret # return to caller
  # end subroutine

# Subroutine to 'xor' two integers
# Inputs: a0, a1 - the integers to xor
xornums:
  xor a0, a0, a1
  ret # return to caller
  # end subroutine

# Subroutine to left shift a number a given amount of times
# Inputs: a0 - the number to shift, a1 - the amount of times to shift
lshiftnums:
  slli a0, a0, a1
  ret # return to caller
  # end subroutine

# Subroutine to right shift a number a given amount of times
# Inputs: a0 - the number to shift, a1 - the amount of times to shift
rshiftnums:
  srl a0, a0, a1
  ret # return to caller
  # end subroutine