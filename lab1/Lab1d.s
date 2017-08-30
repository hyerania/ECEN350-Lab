    .text               # text section
    .globl main         # call main by MARS
    main:
    addi $4, $0, 10	# Add the value 10 to $4 to test
    addi $5, $0, 2	# Add the value 2 to $5 to test
    
    add $t0, $0, $4	# Add the content from $4 to $t0 for temporary storage
    add $4, $0, $5	# Add the content from $5 to $4 to begin the swapping
    add $5, $0, $t0	# Add the content stored in $t0 to $5, finishing the swap

    li $v0, 10		# call to exit the program
    syscall 		# exit program