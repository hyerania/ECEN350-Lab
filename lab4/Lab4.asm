	.data
        msg1: .asciiz "Enter the first number\n"
        msg2: .asciiz "Enter the second number\n"
        msg:  .asciiz "The product is "
        .text
        .globl main
        .globl my_mul

        main:
#        addi $sp, $sp, -8   #make room for $ra and $fp on the stack
#        sw $ra, 4($sp)      #push $ra
#        sw $fp, 0($sp)      #push $fp

        la $a0, msg1        #load address of msg1 into $a0
        li $v0, 4
        syscall             #print msg1
        li $v0, 5
        syscall             #read_int
        add, $t0, $v0, $0   #put in $t0
        la $a0, msg2        #load address of msg2 into $a0
        li $v0, 4
        syscall             #print msg2
        li $v0, 5
        syscall             #read_int
        add $a1, $v0, $0    #put in $a1
        add $a0, $t0, $0    #put first number in $a0
        add $fp, $sp, $0    #set fp to top of stack prior
        #to function call
        jal my_mul          #do mul, result is in $v0
        add $t0, $v0, $0    #save the result in $t0
        la $a0, msg
        li $v0, 4
        syscall             #print msg
        add $a0, $t0, $0    #put computation result in $a0
        li $v0, 1
        syscall             #print result number

 #       lw $fp, 0($sp)      #restore (pop) $fp
 #       lw $ra, 4($sp)      #restore (pop) $ra
 #       addi $sp, $sp, 8    #adjust $sp
 #       jr $ra              #return
 
	addi $v0,$0,10
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
        addi $sp,$sp,4	    #added line, restores stack
        jr $ra
