.data
text: .asciiz "halo ini string"
.text
.globl main
main:
	li $v0, 4
	la $a0, text
	syscall
	
	li $v0, 5
	syscall
	
	addi $t0, $v0, 10
	
	li $v0, 1
	add $a0, $t0, $t0
	syscall
	
	li $v0, 10
	syscall
