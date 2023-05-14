	.data
	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
	# TODO
	#blzknr
	move $s1 $ra 
	move $s5 $a0
	li $t0, 0       # initialize counter to 0
	addi $a0 $a0 4
loopblz:
	beq $t0, 8, endloop  # if counter is 8, exit loop
	lb $t1, 0($a1)    # load byte from BLZ buffer
	addi $a1, $a1, 1 # increment BLZ buffer pointer
	sb $t1, 0($a0)   # store byte in IBAN buffer
	addi $a0, $a0, 1 # increment IBAN buffer pointer
	addi $t0, $t0, 1 # increment counter
	j loopblz           # repeat loop
	
endloop:
	li $t0, 0 
loopiban:
	beq $t0, 10, endloop1  # if counter is 10, exit loop
	lb $t1, 0($a2)    # load byte from KNR buffer
	addi $a2, $a2, 1 # increment KNR buffer pointer
	sb $t1, 0($a0)   # store byte in IBAN buffer
	addi $a0, $a0, 1 # increment IBAN buffer pointer
	addi $t0, $t0, 1 # increment counter
	j loopiban           # repeat loop
		
endloop1:
 li $t1 68
 sb $t1 -22($a0)
 li $t1 69
 sb $t1 -21($a0)
 li $t1 0x30
 sb $t1 -20($a0)
 li $t1 0x30
 sb $t1 -19($a0)
 addi $a0 $a0 -22


 jal validate_checksum
 li $t1 98
 sub $v0 $t1 $v0
 move $t7 $a0
 addi $a1 $s5 2 #prep a1
 move $a0 $v0  # prep a0
 li $a2 2 #prep a1

 jal int_to_buf
move $ra $s1 
 jr $ra
