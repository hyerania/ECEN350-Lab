	.data
	my_array: .space 10	#Reserving space of size 10
	
	.text
	.globl main
	
	main:
	la $a0, my_array	#Load address of array
	addi $t0, $0, 1		# j = 1, first digit of UIN
	addi $t1, $0, 0		# i = 0
	
	Loop: 	
	sw $t0, 0($a0)		#my_array[i] = j
	addi $t0, $t0, 1	# j++
	addi $t1, $t1, 1	# i = i+1
	addi $a0, $a0, 4	#Moving to the next index in my_array (1 word =  4 bytes)
	slti $t2, $t1, 10	#$t2 = i < 10
	bne $t2, $0, Loop	#if (i < 10) go back to Loop
	
	Exit:
	li $v0, 10		#system call for exit
	syscall
	 
