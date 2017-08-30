        .data
        hextable:	.ascii "0123456789abcdef"
        msg1:		.asciiz "Your number in Hex is: "
        .text
        .globl main
        main:
        li $v0, 5		#syscall for read_int
        syscall
        add $s1, $v0, $0
        li $v0, 4		#syscall for print_str
        la $a0, msg1
        syscall
        la $a1, hextable
        srl	$t0, $s1, 4	#get upper 4 bits
        add $a2, $a1, $t0	#get address in hextable
        lb $a0, 0($a2)		#get character
        li $v0, 11		#syscall for print_char
        syscall
        andi $t0, $s1, 0xf	#get lower 4 bits
        add $a2, $a1, $t0	#get address in hextable
        lb $a0, 0($a2)		#get character
        li $v0, 11		#syscall for print_str
        syscall
	li   $v0, 10            # system call for exit
	syscall                 # we are out of here.