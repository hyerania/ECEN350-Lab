.text
.globl main

main:   li      $a1, 10
        add     $t0, $zero, $zero
loop:   beq     $a1, $zero, finish
        add     $t0, $t0, $a0
        sub     $a1, $a1, 1
        j       loop
finish: addi $t0, $t0, 100
        add  $v0, $t0, $zero
