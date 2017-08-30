.data 
        .align 2

.text 

        main:
        # print out prompt
        li $v0, 4               # system call code for printing string = 4
        la $a0, in_string       # load address of string to be printed into $a0
        syscall                 # call operating system to perform print operation

        # read integer into $s0
        li $v0, 5               # system call code for read integer = 5
        syscall                 # call operating system
        move $s0, $v0           # value read from keyboard returned in register $v0; transfer to $s0

        sw $s0,($sp)            # push argument for Fib on stack
        addi $sp,$sp,-4         #   and decrement stack pointer
        jal Fib                 # jump to subroutine
        addi $sp,$sp,4          # increment stack pointer
        lw $s1,($sp)            #   and pop result from stack

        # print out prompt
        li $v0, 4               # system call code for printing string = 4
        la $a0, out_string      # load address of string to be printed into $a0
        syscall                 # call operating system

        # print out result (stored in $s1)
        li $v0, 1               # system call code for printing integer = 1
        move $a0, $s1           # move integer to be printed into $a0:  $a0 = $s1
        syscall                 # call operating system to perform print
        jr $ra
