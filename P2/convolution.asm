.data
scan: .space 576
core: .space 576
result: .space 576
str_space: .asciiz " "
str_enter: .asciiz "\n"

###宏定义
.macro getindex(%ans, %i, %j)
    li $t8, 10
    mult %i, $t8
    mflo %ans
    add %ans, %ans, %j
    sll %ans, %ans, 2
.end_macro 
.text
    li $v0, 5
    syscall
    move $s0, $v0    ####输入m1
    
    li $v0, 5
    syscall
    move $s1, $v0    ####输入n1
    
    li $v0, 5
    syscall
    move $s2, $v0     ####输入m2
    
    li $v0, 5
    syscall
    move $s3, $v0     ####输入n2
    li $t0, 0
in_one_i:
    beq $t0, $s0, in_one_i_end
    li $t1, 0
in_one_j:
    beq $t1, $s1, in_one_j_end
    li $v0, 5
    syscall
    getindex($t2, $t0, $t1)
    sw $v0, scan($t2)
    addi $t1, $t1, 1
    j in_one_j
in_one_j_end:
    addi $t0, $t0, 1
    j in_one_i
in_one_i_end:
    li $t0, 0
    
in_two_i:
    beq $t0, $s2, in_two_i_end
    li $t1, 0
in_two_j:
    beq $t1, $s3, in_two_j_end
    li $v0, 5
    syscall
    getindex($t2, $t0, $t1)
    sw $v0, core($t2)
    addi $t1, $t1, 1
    j in_two_j
in_two_j_end:
    addi $t0, $t0, 1
    j in_two_i
in_two_i_end:
    li $t0, 0
    li $t1, 0
    li $t2, 0
    li $t3, 0

    sub $s4, $s0, $s2
    addi $s4, $s4 ,1   ####m1-m2+1
    sub $s5, $s1, $s3
    addi $s5, $s5, 1   ####n1-n2+1  
convol_i:
    beq $t0, $s4, convol_i_end      ####i
    li $t1, 0    
convol_j:
    beq $t1, $s5, convol_j_end      ####j
    li $t2, 0
convol_k:
    beq $t2 ,$s2, convol_k_end      ####k
    li $t3, 0
convol_l:
    beq $t3, $s3, convol_l_end
    add $t4, $t0, $t2
    add $t5, $t1, $t3
    getindex($t4, $t4, $t5)
    lw $t6, scan($t4)
    getindex($t5, $t2, $t3)
    lw $t7, core($t5)
    mult $t6, $t7
    mflo $s6
    add $s7, $s7, $s6
    addi $t3, $t3, 1
    j convol_l
convol_l_end:
    addi $t2, $t2, 1
    j convol_k
convol_k_end:
    getindex($t4, $t0, $t1)
    sw $s7, result($t4)
    li $s7, 0
    addi $t1, $t1, 1
    j convol_j
convol_j_end:
    addi $t0, $t0, 1
    j convol_i
convol_i_end:
    li $t0, 0
    li $t1, 0

out_i:
    beq $t0, $s4, out_i_end
    li $t1, 0
out_j:
    beq $t1, $s5, out_j_end
    getindex($t2, $t0, $t1)
    lw $a0, result($t2)
    li $v0, 1
    syscall
    la $a0, str_space
    li $v0, 4
    syscall
    addi $t1, $t1, 1
    j out_j
out_j_end:
    addi $t0, $t0, 1
    la $a0, str_enter
    li $v0, 4
    syscall
    j out_i
out_i_end:
    li $v0, 10
    syscall











