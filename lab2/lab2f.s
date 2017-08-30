	.data
	alphabet:.asciiz "abcdefghijklmnopqrstuvwxyz"
        msg1:	.asciiz "The letters are: "
        .text
        .globl main
        
        main:
        li $v0, 5		#Syscall for read_int
        syscall
        addi $t0, $v0, 0	#Store the integer for X letters in $t0
        bgt $t0, 26, end	#If the integer is greater than the number of letters in the alphabet, go to end
        
        li $v0, 4		#Syscall for print_str
        la $a0, msg1
        syscall
        
        la $a1, alphabet 	#Load the alphabet table
        move $t1, $zero		#Initialize the for loop, where i = 0
        
        
        loop:
        add $a2, $t1, $a1	#Get the address from the alphabet table
        lb $a0, 0($a2)		#Get the letter
        li $v0,11		#Syscall for print_str
        syscall
        addi $t1, $t1, 1	#Move to the next letter based on i
        slt $t3, $t1, $t0	#$t3 = i < size
        bne $t3, $0, loop	# if (i<size) go to loop
        
        end:
        li   $v0, 10            # system call for exit
	syscall                 # we exit
