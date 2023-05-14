	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# v0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [$a0 to $a0 + $a1 - 1] modulo $a2 
modulo_str:
	# Save registers
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$a2, 4($sp)

	# Initialize remainder
	li	$v0, 0

calculate_remainder:
	beqz	$a1, restore_and_return

	# Next digit
	lb	$t0, 0($a0)
	addi	$t0, $t0, -48

	mul	$v1, $v0, 10
	add	$v1, $v1, $t0
	div	$v1, $v1, $a2

	mfhi	$v1
	move	$v0, $v1

	# Move to the next digit
	addi	$a0, $a0, 1
	addi	$a1, $a1, -1
	j	calculate_remainder

restore_and_return:
	jr	$ra
