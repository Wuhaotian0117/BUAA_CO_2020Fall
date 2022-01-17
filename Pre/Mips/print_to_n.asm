.data
str: .asciiz "Please enter your integer n:\n" 
.text
la $a0, str
li $v0, 4
syscall

li $v0, 5
syscall
move $s0, $v0
li $s1, 0  #用于累加计数
li $t0, 1  ##用作循环变量

loop:
bgt $t0, $s0, loop_end
add $s1 ,$s1, $t0
addi $t0, $t0, 1
j loop
loop_end:
move $a0, $s1
li $v0, 1
syscall
li $v0, 10
syscall