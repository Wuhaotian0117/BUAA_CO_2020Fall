.data
array: .space 40
str_space: .asciiz " "
str_enter: .asciiz "\n"

.macro getindex(%ans,%i)
    sll %ans,%i,2
.end_macro

.macro SPACE
    la $a0,str_space
    li $v0, 4
    syscall
.end_macro 
.text
    li $v0, 5
    syscall
    move $s0,$v0   ####下界
    li $v0, 5
    syscall
    move $s1,$v0   ####上界
    
    move $t0,$s0
    li $t1,0    ####目前素数的数目
in_i:
    bgt $t0,$s1,in_i_end
    move $a0,$t0
    jal is_prime
    bne $v0,1,loop
    getindex($t2,$t1)
    sw $t0,array($t2)
    addi $t1,$t1,1
loop:
    addi $t0,$t0,1
    j in_i

in_i_end:
    li $t0,0
out_i:  ##输出逻辑
    beq $t0,$t1,out_i_end
    getindex($t2,$t0)
    lw $a0,array($t2)
    li $v0,1
    syscall
    ##la $a0,str_space
    ##li $v0, 4
    ##syscall
    SPACE
    addi $t0,$t0,1
    j out_i
out_i_end:
    la $a0,str_enter
    li $v0,4
    syscall
    addi $a0,$t1,0   ###素数的个数
    li $v0,1
    syscall
    li $v0,10
    syscall

is_prime:
    li $t6,1
    beq $a0,1,is_one
    bne $a0,2,else
    li $v0,1
    jr $ra
else:
    li $t3,2
    mul $t4,$t3,$t3
begin_i:
    bgt $t4,$a0,begin_end
    div $a0,$t3
    mfhi $t5
    bne $t5,0,loop_i
    li $t6,0
    j begin_end
loop_i:
    addi $t3,$t3,1
    mul $t4,$t3,$t3
    j begin_i
is_one:
    li $t6,0
begin_end:
    move $v0,$t6
    jr $ra
