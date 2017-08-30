        .data
        msg1:	.word 0:24
        .text
        .globl main
        main:
        li $v0, 8		#syscall for read_str
        la $a0, msg1		#load address of msg1 to store string
        li $a1, 100		#msg1 is 100 bytes
        syscall
        lb $t0, 5($a0)	#load the character into $t0
        li $t1, 'a'		#get value of 'a'
        blt $t0, $t1, nomodify #do nothing if letter is less than 'a'
        li $t1, 'z'		#get value of 'z'
        bgt $t0, $t1, nomodify #do nothing if letter is greater than 'z'
        addi $t0, $t0, -0x20 	#encap the letter
        sb $t0, 5($a0) 	#store the new letter
        nomodify:
        li $v0, 4		#syscall for print_str
        syscall
	li   $v0, 10            # system call for exit
	syscall                 # we are out of here.