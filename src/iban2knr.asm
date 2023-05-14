	.data
	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
	# Save registers
	addi	$sp $sp, -20
	sw	$ra 16($sp)
	sw	$t0 12($sp)
	sw	$t1 8($sp)

	# Extract BLZ
	addi	$a0 $a0 4
	li	$t0 8

extract_blz:
	lb	$t1 0($a0)
	sb	$t1 0($a1)
	addi	$a0 $a0 1
	addi	$a1 $a1 1
	addi	$t0 $t0 -1	
	bnez	$t0 extract_blz
	# Extract KNR
	li	$t0 10			

extract_knr:
	lb	$t1, 0($a0)		
	sb	$t1, 0($a2)		
	addi	$a0, $a0, 1		
	addi	$a2, $a2, 1		
	addi	$t0, $t0, -1		
	bnez	$t0, extract_knr	
	
	# Restore registers and return
	lw	$t1 8($sp)
	lw	$t0 12($sp)
	lw	$ra 16($sp)
	addi	$sp $sp, 20
	jr	$ra
