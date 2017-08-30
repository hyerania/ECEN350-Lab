	.data
	UIN: .word	29 	#Summation of UIN, UIN: 124000985
	
	.text
	.globl main
	
	main:
	lw $t0, UIN		#Load $t0 with UIN
	addi $t1, $0, 0		# i = 0
	
	Loop: 	
	addi $t0, $t0, -1	#UIN = UIN - 1
	sw $t0, UIN		#Store $t0 into UIN
	addi $t1, $t1, 1	# i = i+1
	slti $t2, $t1, 10	#$t2 = i < 10
	bne $t2, $0, Loop	# if (i<10) go to loop
	
	Exit:	
	li $v0, 1		#system call to print integer
	add $a0, $t0, $0	#Display the value of UIN
	syscall
	li $v0, 10		#system call for exit
	syscall
