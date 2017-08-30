        .data
        msg1:	.asciiz "A 17 byte message\n"
        msg2:	.asciiz "Another message of 27 bytes\n"
        num1:	.byte 45
        num2:	.half 654
        num3:	.word 0xcafebabe
        num4:	.word 0xfeedface
	.text
        .globl main
        main:
        li $v0, 4		#system call for print_str
        la $a0, msg1		#address of string to print
        syscall
        la $a0, msg2		#address of string to print
        syscall
        lb $t0, num1		#load num1 into $t0
        lh $t1, num2		#load num2 into $t1
        lw $t2, num3		#load num3 into $t2
        lw $t3, num4		#load num4 into $t3
	li   $v0, 10            # system call for exit
	syscall  