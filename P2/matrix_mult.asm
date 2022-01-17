.data
inone: .space 256
intwo: .space 256
result: .space 256
str_space: .asciiz " "
str_enter: .asciiz "\n"

##�궨��
.macro getaddress(%ans, %i, %j)
    sll %ans, %i, 3
    add %ans, %ans, %j
    sll %ans, %ans, 2
.end_macro

.text
    li $v0, 5
    syscall
    move $s0, $v0   ###  $s0����������
   
    li $t0, 0
    li $t1, 0
    li $t2, 0
inone_i:               ###�����һ������
    beq $t0, $s0, inone_i_end  ##��ѭ��
    li $t1, 0 
inone_j:
    beq $t1, $s0, inone_j_end  ##��ѭ��
    li $v0, 5
    syscall
    getaddress($t2,$t0,$t1)
    sw $v0, inone($t2)
    addi $t1, $t1, 1
    j inone_j
inone_j_end:
    addi $t0, $t0, 1
    j inone_i
inone_i_end:
    li $t0, 0
    
intwo_i:            ###����ڶ�������
    beq $t0, $s0, intwo_i_end  ##��ѭ��
    li $t1, 0 
intwo_j:
    beq $t1, $s0, intwo_j_end  ##��ѭ��
    li $v0, 5
    syscall
    getaddress($t2,$t0,$t1)
    sw $v0, intwo($t2)
    addi $t1, $t1, 1
    j intwo_j
intwo_j_end:
    addi $t0, $t0, 1
    j intwo_i
intwo_i_end:
    li $t0, 0


mux_i:
    beq $t0, $s0, mux_i_end
    li $t1, 0
mux_j:
    beq $t1, $s0, mux_j_end
    li $t2, 0
mux_k:
    beq $t2, $s0, mux_k_end
    getaddress($t3, $t0, $t2)
    lw $s1, inone($t3)            ###������Ӧ��aԪ��
    getaddress($t4, $t2, $t1)
    lw $s2, intwo($t4)            ###������Ӧ��bԪ��
    mult $s1,$s2                  ###a,b���
    mflo $s3                      
    add $s4, $s4, $s3             ###�ۼ�,$s4Ϊresult����Ԫ��
    addi $t2, $t2, 1
    j mux_k
mux_k_end:
    getaddress($t5, $t0, $t1)
    sw $s4, result($t5)           ###�洢result����Ԫ��
    li $s4, 0
    addi $t1, $t1, 1
    j mux_j
mux_j_end:
    addi $t0, $t0, 1
    j mux_i
mux_i_end:
    li $t0, 0
    li $t1, 0
    li $t2, 0

####����Ҫ�����result����
out_i:
    beq $t0, $s0, out_i_end
    li $t1, 0
out_j:
    beq $t1, $s0, out_j_end
    getaddress($t2, $t0, $t1)
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








