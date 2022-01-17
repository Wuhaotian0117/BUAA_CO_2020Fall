.data
array1: .space 400
array2: .space 400
str_space: .asciiz " "
str_enter: .asciiz "\n"

.macro getindex(%ans,%i)
    sll %ans,%i,2
.end_macro

.text
    li $v0, 5
    syscall
    move $s0,$v0  ###count of total num n
    li $v0, 5
    syscall
    move $s1,$v0  ###the special order m 
    
    li $t0,1      ###i
    li $s2,0      ###count
    li $t1,0      ###j
in_i:
    getindex($t2,$t0)
    lw $t3,array1($t2)
    bne $t3,0,else
    addi $t1,$t1, 1
    
else:
    bne $t1,$s1,loop
    li $t3, 1
    sw $t3,array1($t2)
    getindex($t2,$s2)
    sw $t0,array2($t2)
    addi $s2,$s2,1
    li $t1, 0
loop:
    beq $s2,$s0,in_i_end
    div $t0,$s0
    mfhi $t0
    addi $t0,$t0, 1
    j in_i

in_i_end:
   li $t0, 0
out:
    beq $t0,$s2,out_end
    getindex($t1,$t0)
    lw $a0,array2($t1)
    li $v0, 1
    syscall
    la $a0,str_space
    li $v0, 4
    syscall
    addi $t0,$t0, 1
    j out
out_end:
    li $v0, 10
    syscall 




