.data
connect: .asciiz "-->"
str_enter: .asciiz "\n"
str_a: .asciiz "A"
str_b: .asciiz "B"
str_c: .asciiz "C"
.macro swap(%i,%j)
    move $t0,%i
    move %i,%j
    move %j,$t0
.end_macro 

.text
    li $v0, 5
    syscall
    move $a0,$v0
    la $a1,str_a
    la $a2,str_b
    la $a3,str_c
    jal hanoi
    
    li $v0,10
    syscall
hanoi:
    bgt $a0,1,work
    move $a0,$a1
    li $v0, 4
    syscall
    la $a0,connect
    li $v0, 4
    syscall
    move $a0,$a3
    li $v0, 4
    syscall
    la $a0,str_enter
    li $v0, 4
    syscall
    jr $ra
work:
    addi $sp,$sp,-20
    sw $ra,16($sp)
    sw $a0,12($sp)
    sw $a1,8($sp)
    sw $a2,4($sp)
    sw $a3,0($sp)
    addi $a0,$a0,-1
    swap($a2,$a3)
    jal hanoi
    
    lw $a3,0($sp)
    lw $a2,4($sp)
    lw $a1,8($sp)
    lw $a0,12($sp)
    lw $ra,16($sp)
    addi $sp,$sp,20
    
    move $t2,$a0
    move $a0,$a1
    li $v0, 4
    syscall
    la $a0,connect
    li $v0, 4
    syscall
    move $a0,$a3
    li $v0, 4
    syscall
    la $a0,str_enter
    li $v0, 4
    syscall
    move $a0,$t2
    
    addi $sp,$sp,-20
    sw $ra,16($sp)
    sw $a0,12($sp)
    sw $a1,8($sp)
    sw $a2,4($sp)
    sw $a3,0($sp)
    addi $a0,$a0,-1
    swap($a1,$a2)
    jal hanoi
    lw $a3,0($sp)
    lw $a2,4($sp)
    lw $a1,8($sp)
    lw $a0,12($sp)
    lw $ra,16($sp)
    addi $sp,$sp,20
    
    jr $ra
    
    
    
    
