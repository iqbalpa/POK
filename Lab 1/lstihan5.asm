.data
infantri: .asciiz "Masukkan jumlah infantri: "
tank: .asciiz "Masukkan jumlah tank: "
pesawat: .asciiz "Masukkan jumlah pesawat tempur: "
total: .asciiz "\nTotal biaya yang dikeluarkan adalah $"
.text
.globl main

main:
	# t0 = infantri
	# t1 = tank
	# t2 = pesawat tempur
	# t3 = tank + pesawat tempur
	# s0 = harga total infantri
	# s1 = harga total tank
	# s2 = harga total pesawat tempur
	# s4 = harga keseluruhan

	li $v0, 4		# menampilkan pesan infantri
	la $a0, infantri
	syscall
	li $v0, 5		# meminta input jumlah infantri
	syscall
	add $t0, $v0, $zero	# dan disimpan ke t0
	
	li $v0, 4		# menampilkan pesan tank
	la $a0, tank
	syscall
	li $v0, 5		# meminta input jumlah tank
	syscall
	add $t1, $v0, $zero	# dan disimpan ke t1
	
	li $v0, 4		# menampilkan pesan pesawat
	la $a0, pesawat
	syscall
	li $v0, 5		# meminta input jumlah pesawat tempur
	syscall
	add $t2, $v0, $zero	# dan disimpan ke t2
	
	
	mul $s0, $t0, 100	# jml infantri x 100
	mul $s1, $t1, 1500 	# jml tank x 1500
	mul $s2, $t2, 3000	# jml pesawat tempur x 3000
	
	add $t3, $t1, $t2	# jml tank + pesawat tempur
	
	# jika jumlah infantri >= jumlah tank + pesawat
	# maka akan masuk ke jumlahSemua
	#slt $t7, $t0, $t3
	#beq $t7, $zero, jumlahSemua
	bge $t0, $t3, jumlahSemua

	# jika jumlah infantri < jumlah tank + pesawat
	add $s4, $s1, $s2
	# menampilkan pesan akhir
	li $v0, 4
	la $a0, total
	syscall
	li $v0, 1
	add $a0, $s4, $zero
	syscall
	# lompat ke exit
	j exit
	
# menjumlahkan semua harga
jumlahSemua:
	add $s4, $s0, $s1
	add $s4, $s4, $s2
	
	# menampilkan pesan akhir
	li $v0, 4
	la $a0, total
	syscall
	li $v0, 1
	add $a0, $s4, $zero
	syscall
	
exit:
	li $v0, 10
	syscall
