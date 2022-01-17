.data
str_read: .space 24

.text
    li $v0, 5                ###此程序为回文数
    syscall
    move $s0, $v0           ###读入字符串长度n
    
    li $t0, 0
in:
    beq $t0, $s0, in_end     ###读入字符串
    li $v0, 12
    syscall
    sb $v0, str_read($t0)
    addi $t0, $t0, 1
    j in
in_end:
    li $t0, 0           ###i
    addi $t1, $s0, -1   ###j

    li $s1, 1
    beq $s0, $s1, judge_end   ###额外判断字符串长度为一的时候         
judge:
    sleu $t2, $t0, $t1           ###i<=j,循环继续
    beq $t2, $zero, judge_end    ###循环至结尾，结果为1
    lb $t3, str_read($t0)
    lb $t4, str_read($t1)
    bne $t3, $t4, program_out   ###中间判断出不相等，结束循环，输出结果为0
    addi $t0, $t0, 1
    addi $t1, $t1, -1
    j judge
    
judge_end:                ###正常结束循环，结果为1，回文数
    li $a0, 1
    li $v0, 1
    syscall
    li $v0, 10
    syscall
program_out:             ###中间结束循环，结果为0，
    li $a0, 0
    li $v0, 1
    syscall
    li $v0, 10
    syscall   
