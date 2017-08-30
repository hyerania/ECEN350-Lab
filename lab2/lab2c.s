	.data
	msg1:	.word 0:24
	.text
	.globl main

	main:
	li $v0, 8	#syscall for read_string
	la $a0, msg1	#load address of msg1 to store string
	li $a1, 100	#msg1 is 100 bytes
	syscall
	
	addi $t2, $t2, 0
	compare:
	lb $t0, 0($a0)		#load character into register $t0
	beq $t0, $0, endloop
	li $t1, 'a'		#get value of 'a'
        blt $t0, $t1, nomodify	#do nothing if letter is less than 'a'
        li $t1, 'z'		#get value of 'z'
        bgt $t0, $t1, nomodify	#do nothing if letter is greater than 'z'
        add $t2,$t2, 1		#add one to the character counter
        addi $a0,$a0,1		#move to the next character
        j compare		#branch back to compare
	
	nomodify:
	addi $a0, $a0, 1	#move to the next character
	j compare
	
	endloop:
	add $a0,$t2,$0		#Print the character count from register $t2
	li $v0, 1		#syscall for print_str
        syscall
	li   $v0, 10            # system call for exit
	syscall                 # we exit
	
	
