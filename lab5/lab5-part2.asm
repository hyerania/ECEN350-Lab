        .data
        in_string:  .asciiz     "Input a positive integer:\n\n"
        out_string: .asciiz     "The Fibonacci number is:\n\n"

        .globl in_string # in_string is a global label
        .globl out_string
        .globl Fib
        .align 2
        .text


        #####################################################################
        # Fibonacci subroutine                                              #
        # input:  integer n, on stack                                       #
        # output: Fib(n), nth Fibonacci number                              #
        # description: recursively computes   Fib(n) = Fib(n-1) + Fib(n-2), #
        #                                     Fib(1) = Fib(2) = 1.          #
        # uses: $t0, $t1                                                    #
        #####################################################################


        Fib:
        # procedure prologue:
        sw $ra,($sp)            # save return address on stack, since recursive,
        addi $sp,$sp,-4         #   and decrement stack pointer
        sw $fp,($sp)            # save previous frame pointer on stack
        addi $sp,$sp,-4         #   and decrement stack pointer
        add $fp,$sp,12          # set frame pointer to point at base of stack frame

        lw $t0,($fp)            # copy argument to $t0:  $t0 = n
        li $t1, 2
        bgt $t0,$t1,do_recurse  # if argument n >= 2, branch to recursive sequence
        li $t0, 1               #   else set result to 1 (base cases  n = 1 and  n = 2)
        b epilogue              # branch to end

        do_recurse:
        addi $t0,$t0,-1         # $t0 = n-1
        sw $t0,($sp)            # push argument n-1 on stack
        addi $sp,$sp,-4         #   and decrement stack pointer
        jal Fib                 # call Fibonacci with argument n-1
        # leave result on stack for now
        lw $t0,($fp)            # re-copy argument to $t0:  $t0 = n
        addi $t0,$t0,-2         # $t0 = n-2
        sw $t0,($sp)            # push argument n-2 on stack
        addi $sp,$sp,-4         #   and decrement stack pointer
        jal Fib                 # call Fibonacci with argument n-2
        addi $sp,$sp,4          # increment stack pointer
        lw $t0,($sp)            #   and pop result of Fib(n-2) from stack into $t0
        addi $sp,$sp,4          # increment stack pointer
        lw $t1,($sp)            #   and pop result of Fib(n-1) from stack into $t1
        add $t0,$t0,$t1         # $t0 = Fib(n-2) + Fib(n-1); have result

        epilogue:                   # procedure epilogue: $t0 holds result
        addi $sp,$sp,4          # increment stack pointer
        lw $fp,($sp)            #   and pop saved frame pointer into $fp
        addi $sp,$sp,4          # increment stack pointer
        lw $ra,($sp)            #   and pop return address into $ra
        addi $sp,$sp,4          # increment stack pointer
        #   to pop argument (n) from stack (discard)
        sw $t0,($sp)            # push result onto stack
        addi $sp,$sp,-4         #   and decrement stack pointer
        jr $ra                  # return to caller

        ####################
        # end of Fibonacci #
        ####################
