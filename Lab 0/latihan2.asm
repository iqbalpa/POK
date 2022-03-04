.data
menu: .asciiz "Selamat datang di Kantin Pokpok Tercinta :D\n1. Nasi Ayam Goreng  (Rp 25)\n2. Nasi Udang Goreng (Rp 30)\n3. Nasi Ikan Goreng  (Rp 15)\n(Note: Harga dalam ribuan)\n"
satu: .asciiz "Nasi Ayam Goreng"
dua: .asciiz "Nasi Udang Goreng"
tiga: .asciiz "Nasi Ikan Goreng"
prompt: .asciiz "Masukkan pesanan Anda (tuliskan dengan angka menu): "
info: .asciiz "Anda memesan: "
invalid: .asciiz "Masukkan Anda tidak valid\n\n"

.text

.globl main
main: 	

MintaInput:
	li $v0, 4 		# menampilkan seluruh menu
	la $a0, menu
	syscall
	li $v0, 4		# menampilkan pesan prompt
	la $a0, prompt
	syscall
	li $v0, 5 		# meminta input integer
	syscall
	
	addi $s1, $zero, 1	# s1 = 1
	addi $s2, $zero, 2	# s2 = 2
	addi $s3, $zero, 3	# s3 = 3
	add $t0, $v0, $zero	# menyimpan input ke t0
	
	beq $t0, $s1, Menu1	# jika input = 1, maka masuk ke Menu1
	beq $t0, $s2, Menu2	# jika input = 2, maka masuk ke Menu2
	beq $t0, $s3, Menu3	# jika input = 3, maka masuk ke Menu3
	j Invalid		# jika input bukan 1/2/3, maka akan masuk ke Invalid
	
	Menu1:
		li $v0, 4	
		la $a0, info	# menampilkan pesan info
		syscall
		li $v0, 4
		la $a0, satu	# menampilkan pesanan
		syscall
		li $v0, 10	# system exit
		syscall
	Menu2:
		li $v0, 4
		la $a0, info	# menampilkan pesan info
		syscall
		li $v0, 4
		la $a0, dua	# menampilkan pesanan
		syscall
		li $v0, 10	# system exit
		syscall
	Menu3:
		li $v0, 4
		la $a0, info	# menampilkan pesan info
		syscall
		li $v0, 4
		la $a0, tiga 	# menampilkan pesanan
		syscall
		li $v0, 10	# system exit
		syscall
	Invalid:
		li $v0, 4 	
		la $a0, invalid	# menampilkan pesan tidak valid
		syscall
		j MintaInput	# akan lompat ke awal lagi, hingga user memberi input yg benar