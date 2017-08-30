nop #added nop, doing nothing
nop
nop

#funca code from the prelab
funca :
li $s0, 11		#load .word 11 into register $s0
addi $s2, $zero, 1
sub $s1, $s1, $s1

loop :
sll $t0, $s2, 31
slt $t1, $t0, $zero
bne $t1, $zero, skip
add $s1, $s1, $s2

skip :
addi $s2, $s2, 1	
beq $s2, $s0, done
beq $0, $0, loop	#Go back to loop with position independence  (replace j)

done :
addi $v0, $s1, 0	#save result in $v0
jr $ra			