.data
symbol: .space 28
array: .space 28
one: .word 1
str_space: .asciiz " "
str_enter: .asciiz "\n"

.macro getindex(%ans,%i)    ####此题为全排列
    sll %ans,%i,2
.end_macro

.text
    li $v0,5
    syscall
    move $s0,$v0  ###s0 is n
    li $a0,0
    li $s1,1
    
    jal permutation
    li $v0, 10
    syscall
    
permutation: 
    blt $a0,$s0,work
    li $t0, 0
    li $t1, 0
    addi $sp,$sp,-4
    sw $a0,0($sp)
in_i:
    beq $t0, $s0,in_i_end
    getindex($t1,$t0)
    lw $a0,array($t1)
    li $v0, 1
    syscall
    la $a0, str_space
    li $v0, 4
    syscall
    addi $t0,$t0,1
    j in_i
in_i_end:
    la $a0,str_enter
    li $v0, 4
    syscall
    lw $a0,0($sp)
    addi $sp,$sp,4
    jr $ra

work:
    li $t3,0  
in_j:
    beq $t3,$s0, in_j_end
    getindex($t4,$t3)
    lw $t5,symbol($t4)
    bne $t5,$zero,else
    
    addi $t3,$t3,1
    getindex($t6,$a0)
    sw $t3,array($t6)
    addi $t3,$t3,-1
    sw $s1,symbol($t4)  ###此处s1当做常数1
        
    addi $sp,$sp,-12
    sw $a0,8($sp)
    sw $ra,4($sp)
    sw $t3,0($sp)
    addi $a0,$a0,1
    jal permutation
    
    lw $t3,0($sp)
    lw $ra,4($sp)
    lw $a0,8($sp)
    addi $sp,$sp, 12
    
    getindex($t4,$t3)
    sw $zero,symbol($t4)
     
else:
    addi $t3,$t3, 1
    j in_j
in_j_end:
    jr $ra
