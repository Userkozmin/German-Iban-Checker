.data
    .globl validate_checksum
    .text
# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN

validate_checksum:
move $s0 $ra #save register

 lb $t1 0($a0)
 addi $t1 $t1 -55
 move $t7 $a0
 
 move $a0 $t1 # prep a0
 addi $a1 $t7 22 #prep a1
 li $a2 2 #prep a1
 jal int_to_buf
 
 move $a0 $t7
 lb $t1 1($a0)
 addi $t1 $t1 -55
 
 move $a0 $t1 # prep a0
 addi $a1 $t7 24 #prep a1
 li $a2 2 #prep a1
 jal int_to_buf
 
 move $a0 $t7
 lb $t1 2($a0)
 sb $t1 26($a0)
 
 lb $t1 3($a0)
 sb $t1 27($a0)
 
 
 addi $a0 $a0 4
 li $a1 24
 li $a2 97
 
 li $t1 0
 li $t7 0
 jal modulo_str
 
 move $ra $s0
 jr $ra
 
