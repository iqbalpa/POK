.data
pesan: .asciiz "Masukkan input 10 digit: "
digit: .word 0,0,0,0,0,0,0,0,0,0
selisih: .word 0,0,0,0,0,0,0,0,0
.text

.globl main
main:

la $t0,digit 			# menyimpan address array digit ke t0

li $v0,4			# menampilkan pesan
la $a0,pesan
syscall
li $v0,5			# meminta input integer
syscall
add $s0,$v0,$zero		# menyimpan input ke s0

addi $t2,$zero,10		# t2 = 10 sebagai counter
addi $s1,$zero,10		# s1 = 10


# loop1 untuk menyimpan 10 digit di  array digit secara terbalik
loop1:
	div $s0,$s1		# s0 / 10
	mflo $s0		# simpan hasil ke s0
	mfhi $t3		# simpan sisa ke t3
	
	sw $t3,0($t0)		# store sisa pembagian ke $t0
	addi $t0,$t0,4		# t0 + 4
	
	addi $t2,$t2,-1		# t2 - 1
	bgt $t2,$zero,loop1	# jika $t2 > 0, maka akan balik ke loop1
	

la $t0,digit			# menyimpan address array digit ke t0
la $t1,selisih			# menyimpan address array selisih ke t1
addi $t4,$t0,4			# menyimpan address elemen ke2 di array digit

addi $t5,$zero,9		# t5 = 9 untuk counter

# loop2 untuk menyimpan hasil selisih 2 digit di array selisih
loop2:
	lw $t6,0($t0)		# load elemen di address t0 ke t6
	lw $t7,0($t4)		# load elemen di address t4 ke t7
	
	sub $t8,$t6,$t7		# t8 = t6 - t7
	abs $t8,$t8		# nilai mutlak t8
	sw $t8,0($t1)		# store t8 ke t1
	
	addi $t0,$t0,4		# t0 + 4
	addi $t4,$t4,4		# t4 + 4
	addi $t1,$t1,4		# t1 + 4
	
	addi $t5,$t5,-1		# t5 - 1
	bgt $t5,$zero,loop2	# jika t5 > 0, maka akan balik ke loop2


la $t1,selisih			# menyimpan address array selisih ke t1
addi $t5,$zero,9		# t5 = 9 untuk counter
output:
	li $v0,1		# print integer elemen di array selisih
	lw $a0,0($t1)		
	syscall
	
	addi $t1,$t1,4		# t1 + 4
	addi $t5,$t5,-1		# t5 - 1
	
	bgt $t5,$zero,output	# jika t5 > 0, maka akan balik ke output

exit:
li $v0,10
syscall
