    .text               # text section
    .globl main         # call main by MARS
    main:
    addi $t1, $0, 10	    # load immediate value (10) into $t1
    addi $t2, $0, 11	    # load immediate value (11) into $t2
    add $t1, $t1, $t1	    # multiply 4*$t1 by adding it multiple times to itself
    add $t1, $t1, $t1		
    add $t2, $t2, $t2	    # multiply 2*$t2 by adding it to itself
    add $t3, $t1, $t2   # add two numbers into $t3
    #jr $ra              # return from main; return address stored in $ra
    li $v0, 10
    syscall 		#exited program