.text
li $v0, 5     #read the integer n
syscall
move $s0, $v0
li $t0, 4
div $s0, $t0
mfhi $t1
bne $t1, $0, if_not_leap  #不等于时转移
###
li $t0, 100
div $s0, $t0
mfhi $t1
bne $t1, $0, if_is_leap #不等于时转移
###
li $t0, 400
div $s0, $t0
mfhi $t1
beq $t1, $0, if_is_leap
j if_not_leap

if_is_leap:
li $a0, 1
li $v0, 1
syscall
j end

if_not_leap:
li $a0, 0
li $v0, 1
syscall
j end

end:
li $v0, 10
syscall

