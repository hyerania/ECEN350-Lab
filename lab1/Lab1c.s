.data
    msg1:	.asciiz "Please enter an integer number: "
    msg2:	.asciiz "\tFirst result: "
    msg3:	.asciiz "\tSecond result: "
    .text
    .globl main
    # Inside main there are some calls(syscall) which will change the
    # value in register $ra which initially contains the return
    # address from main. This needs to be saved.
    main:
    addu $s0, $ra, $0	# save $31 in $16
    li $v0, 4		# system call for print_str
    la $a0, msg1 		# address of string to print
    syscall
    # now get an integer from the user
    li $v0, 5 		# system call for read_int
    syscall 		# the integer placed in $v0

    # do some computation here with the integer
    addu $t0, $v0, $0 	# move the number in $v0 to $t0
    # make sure you replace Z with the first digit of your UIN
    sll $t1,$t0, 1 	#computation 1, result is in $t1
    srl $t2,$t0, 1  	#computation 2, result is in $t2
    
    # print the first result
    li $v0, 4 		# system call for print_str
    la $a0, msg2 		# address of string to print
    syscall
    li $v0, 1 		# system call for print_int
    addu $a0, $t1, $0 	# move number to print in $a0
    syscall
    # print the second result
    li $v0, 4 		# system call for print_str
    la $a0, msg3 		# address of string to print
    syscall
    li $v0, 1 		# system call for print_int
    addu $a0, $t2, $0 	# move number to print in $a0
    syscall
    # restore now the return address in $ra and return from main
    addu $ra, $0, $s0 	# return address back in $31
    jr $ra 			#return from main
