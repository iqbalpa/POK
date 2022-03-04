.data
menu: .asciiz "Selamat datang di Kantin Pokpok Tercinta :D\n1. Nasi Ayam Goreng  (Rp 25)\n2. Nasi Udang Goreng (Rp 30)\n3. Nasi Ikan Goreng  (Rp 15)\n(Note: Harga dalam ribuan)\n"
jumlahPesanan: .asciiz "Masukkan jumlah pesanan: "
daftarPesanan: .asciiz "Daftar pesanan (Tuliskan dengan angka menu): \n"
satu: .asciiz "Nasi Ayam Goreng\n"
dua: .asciiz "Nasi Udang Goreng\n"
tiga: .asciiz "Nasi Ikan Goreng\n"
invalid: .asciiz "Masukkan Anda tidak valid\n"

terdapat: .asciiz "Terdapat "
pesanan: .asciiz " pesanan tidak valid\n"
total: .asciiz "Total harga pesanan anda (Dalam ribuan): "
.text

.globl main
main:
	li $v0, 4
	la $a0, menu
	syscall
	li $v0, 4
	la $a0, jumlahPesanan
	syscall
	li $v0, 5			# meminta input integer untuk jumlah pesanan
	syscall
	li $v0, 4
	la $a0, daftarPesanan
	syscall
	
	addi $s1, $zero, 1		# s1 = 1
	addi $s2, $zero, 2		# s2 = 2
	addi $s3, $zero, 3		# s3 = 3
	addi $s4, $zero, 25		# s4 = 25 (harga menu1)
	addi $s5, $zero, 30		# s5 = 30 (harga menu2)
	addi $s6, $zero, 15		# s6 = 15 (harga menu3)
	
	add $t2, $zero, $zero 		# t2 untuk menyimpan jumlah tak valid
	add $t3, $zero, $zero		# t3 untuk menyimpan total harga
	
	add $s0, $v0, $zero 		# menyimpan jumlah pesanan ke s0
	addi $t0, $zero, 1		# counter untuk looping
Loop:
	beq $t0, $s0, Exit
	addi $t0,$t0,1
	
	li $v0, 5			# meminta input integer untuk jenis pesanan
	syscall
	add $t1,$v0,$zero		# menyimpan input integer untuk jenis pesanan
	
	beq $t1, $s1, Menu1		# jika input = 1, maka masuk ke Menu1
	beq $t1, $s2, Menu2		# jika input = 2, maka masuk ke Menu2
	beq $t1, $s3, Menu3		# jika input = 3, maka masuk ke Menu3
	j Invalid			# jika input bukan 1/2/3, maka akan masuk ke Invalid
	
	Menu1:
		li $v0, 4
		la $a0, satu		# menampilkan pesanan
		syscall
		add $t3,$t3,$s4
		j Loop
	Menu2:
		li $v0, 4
		la $a0, dua		# menampilkan pesanan
		syscall
		add $t3,$t3,$s5
		j Loop
	Menu3:
		li $v0, 4
		la $a0, tiga 		# menampilkan pesanan
		syscall
		add $t3,$t3,$s6
		j Loop
	Invalid:
		li $v0, 4 	
		la $a0, invalid		# menampilkan pesan tidak valid
		syscall
		addi $t2,$t2,1
		j Loop
		
Exit:
	li $v0, 4
	la $a0, terdapat
	syscall
	li $v0, 1
	add $a0, $zero, $t2
	syscall
	li $v0, 4
	la $a0, pesanan
	syscall
	li $v0, 4
	la $a0, total
	syscall
	li $v0, 1
	add $t0, $t3, $zero
	syscall

	li $v0, 10
	syscall
