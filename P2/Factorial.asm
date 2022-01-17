.data
array: .space 4000

.macro getindex(%ans,%i)
    sll %ans,%i,2
.end_macro

.text
    li $v0, 5
    syscall
    move $s0,$v0
    li $s3,10
    
    bne $s0,$zero,else
    li $a0,1
    li $v0, 1
    syscall
    j endprocedure
else:
    li $t0, 1
    li $t1, 0
    sw $t0,array($t1)
    
in_i:
    bgt $t0,$s0,in_i_end
    li $s1, 0           ###$s1 is carry
    li $t1, 0
in_j:
    beq $t1,999,in_j_end
    getindex($t2,$t1)
    lw $t3,array($t2)
    mul $s2,$t3,$t0      ###$s2 is product
    add $s2,$s2,$s1
    div $s2,$s3
    mfhi $t3
    mflo $s1
    sw $t3,array($t2)
    addi $t1,$t1,1
    j in_j
in_j_end:
    addi $t0,$t0,1
    j in_i
    
in_i_end:
    li $t0,999
while:
    blt $t0,0,out
    getindex($t1,$t0)
    lw $t2,array($t1)
    bne $t2,0,out
    addi $t0,$t0,-1
    j while
out:    
    blt $t0,0,endprocedure
    getindex($t1,$t0)
    lw $a0,array($t1)
    li $v0,1
    syscall
    addi $t0,$t0,-1
    j out
    
endprocedure:
    li $v0, 10
    syscall
