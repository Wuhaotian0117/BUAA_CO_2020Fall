.data
str_read: .space 24

.text
    li $v0, 5                ###�˳���Ϊ������
    syscall
    move $s0, $v0           ###�����ַ�������n
    
    li $t0, 0
in:
    beq $t0, $s0, in_end     ###�����ַ���
    li $v0, 12
    syscall
    sb $v0, str_read($t0)
    addi $t0, $t0, 1
    j in
in_end:
    li $t0, 0           ###i
    addi $t1, $s0, -1   ###j

    li $s1, 1
    beq $s0, $s1, judge_end   ###�����ж��ַ�������Ϊһ��ʱ��         
judge:
    sleu $t2, $t0, $t1           ###i<=j,ѭ������
    beq $t2, $zero, judge_end    ###ѭ������β�����Ϊ1
    lb $t3, str_read($t0)
    lb $t4, str_read($t1)
    bne $t3, $t4, program_out   ###�м��жϳ�����ȣ�����ѭ����������Ϊ0
    addi $t0, $t0, 1
    addi $t1, $t1, -1
    j judge
    
judge_end:                ###��������ѭ�������Ϊ1��������
    li $a0, 1
    li $v0, 1
    syscall
    li $v0, 10
    syscall
program_out:             ###�м����ѭ�������Ϊ0��
    li $a0, 0
    li $v0, 1
    syscall
    li $v0, 10
    syscall   
