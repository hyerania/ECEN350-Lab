	.data
        msg1: .asciiz "Enter a number\n"
        msg:  .asciiz "The factorial is: "
	.text
	.globl main
	main:
	la $a0, msg1        #load address of msg1 into $a0
	li $v0, 4
	syscall             #print msg1
	li $v0, 5
	syscall             #read_int
	add $a0, $v0, $0    #put in $a0; $a0 = n
	jal factorial	    #jump and link to factorial
	
	add $s0, $v0, $0    #stores result
	li $v0, 10 	    #exit
	syscall
	
	my_mul:                 #multiply $a0 with $a1
        #does not handle negative $a1!
        #Note: This is an inefficient way to multipy!
        addi $sp, $sp, -4   #make room for $s0 on the stack
        sw $s0, 0($sp)      #push $s0

        add $s0, $a1, $0   #set $s0 equal to $a1
        add $v0, $0, $0    #set $v0 to 0
        mult_loop:
        beq $s0, $0, mult_eol

        add $v0, $v0, $a0
        addi $s0, $s0, -1
        j mult_loop

        mult_eol:
        lw $s0, 0($sp)      #pop $s0
        addi $sp,$sp,4	    #added line
        jal fact_loop

	factorial:		
	addi $sp, $sp, -8	# Make room for return address
	sw $ra, 0($sp)		# store the value of the return addrress
	sw $a0, 4($sp)		# store the value of n
	add $a1, $a0, $0    	# $a1 = n, counter
	slti $t0, $a1, 1	# test n < 1
	beq $t0, $0, fact_loop	# if (n>=1) go to fact_loop
	addi $v0, $0, 1		# $v0 = 1, for any number less than 1
	addi $sp, $sp, 8	# adjust stack pointer
	jr $ra			#return to caller
	
	fact_loop:
	addi $t0, $0, 1		#$t0 = 1, used for comparison
	beq $a1, $t0, fact_return # if (n == 1) go to fact_return
	addi $a1, $a1, -1	# decroment $a1
	add $a0, $v0, $0	# store the result in $a0
	jal my_mul		# call on my_mul

	fact_return:
	lw $a0, 4($sp)		# restore argument n
	lw $ra, 0($sp)		# restore return address
	addi $sp, $sp, 8	# gives the space back to the stack 
	jr $ra			# return to caller
